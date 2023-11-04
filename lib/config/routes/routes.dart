// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// Screens

// Helpers
import '../../feature/class/create_class/view/create_class.dart';
import '../../feature/home/view/home_view.dart';
// Helpers
import '../../feature/pre_login/experience_Info.dart';
import '../../feature/pre_login/financing_view.dart';
import '../../feature/pre_login/personal_info.dart';
import '../../feature/pre_login/teaching_info.dart';
import '../../feature/preference/view/preference_view.dart';
import '../../feature/rating/view/rating_view.dart';
import '../../feature/wallet/view/invoice_details.dart';
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
  static const String PrefrencesScreen = '/Pref-screen';
  static const String createClass = '/create-class';
  static const String RatingScreen = '/rating-screen';
  static const String invoiceDetails = '/invoice-details';
  static const String teachingInfo = '/teaching-info';
  static const String experienceInfo = '/experience-info';
  static const String financingView = '/financing-view';
  static const String personalInfo = '/personal-info';

  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    HomeScreenRoute: (_) => const HomeView(),
    PrefrencesScreen: (_) => const PreferenceView(),
    invoiceDetails: (_) => const InvoiceDetails(),
    RatingScreen: (_) => const RatingView(),
    teachingInfo: (_) => const TeachingInfo(),
    experienceInfo: (_) => const ExperienceInfo(),
    financingView: (_) => const FinancingView(),
    personalInfo: (_) => const PersonalInfo(),
    NotFoundScreenRoute: (_) => const SizedBox.shrink(),
    AppStartupScreenRoute: (_) => const SizedBox.shrink(),
    createClass: (_) => const CreateClass(),
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
