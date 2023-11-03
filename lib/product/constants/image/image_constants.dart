import '../app/app_constants.dart';

class ImageConstants {
  ImageConstants._init();

  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  String get logo => toPng('furkan');

  String toPng(String name) => 'assets/image/$name.png';



  //     ======================= Images =======================     //

  static const String avtar = '${ApplicationConstants.imagePath}avtar.png';
  static const String appBarBG = '${ApplicationConstants.imagePath}appbar_bg.png';
  static const String teacherAvtar = '${ApplicationConstants.imagePath}teacher_avtar.png';
  static const String starSecondary = '${ApplicationConstants.imagePath}star_secondary.png';
  static const String successCircle = '${ApplicationConstants.imagePath}success_circle.png';
  static const String applePayLogo = '${ApplicationConstants.imagePath}apple_pay_logo.png';
  static const String gPayLogo = '${ApplicationConstants.imagePath}gpay_logo.png';
  static const String kNetLogo = '${ApplicationConstants.imagePath}kenet_logo.png';
  static const String mastercardLogo = '${ApplicationConstants.imagePath}master_card_logo.png';
  static const String visaLogo = '${ApplicationConstants.imagePath}visa_logo.png';
  static const String warningCircle = '${ApplicationConstants.imagePath}warning_circle.png';
  static const String starBlue = '${ApplicationConstants.imagePath}star_blue.png';
  static const String starGrey = '${ApplicationConstants.imagePath}star_grey.png';
  static const String failCircle = '${ApplicationConstants.imagePath}fail_circle.png';



  //     ======================= Icon Images =======================     //

  static const String messageIcon = '${ApplicationConstants.iconPath}message_icon.png';
  static const String saveIcon = '${ApplicationConstants.iconPath}save_icon.png';
  static const String searchIcon = '${ApplicationConstants.iconPath}search_icon.png';
  static const String bellIcon = '${ApplicationConstants.iconPath}bell_icon.png';
  static const String layersIcon = '${ApplicationConstants.iconPath}layers_icon.png';
  static const String groupIcon = '${ApplicationConstants.iconPath}group_icon.png';
  static const String moneyIcon = '${ApplicationConstants.iconPath}money_Icon.png';
  static const String timerIcon = '${ApplicationConstants.iconPath}timer_icon.png';
  static const String dateIcon = '${ApplicationConstants.iconPath}date_icon.png';
  static const String countryIcon = '${ApplicationConstants.iconPath}country_icon.png';
  static const String reviewStarPurple = '${ApplicationConstants.iconPath}review_star_purpule.png';
  static const String reviewStar = '${ApplicationConstants.iconPath}review_star.png';
  static const String proIcon = '${ApplicationConstants.iconPath}pro_icon.png';

  static const String acceptedStatus = '${ApplicationConstants.iconPath}accepted_icon.png';
  static const String cancellingStatus = '${ApplicationConstants.iconPath}cancelling_icon.png';
  static const String inCompletedStatus = '${ApplicationConstants.iconPath}incompleted_icon.png';
  static const String pendingStatus = '${ApplicationConstants.iconPath}pending_icon.png';
  static const String reschedulingStatus = '${ApplicationConstants.iconPath}rescheduling_icon.png';
  static const String doBookmark = '${ApplicationConstants.iconPath}do_bookmark.png';
  static const String removeBookmark = '${ApplicationConstants.iconPath}remove_bookmark.png';
  static const String pinLocation = '${ApplicationConstants.iconPath}pin_location.png';
  static const String infoIcon = '${ApplicationConstants.iconPath}info_icon.png';
  static const String deleteIcon = '${ApplicationConstants.iconPath}delete_icon.png';
  static const String editIcon = '${ApplicationConstants.iconPath}edit_icon.png';
  static const String closeIcon = '${ApplicationConstants.iconPath}close_icon.png';
  static const String payingIcon = '${ApplicationConstants.iconPath}paying_icon.png';
  static const String walletIcon = '${ApplicationConstants.iconPath}wallet_icon.png';
  static const String readBookIcon = '${ApplicationConstants.iconPath}read_book_icon.png';
  static const String filterIcon = '${ApplicationConstants.iconPath}filter_icon.png';
  static const String forwardIcon = '${ApplicationConstants.iconPath}forward_errow.png';

}
