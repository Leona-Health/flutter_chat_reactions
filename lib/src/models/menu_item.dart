import 'package:flutter/widgets.dart';

class MenuItem {
  final String label;
  final IconData? icon;
  final String? assetName;
  final bool isDestructive;

  // contsructor
  const MenuItem({
    required this.label,
    this.icon,
    this.isDestructive = false,
    this.assetName,
  });
}
