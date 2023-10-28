import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar_item.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {

  NavBar({super.key, 
    this.index = 0,
    this.borderRadius = 15.0,
    this.cardWidth,
    this.showTitle = false,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.white,
    this.resizeToAvoidBottomInset = false,
    required this.horizontalPadding,
    required this.items,
    required this.color,
    required this.hapticFeedback,
  })  : assert(items.length > 1),
        assert(items.length <= 5);
  /// NavBar
  ///
  /// [NavBar] Base class for the bottom navigation bar

  /// The current page index
  int index;

  /// The items to be displayed on the navbar
  List<NavBarItem> items;

  /// The color of the navbar card
  Color color;

  /// The color of unselected page icons
  Color unselectedIconColor;

  /// The color of selected page icons
  Color selectedIconColor;

  /// The horizontal padding between the navbar card and the page
  double horizontalPadding;

  /// Allow haptic feedback on page change
  bool hapticFeedback;

  /// The border radius of the navbar card
  double borderRadius;

  /// The width of the navbar card
  double? cardWidth;

  /// Make use of titles/labels instead of the dot indicator
  bool showTitle;

  bool resizeToAvoidBottomInset;

  @override
  _NavBarState createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              children: widget.items.map((NavBarItem item) => item.page).toList(),
              onPageChanged: (int index) => _changePage(index),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: widget.horizontalPadding,
                ),
                child: SizedBox(
                  height: 70,
                  width: widget.cardWidth ?? MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 15.0,
                    color: widget.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          _widgetsBuilder(widget.items, widget.hapticFeedback),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_NavBarItem] will build and return a [NavBar] item widget
  Widget _NavBarItem(
      NavBarItem item, int index, bool hapticFeedback) {
    // If showTitle is set to true then no [NavBarItem] can have no title
    if (widget.showTitle && item.title.isEmpty) {
      throw Exception(
          'Show title set to true: Missing NavBarItem title!');
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // If haptic feedback is set to true then use mediumImpact on NavBarItem tap
            if (hapticFeedback) {
              HapticFeedback.mediumImpact();
            }
            _changePage(index);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            width: 50,
            child: item.useImageIcon
                ? item.icon
                : Icon(
                    item.iconData,
                    color: widget.index == index
                        ? widget.selectedIconColor
                        : widget.unselectedIconColor,
                  ),
          ),
        ),
        if (widget.showTitle) AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                child: widget.index == index
                    ? Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: widget.index == index
                              ? widget.selectedIconColor
                              : widget.unselectedIconColor,
                        ),
                      )
                    : Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: widget.index == index
                              ? widget.selectedIconColor
                              : widget.unselectedIconColor,
                        ),
                      ),
              ) else Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.index == index
                      ? widget.selectedIconColor
                      : Colors.transparent,
                ),
              ),
      ],
    );
  }

  /// [_widgetsBuilder] adds widgets from [_NavBarItem] into a List<Widget> and returns the list
  List<Widget> _widgetsBuilder(
      List<NavBarItem> items, bool hapticFeedback) {
    final List<Widget> NavBarItems = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      final Widget item = _NavBarItem(items[i], i, hapticFeedback);
      NavBarItems.add(item);
    }
    return NavBarItems;
  }

  /// [_changePage] changes selected page index so as to change the page being currently viewed by the user
  _changePage(index) {
    _pageController.jumpToPage(index);
    setState(() {
      widget.index = index;
    });
  }
}
