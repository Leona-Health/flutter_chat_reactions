import 'package:flutter/widgets.dart';

class MenuItem {
  final String label;
  final IconData? icon;
  final String? assetName;
  final bool isDestructive;
  final void Function()? onPressed;

  // contsructor
  const MenuItem({
    required this.label,
    this.onPressed,
    this.icon,
    this.isDestructive = false,
    this.assetName,
  });
}
