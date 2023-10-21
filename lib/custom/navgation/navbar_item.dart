import 'package:flutter/material.dart';

/// NavBarItem
///
/// [NavBarItem] Base class for the bottom navigation bar items
class NavBarItem {
  /// IconData to display on the navbar e.g. Icons.home
  IconData? iconData;

  /// Title can used instead of the dot indicator
  String title;

  bool useImageIcon;

  ImageIcon? icon;

  /// The page that corresponds to this item
  Widget page;
  NavBarItem({
    this.iconData,
    this.useImageIcon = false,
    this.icon,
    required this.title,
    required this.page,
  });
}