// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

import '../../feature/class/address/view/address_view.dart';
import '../../feature/class/class_detail/view/class_detail.dart';
import '../../feature/class/create_class/view/create_class.dart';
import '../../feature/classDetails/view/class_details_view.dart';
import '../../feature/home/view/home_view.dart';
// Helpers
import '../../feature/home_views/views/home_views.dart';
import '../../feature/notification/view/notification.dart';
import '../../feature/pre_login/experianceInfo/view/experience_Info.dart';
import '../../feature/pre_login/financeInfo/view/financing_view.dart';
import '../../feature/pre_login/personalInfo/view/personal_info.dart';
import '../../feature/pre_login/teachingInfo/view/teaching_info.dart';
import '../../feature/preference/view/preference_view.dart';
import '../../feature/profile/view/profile_view.dart';
import '../../feature/proposal/create_proposal/view/create_proposal.dart';
import '../../feature/proposal/proposol_details/view/proposal_detail_view.dart';
import '../../feature/rating/view/rating_view.dart';
import '../../feature/search/view/search_view.dart';
import '../../feature/setting_view/app_support/view/app_support_view.dart';
import '../../feature/setting_view/change_name/view/change_name_view.dart';
import '../../feature/setting_view/change_password/view/change_password_view.dart';
import '../../feature/setting_view/manage_subscription/view/manage_subscription.dart';
import '../../feature/setting_view/view/setting_view.dart';
import '../../feature/tutorial/addMobileNumber/view/add_mobile_number_view.dart';
import '../../feature/tutorial/changeMobileNumber/view/change_mobile_number_view.dart';
import '../../feature/tutorial/chat/view/chat_view.dart';
import '../../feature/tutorial/emailEnter/view/email_view.dart';
import '../../feature/tutorial/login/view/login_view.dart';
import '../../feature/tutorial/messages/view/message_view.dart';
import '../../feature/tutorial/mobileEnter/view/mobile_view.dart';
import '../../feature/tutorial/password/view/password_view.dart';
import '../../feature/tutorial/profileSet/view/profile_selection_view.dart';
import '../../feature/tutorial/userInfo/view/user_info_view.dart';
import '../../feature/tutorial/verify_otp/verify_otp_view/verify_otp_view.dart';
import '../../feature/tutorial/view/forgot_password_view.dart';
import '../../feature/tutorial/view/reset_password_link.dart';
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
  static const String emailView = '/email-view';
  static const String mobileView = '/mobile-view';
  static const String addMobileView = '/add_mobile-view';
  static const String changeMobileNumberView = '/change-mobile-view';
  static const String userInfoView = '/user-info-view';
  static const String loginView = '/login-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String restPassword = '/reset-password-view';
  static const String passwordView = '/password-view';
  static const String changePasswordView = '/change-password-view';
  static const String homeViews = '/home-views';
  static const String resetPassword = '/rest-Password';
  static const String searchView = '/search';
  static const String settingView = '/setting';
  static const String messageView = '/message';
  static const String notificationView = '/notification-view';
  static const String chatView = '/chatView';
  static const String verifyOtpView = '/verifyOtpView';
  static const String profileSelectionView = '/profileSelectionView';
  static const String profileView = '/profileView';
  static const String classDetail = '/classDetail';
  static const String addressView = '/addressView';
  static const String changeNameView = '/changeNameView';
  static const String appSupportView = '/appSupportView';
  static const String manageSubscription = '/manageSubscription';
  static const String classDetailsView = '/classDetailsView';
  static const String proposalDetailsView = '/proposalDetailsView';
  static const String createProposal = '/createProposal';

  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  static final Map<String, RouteBuilder> _routesMap = <String, RouteBuilder>{
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
    // mobileOtpView: (_) => const MobileOtpView(),
    emailView: (_) => const EmailView(),
    mobileView: (_) =>  MobileView(),
    addMobileView: (_) =>  AddMobileNumberView(),
    changeMobileNumberView: (_) =>  ChangeMobileNumberView(),
    userInfoView: (_) => const UserInfoView(),
    loginView: (_) =>  LoginView(),
    forgotPasswordView: (_) => const ForgotPassWordView(),
    restPassword: (_) => const ResetPassword(),
    passwordView: (_) => PasswordView(),
    changePasswordView: (_) => ChangePasswordView(),
    homeViews: (_) => const HomeViews(),
    searchView: (_) => const SearchView(),
    settingView: (_) => const SettingView(),
    messageView: (_) => const MessageView(),
    notificationView: (_) => const NotificationView(),
    chatView: (_) => const ChatView(),
    verifyOtpView: (_) => const VerifyOtpView(),
    profileSelectionView: (_) =>  ProfileSelectionView(),
    profileView: (_) => const ProfileView(),
    classDetail: (_) => const ClassDetail(),
    addressView: (_) => const AddressView(),
    changeNameView: (_) => const ChangeNameView(),
    appSupportView: (_) => const AppSupportView(),
    manageSubscription: (_) => const ManageSubscription(),
    classDetailsView: (_) => const ClassDetailsView(),
    proposalDetailsView: (_) => const ProposalDetailsView(),
    createProposal: (_) => const CreateProposal(),
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
