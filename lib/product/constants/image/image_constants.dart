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
  static const String acceptedStatus = '${ApplicationConstants.imagePath}accepted_status.png';
  static const String canceledStatus = '${ApplicationConstants.imagePath}canceled_status.png';
  static const String cancellingStatus = '${ApplicationConstants.imagePath}cancelling_status.png';
  static const String completedStatus = '${ApplicationConstants.imagePath}completed_status.png';
  static const String createdStatus = '${ApplicationConstants.imagePath}created_status.png';
  static const String incompleteStatus = '${ApplicationConstants.imagePath}incomplete_status.png';
  static const String pendingStatus = '${ApplicationConstants.imagePath}pending_status.png';
  static const String reschedulingStatus = '${ApplicationConstants.imagePath}rescheduling_status.png';


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

}
