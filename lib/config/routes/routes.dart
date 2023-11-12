// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

import '../../feature/class/create_class/view/create_class.dart';
import '../../feature/home/view/home_view.dart';
// Helpers
import '../../feature/home_views/views/home_views.dart';
import '../../feature/pre_login/experience_Info.dart';
import '../../feature/pre_login/financing_view.dart';
import '../../feature/pre_login/personalInfo/view/personal_info.dart';
import '../../feature/pre_login/rest_password_link.dart';
import '../../feature/pre_login/teachingInfo/view/teaching_info.dart';
import '../../feature/preference/view/preference_view.dart';
import '../../feature/rating/view/rating_view.dart';
import '../../feature/tutorial/emailEnter/email_view.dart';
import '../../feature/tutorial/emailotp/email_otp_view.dart';
import '../../feature/tutorial/emailotp/email_otp_view_model.dart';
import '../../feature/tutorial/mobileEnter/mobile_view.dart';
import '../../feature/tutorial/mobileotp/mobile_otp_view.dart';
import '../../feature/search/view/search_view.dart';
import '../../feature/tutorial/view/forgot_password_view.dart';
import '../../feature/tutorial/view/login_view.dart';
import '../../feature/tutorial/view/password_view.dart';
import '../../feature/tutorial/view/user_info_view.dart';
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
  static const String mobileOtpView = '/otp-view';
  static const String emailView = '/email-view';
  static const String mobileView = '/mobile-view';
  static const String userInfoView = '/user-info-view';
  static const String loginView = '/login-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String restPassword = '/reset-password-view';
  static const String passwordView = '/password-view';
  static const String homeViews = '/home-views';
  static const String emailOtpView = '/email-otp-views';
  static const String resetPassword = '/rest-Password';
  static const String searchView = '/search';

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
    mobileOtpView: (_) => const MobileOtpView(),
    emailView: (_) => const EmailView(),
    mobileView: (_) => const MobileView(),
    userInfoView: (_) => const UserInfoView(),
    loginView: (_) => const LoginView(),
    forgotPasswordView: (_) => const ForgotPassWordView(),
    restPassword: (_) =>  const RestPassword(),
    passwordView: (_) =>  const PasswordView(),
    homeViews: (_) =>  const HomeViews(),
    emailOtpView: (_) =>  const EmailOtpView(),
    resetPassword: (_) => const RestPassword(),
    passwordView: (_) => const PasswordView(),
    homeViews: (_) => const HomeViews(),
    searchView: (_) => const SearchView(),
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
