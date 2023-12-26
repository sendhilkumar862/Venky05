import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../product/constants/colors/app_colors_constants.dart';
import '../../product/utils/typography.dart';
import '../image/app_image_assets.dart';
import 'navbar_item.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  NavBar({
    super.key,
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
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: widget.items.map((NavBarItem item) => item.page).toList(),
              onPageChanged: (int index) => _changePage(index),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15,
                ),
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: AppColors.appWhite,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: AppColors.appBottomShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _widgetsBuilder(widget.items, widget.hapticFeedback),
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
  Widget _NavBarItem(NavBarItem item, int index, bool hapticFeedback) {
    if (widget.showTitle && item.title.isEmpty) {
      throw Exception('Show title set to true: Missing NavBarItem title!');
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (hapticFeedback) {
              HapticFeedback.mediumImpact();
            }
            _changePage(index);
          },
          child: Container(
              width: 50,
              child: item.useImageIcon
                  ? item.icon
                  : AppImageAsset(
                      image: widget.index == index ? item.selectedIconData! : item.iconData!,
                      color: widget.index == index ? widget.selectedIconColor : widget.unselectedIconColor)),
        ),
        const SizedBox(height: 3),
        if (widget.showTitle)
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            child: widget.index == index
                ? Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: openSans.fontFamily,
                      fontSize: 10,
                      color: widget.index == index ? widget.selectedIconColor : widget.unselectedIconColor,
                    ),
                  )
                : Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: openSans.fontFamily,
                      fontSize: 10,
                      color: widget.index == index ? widget.selectedIconColor : widget.unselectedIconColor,
                    ),
                  ),
          )
        else
          Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.index == index ? widget.selectedIconColor : Colors.transparent,
            ),
          ),
      ],
    );
  }

  /// [_widgetsBuilder] adds widgets from [_NavBarItem] into a List<Widget> and returns the list
  List<Widget> _widgetsBuilder(List<NavBarItem> items, bool hapticFeedback) {
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
