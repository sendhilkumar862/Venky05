import 'package:flutter/material.dart';

/// NavBarItem
///
/// [NavBarItem] Base class for the bottom navigation bar items
class NavBarItem {
  NavBarItem({
    this.iconData,
    this.selectedIconData,
    this.useImageIcon = false,
    this.icon,
    required this.title,
    required this.page,
  });
  /// IconData to display on the navbar e.g. Icons.home
  String? iconData;

  /// IconData to display on the navbar for selected e.g. Icons.home
  String? selectedIconData;

  /// Title can used instead of the dot indicator
  String title;

  bool useImageIcon;

  ImageIcon? icon;

  /// The page that corresponds to this item
  Widget page;
}
