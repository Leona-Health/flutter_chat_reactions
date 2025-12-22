import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/src/controllers/reactions_controller.dart';
import 'package:flutter_chat_reactions/src/models/chat_reactions_config.dart';
import 'package:flutter_chat_reactions/src/models/menu_item.dart';
import 'package:flutter_chat_reactions/src/widgets/message_bubble.dart';
import 'package:flutter_chat_reactions/src/widgets/rections_row.dart';

/// A dialog widget that displays reactions and context menu options for a message.
///
/// This widget creates a modal dialog with three main sections:
/// - A row of reaction emojis that can be tapped
/// - The original message (displayed using a Hero animation)
/// - A context menu with customizable options
class ReactionsDialogWidget extends StatefulWidget {
  /// Unique identifier for the hero animation.
  final String messageId;

  /// The widget displaying the message content.
  final Widget messageWidget;

  /// Controller to manage reaction state.
  final ReactionsController controller;

  /// Configuration for the reactions dialog.
  final ChatReactionsConfig config;

  /// Callback triggered when a reaction is selected.
  final Function(String) onReactionTap;

  /// Callback triggered when a context menu item is selected.
  final Function(MenuItem) onMenuItemTap;

  /// Alignment of the dialog components.
  final Alignment alignment;

  /// Creates a reactions dialog widget.
  const ReactionsDialogWidget({
    super.key,
    required this.messageId,
    required this.messageWidget,
    required this.controller,
    required this.config,
    required this.onReactionTap,
    required this.onMenuItemTap,
    this.alignment = Alignment.centerRight,
  });

  @override
  State<ReactionsDialogWidget> createState() => _ReactionsDialogWidgetState();
}

class _ReactionsDialogWidgetState extends State<ReactionsDialogWidget> {

  final _bubbleKey = GlobalKey();
  double _bubbleHeight = 0;

  bool get _isBubbleTallerThanScreen {
    final screenHeight = MediaQuery.of(context).size.height;
    return _bubbleHeight > screenHeight - 300;
  }

  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final box = _bubbleKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    setState(() => _bubbleHeight = box.size.height);
  }

  void _handleReactionTap(BuildContext context, String reaction) {
    Navigator.of(context).pop();
    widget.onReactionTap(reaction);
  }

  void _handleMenuItemTap(BuildContext context, MenuItem item) {
    Navigator.of(context).pop();
    widget.onMenuItemTap(item);
  }

   @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final alignment = widget.alignment;
    final maxBubbleHeight = MediaQuery.of(context).size.height * 0.8;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: config.dialogBlurSigma,
        sigmaY: config.dialogBlurSigma,
      ),
      child: Center(
        child: Padding(
          padding: config.dialogPadding,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(_isBubbleTallerThanScreen)
                    const SizedBox(height: 40),
                  
                  ReactionsRow(
                    reactions: config.availableReactions,
                    alignment: alignment,
                    onReactionTap: (reaction, _) =>
                        _handleReactionTap(context, reaction),
                  ),

                  const SizedBox(height: 10),
                  
                  ConstrainedBox(
                  constraints: BoxConstraints(
                    // Let it grow up to some portion of the screen height.
                    maxHeight: maxBubbleHeight,
                  ),
                  child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SingleChildScrollView(
                        child: MessageBubble(
                          key: _bubbleKey,
                          id: widget.messageId,
                          messageWidget: widget.messageWidget,
                          alignment: alignment,
                        ),
                      ),
                    ),
                  ),
                  


                  if (config.showContextMenu && !_isBubbleTallerThanScreen) ...[
                    const SizedBox(height: 10),
                    ContextMenuWidget(
                      menuItems: config.menuItems,
                      alignment: alignment,
                      onMenuItemTap: (item, _) => _handleMenuItemTap(context, item),
                      customMenuItemBuilder: config.customMenuItemBuilder,
                    ),
                  ],
                ],
              ),

              if (config.showContextMenu && _isBubbleTallerThanScreen)
                Positioned(
                  bottom: 100,
                  left: widget.alignment == Alignment.centerLeft ? 0 : null,
                  right: widget.alignment == Alignment.centerRight ? 0 : null,
                  child: ContextMenuWidget(
                    menuItems: config.menuItems,
                    alignment: alignment,
                    onMenuItemTap: (item, _) => _handleMenuItemTap(context, item),
                    customMenuItemBuilder: config.customMenuItemBuilder,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  
}

class ContextMenuWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final Alignment alignment;
  final double menuWidth;
  final Function(MenuItem, int) onMenuItemTap;
  final Widget Function(MenuItem, VoidCallback)? customMenuItemBuilder;

  const ContextMenuWidget({
    super.key,
    required this.menuItems,
    required this.onMenuItemTap,
    this.alignment = Alignment.centerRight,
    this.menuWidth = 0.45,
    this.customMenuItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: MediaQuery.of(context).size.width * menuWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2E2E2E)
              : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: menuItems.map(
            (item) {
              if (customMenuItemBuilder != null) {
                return customMenuItemBuilder!(
                  item,
                  () => onMenuItemTap(item, menuItems.indexOf(item)),
                );
              }
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onMenuItemTap(item, menuItems.indexOf(item)),
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                            color: item.isDestructive
                                ? Colors.red
                                : Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          item.icon,
                          color: item.isDestructive
                              ? Colors.red
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
