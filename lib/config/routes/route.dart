// ignore_for_file: constant_identifier_names, always_specify_types
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../feature/class/class_detail/view/class_detail.dart';
import '../../feature/class/create_class/view/create_class.dart';
import '../../feature/classDetails/view/class_details_view.dart';
import '../../feature/classDetails/view/rescheduleView/reschedule_class_view.dart';
import '../../feature/home/view/home_view.dart';
import '../../feature/home/view/view_all_class.dart';
import '../../feature/home_views/views/home_views.dart';
import '../../feature/home_views/views/reupload_documents.dart';
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
import '../../feature/setting_view/add_address_screen/view/add_address_view.dart';
import '../../feature/setting_view/app_support/view/app_support_view.dart';
import '../../feature/setting_view/change_name/view/change_name_view.dart';
import '../../feature/setting_view/change_password/view/change_password_view.dart';
import '../../feature/setting_view/manage_address/view/manage_address_view.dart';
import '../../feature/setting_view/manage_subscription/view/manage_subscription.dart';
import '../../feature/setting_view/view/setting_view.dart';
import '../../feature/setting_view/view/widget/app_support/new_ticket/view/new_ticket_view.dart';
import '../../feature/setting_view/view/widget/app_support/pending_tickets/view/pending_tickets.dart';
import '../../feature/setting_view/view/widget/available_times_view.dart';
import '../../feature/setting_view/view/widget/calender_view/manage_added_time_view.dart';
import '../../feature/splash/view/splash_view.dart';
import '../../feature/tutorial/addMobileNumber/view/add_mobile_number_view.dart';
import '../../feature/tutorial/changeMobileNumber/view/change_mobile_number_view.dart';
import '../../feature/tutorial/chat/view/chat_view.dart';
import '../../feature/tutorial/emailEnter/view/email_view.dart';
import '../../feature/tutorial/language/view/language_view.dart';
import '../../feature/tutorial/login/view/login_view.dart';
import '../../feature/tutorial/messages/view/message_view.dart';
import '../../feature/tutorial/mobileEnter/view/mobile_view.dart';
import '../../feature/tutorial/onboarding/view/onboading_view.dart';
import '../../feature/tutorial/password/view/password_view.dart';
import '../../feature/tutorial/profileSet/view/profile_selection_view.dart';
import '../../feature/tutorial/userInfo/view/user_info_view.dart';
import '../../feature/tutorial/verify_otp/verify_otp_view/verify_otp_view.dart';
import '../../feature/tutorial/view/forgot_password_view.dart';
import '../../feature/tutorial/view/reset_password_link.dart';
import '../../feature/wallet/addBank/view/add_bank_view.dart';
import '../../feature/wallet/view/invoice_details.dart';
import '../../feature/wallet/view/view_all_view.dart';
import '../../feature/wallet/view/withdraw.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The route to be loaded in case of unrecognized route name
  static const String fallbackRoute = NotFoundScreenRoute;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// The route to be loaded when app launches
  static const String initialRoute = AppStartupScreenRoute;

  /// The name of the route for app startup screen
  static const String AppStartupScreenRoute = '/app-startup-screen';
  static const String AppRootRoute = '/';

  /// The name of the route for home dashboard screen
  static const String HomeScreenRoute = '/home-screen';
  static const String PreferencesScreen = '/Pref-screen';
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
  static const String manageAddressView = '/manageAddressView';
  static const String availableTimesView = '/availableTimesView';
  static const String changeNameView = '/changeNameView';
  static const String appSupportView = '/appSupportView';
  static const String manageSubscription = '/manageSubscription';
  static const String classDetailsView = '/classDetailsView';
  static const String proposalDetailsView = '/proposalDetailsView';
  static const String createProposal = '/createProposal';
  static const String reUploadDocument = '/reUploadDocument';
  static const String newTicketView = '/newTicketView';
  static const String addAddressView = '/addAddressView';
  static const String manageAddedTimeView = '/manageAddedTimeView';
  static const String onBoardingView = '/onBoardingView';
  static const String addBankView = '/addBankView';
  static const String withdrawView = '/withdrawView';
  static const String viewAllView = '/viewAllView';
  static const String languageView = '/languageView';
  static const String pendingTickets = '/pendingTickets';
  static const String viewAllClass='/viewAllClass';
  static const String rescheduleClass='/rescheduleClass';


  /// The name of the route for unrecognized route screen
  static const String NotFoundScreenRoute = '/route-not-found-screen';

  static List<GetPage<dynamic>> router = [
    GetPage(name: AppRootRoute, page: () => const SplashView()),
    GetPage(name: HomeScreenRoute, page: () => const HomeView()),
    GetPage(name: PreferencesScreen, page: () => const PreferenceView()),
    GetPage(name: invoiceDetails, page: () => const InvoiceDetails()),
    GetPage(name: RatingScreen, page: () => const RatingView()),
    GetPage(name: teachingInfo, page: () => const TeachingInfo()),
    GetPage(name: experienceInfo, page: () => const ExperienceInfo()),
    GetPage(name: financingView, page: () => const FinancingView()),
    GetPage(name: personalInfo, page: () => const PersonalInfo()),
    GetPage(name: NotFoundScreenRoute, page: () => const SizedBox.shrink()),
    GetPage(name: AppStartupScreenRoute, page: () => const SizedBox.shrink()),
    GetPage(name: createClass, page: () => const CreateClass()),
    GetPage(name: emailView, page: () => EmailView()),
    GetPage(name: mobileView, page: () => MobileView()),
    GetPage(name: addMobileView, page: () => AddMobileNumberView()),
    GetPage(name: changeMobileNumberView, page: () => ChangeMobileNumberView()),
    GetPage(name: userInfoView, page: () => UserInfoView()),
    GetPage(name: loginView, page: () => LoginView()),
    GetPage(name: forgotPasswordView, page: () => ForgotPassWordView()),
    GetPage(name: restPassword, page: () => const ResetPassword()),
    GetPage(name: passwordView, page: () => const PasswordView()),
    GetPage(name: changePasswordView, page: () => const ChangePasswordView()),
    GetPage(name: homeViews, page: () => const HomeViews()),
    GetPage(name: searchView, page: () => const SearchView()),
    GetPage(name: settingView, page: () => const SettingView()),
    GetPage(name: messageView, page: () => const MessageView()),
    GetPage(name: notificationView, page: () => const NotificationView()),
    GetPage(name: chatView, page: () => const ChatView()),
    GetPage(name: verifyOtpView, page: () => VerifyOtpView()),
    GetPage(name: profileSelectionView, page: () => ProfileSelectionView()),
    GetPage(name: profileView, page: () => const ProfileView()),
    GetPage(name: classDetail, page: () => const ClassDetail()),
    GetPage(name: changeNameView, page: () => const ChangeNameView()),
    GetPage(name: appSupportView, page: () => const AppSupportView()),
    GetPage(name: manageSubscription, page: () => const ManageSubscription()),
    GetPage(name: proposalDetailsView, page: () => const ProposalDetailsView()),
    GetPage(name: createProposal, page: () => const CreateProposal()),
    GetPage(name: manageAddressView, page: () => const ManageAddressScreen()),
    GetPage(name: availableTimesView, page: () => const AvailableTimesView()),
    GetPage(name: reUploadDocument, page: () => const ReUploadDocument()),
    GetPage(name: newTicketView, page: () => const NewTicketView()),
    GetPage(name: addAddressView, page: () => AddAddressScreen()),
    GetPage(name: manageAddedTimeView, page: () => const ManageAddedTimeView()),
    GetPage(name: onBoardingView, page: () => OnBoardingView()),
    GetPage(name: addBankView, page: () => AddBankView()),
    GetPage(name: withdrawView, page: () => const WithDrawScreen()),
    GetPage(name: viewAllView, page: () => const ViewAllView()),
    GetPage(name: languageView, page: () => LanguageView()),
    GetPage(name: pendingTickets, page: () => const PendingTickets()),
    GetPage(name: viewAllClass, page: () =>  ViewAllClass()),
    GetPage(name: rescheduleClass, page: () =>  const RescheduleClass()),


    GetPage(
      name: classDetailsView,
      page: () => const ClassDetailsView(),
    )
  ];
}
