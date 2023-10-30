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

}
