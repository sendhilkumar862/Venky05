// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Screens

// Helpers
import '../../feature/home/view/home_view.dart';


// Helpers
import '../../product/constants/typedefs.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The route to be loaded in case of unrecognized route name
  static const String fallbackRoute = NotFoundScreenRoute;

  /// The route to be loaded when app launches
  static const String initialRoute = AppStartupScreenRoute;

  /// The name of the route for app startup screen
  static const String AppStartupScreenRoute = '/app-startup-screen';

  /// The name of the route for home dashboard screen
  static const String HomeScreenRoute = '/home-screen';

  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    HomeScreenRoute: (_) => const HomeView(),
    NotFoundScreenRoute: (_) => const SizedBox.shrink(),
    AppStartupScreenRoute: (_) => const SizedBox.shrink(),
  };

  static RouteBuilder getRoute(String? routeName) {
    return routeExists(routeName)
        ? _routesMap[routeName]!
        : _routesMap[Routes.NotFoundScreenRoute]!;
  }

  static bool routeExists(String? routeName) {
    return _routesMap.containsKey(routeName);
  }
}
