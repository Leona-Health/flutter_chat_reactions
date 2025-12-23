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
    this.menuWidth = 0.7,
    this.customMenuItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: alignment,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF2E2E2E)
                : const Color(0xFFFAFAFF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < menuItems.length; i++) ...[
                _buildMenuItem(context, menuItems[i], i, theme),
                if (i != menuItems.length - 1)
                  Divider(
                    height: 1,
                    thickness: 0.2,
                    color: theme.brightness == Brightness.dark 
                      ? const Color(0xFFFAFAFF) 
                      : const Color(0xFF2E2E2E),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    MenuItem item,
    int index,
    ThemeData theme,
  ) {
    if (customMenuItemBuilder != null) {
      return customMenuItemBuilder!(
        item,
        () => onMenuItemTap(item, index),
      );
    }

    final color = item.isDestructive
        ? Colors.red
        : theme.brightness == Brightness.dark
            ? Colors.white
            : Colors.black;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onMenuItemTap(item, index),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.label,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              if (item.assetName != null)
                Image.asset(
                  item.assetName!,
                  height: 20,
                  color: color,
                ),
              if (item.icon != null)
                Icon(
                  item.icon,
                  color: color,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}