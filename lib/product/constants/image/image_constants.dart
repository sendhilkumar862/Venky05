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


  //     ======================= Icon Images =======================     //

  static const String messageIcon = '${ApplicationConstants.iconPath}message_icon.png';
  static const String saveIcon = '${ApplicationConstants.iconPath}save_icon.png';
  static const String searchIcon = '${ApplicationConstants.iconPath}search.png';
  static const String bellIcon = '${ApplicationConstants.iconPath}bell.png';
  static const String layersIcon = '${ApplicationConstants.iconPath}layers.png';
  static const String groupIcon = '${ApplicationConstants.iconPath}group_icon.png';
  static const String moneyIcon = '${ApplicationConstants.iconPath}money_Icon.png';
  static const String timerIcon = '${ApplicationConstants.iconPath}timer_icon.png';
  static const String dateIcon = '${ApplicationConstants.iconPath}date_icon.png';
  static const String countryIcon = '${ApplicationConstants.iconPath}country_icon.png';
  static const String reviewStarPurple = '${ApplicationConstants.iconPath}review_star_purpule.png';
  static const String reviewStar = '${ApplicationConstants.iconPath}review_star.png';

}
