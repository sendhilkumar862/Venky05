import '../app/app_constants.dart';

class ImageConstants {
  ImageConstants._init();

  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  String get logo => toPng('furkan');

  String toPng(String name) => 'assets/image/$name.png';

  //     ======================= Animations =======================     //
  static const String globe = '${ApplicationConstants.animationPath}Globe.json';
  static const String profileManager =
      '${ApplicationConstants.animationPath}profile_manager.json';
  static const String onlineStudy =
      '${ApplicationConstants.animationPath}online_study.json';
  static const String book = '${ApplicationConstants.animationPath}Book.json';
  static const String education =
      '${ApplicationConstants.animationPath}Education.json';
  static const String mailApproved =
      '${ApplicationConstants.animationPath}mail_approved.json';
  static const String timetable =
      '${ApplicationConstants.animationPath}timetable.json';
  static const String splash =
      '${ApplicationConstants.animationPath}Hassa.json';
  static const String animPreference =
      '${ApplicationConstants.animationPath}preference_young_man.json';

  static const String loader =
      '${ApplicationConstants.animationPath}loader.json';

  //     ======================= Images =======================     //

  static const String appBarBG =
      '${ApplicationConstants.imagePath}appbar_bg.png';
  static const String avtar = '${ApplicationConstants.imagePath}avtar.png';
  static const String teacherAvtar =
      '${ApplicationConstants.imagePath}teacher_avtar.png';
  static const String starSecondary =
      '${ApplicationConstants.imagePath}star_secondary.png';
  static const String successCircle =
      '${ApplicationConstants.imagePath}success_circle.png';
  static const String applePayLogo =
      '${ApplicationConstants.imagePath}apple_pay_logo.png';
  static const String gPayLogo =
      '${ApplicationConstants.imagePath}gpay_logo.png';
  static const String kNetLogo =
      '${ApplicationConstants.imagePath}kenet_logo.png';
  static const String mastercardLogo =
      '${ApplicationConstants.imagePath}master_card_logo.png';
  static const String visaLogo =
      '${ApplicationConstants.imagePath}visa_logo.png';
  static const String warningCircle =
      '${ApplicationConstants.imagePath}warning_circle.png';
  static const String starBlue =
      '${ApplicationConstants.imagePath}star_blue.png';
  static const String starGrey =
      '${ApplicationConstants.imagePath}star_grey.png';
  static const String failCircle =
      '${ApplicationConstants.imagePath}fail_circle.png';
  static const String starWhite =
      '${ApplicationConstants.imagePath}start_white.png';
  static const String splashBG =
      '${ApplicationConstants.imagePath}splash_bg.png';
  static const String primaryLogo =
      '${ApplicationConstants.imagePath}primary_logo_white.png';
  static const String primaryLogoBlue =
      '${ApplicationConstants.imagePath}primary_logo_blue.png';
  static const String patter = '${ApplicationConstants.imagePath}patters.png';
  static const String certificates =
      '${ApplicationConstants.imagePath}certificates.png';
  static const String document =
      '${ApplicationConstants.imagePath}document.png';
  static const String dummyImage =
      '${ApplicationConstants.imagePath}dummy_image.png';

  //     ======================= Icon Images =======================     //

  static const String messageIcon =
      '${ApplicationConstants.iconPath}message_icon.png';
  static const String circleGrey =
      '${ApplicationConstants.iconPath}circle_grey.png';

  static const String checkBox =
      '${ApplicationConstants.iconPath}checkbox_circles.png';
  static const String saveIcon =
      '${ApplicationConstants.iconPath}save_icon.png';
  static const String searchIcon =
      '${ApplicationConstants.iconPath}search_icon.png';
  static const String bellIcon =
      '${ApplicationConstants.iconPath}bell_icon.png';
  static const String layersIcon =
      '${ApplicationConstants.iconPath}layers_icon.png';
  static const String groupIcon =
      '${ApplicationConstants.iconPath}group_icon.png';
  static const String moneyIcon =
      '${ApplicationConstants.iconPath}money_Icon.png';
  static const String timerIcon =
      '${ApplicationConstants.iconPath}timer_icon.png';
  static const String dateIcon =
      '${ApplicationConstants.iconPath}date_icon.png';
  static const String countryIcon =
      '${ApplicationConstants.iconPath}country_icon.png';
  static const String reviewStarPurple =
      '${ApplicationConstants.iconPath}review_star_purpule.png';
  static const String reviewStar =
      '${ApplicationConstants.iconPath}review_star.png';
  static const String proIcon = '${ApplicationConstants.iconPath}pro_icon.png';

  static const String ellipse1 = '${ApplicationConstants.iconPath}ellipse.png';
  static const String penEdit = '${ApplicationConstants.iconPath}pen_edit.svg';
  static const String delete = '${ApplicationConstants.iconPath}delete.svg';
  static const String acceptedStatus =
      '${ApplicationConstants.iconPath}accepted_icon.png';
  static const String cancellingStatus =
      '${ApplicationConstants.iconPath}cancelling_icon.png';
  static const String inCompletedStatus =
      '${ApplicationConstants.iconPath}incompleted_icon.png';
  static const String pendingStatus =
      '${ApplicationConstants.iconPath}pending_icon.png';
  static const String reschedulingStatus =
      '${ApplicationConstants.iconPath}rescheduling_icon.png';
  static const String doBookmark =
      '${ApplicationConstants.iconPath}do_bookmark.png';
  static const String removeBookmark =
      '${ApplicationConstants.iconPath}remove_bookmark.png';
  static const String pinLocation =
      '${ApplicationConstants.iconPath}pin_location.png';
  static const String infoIcon =
      '${ApplicationConstants.iconPath}info_icon.png';
  static const String deleteIcon =
      '${ApplicationConstants.iconPath}delete_icon.png';
  static const String editIcon =
      '${ApplicationConstants.iconPath}edit_icon.png';
  static const String closeIcon =
      '${ApplicationConstants.iconPath}close_icon.png';
  static const String payingIcon =
      '${ApplicationConstants.iconPath}paying_icon.png';
  static const String walletIcon =
      '${ApplicationConstants.iconPath}wallet_icon.png';
  static const String readBookIcon =
      '${ApplicationConstants.iconPath}read_book_icon.png';
  static const String filterIcon =
      '${ApplicationConstants.iconPath}filter_icon.png';
  static const String forwardIcon =
      '${ApplicationConstants.iconPath}forward_right.svg';
  static const String downIcon =
      '${ApplicationConstants.iconPath}arrow_down.png';
  static const String usIcon = '${ApplicationConstants.iconPath}US.png';
  static const String usIconNew =
      '${ApplicationConstants.iconPath}united_states_new.png';
  static const String bookPerson =
      '${ApplicationConstants.iconPath}book_person.png';
  static const String graduateIcon =
      '${ApplicationConstants.iconPath}graduate_hat.png';
  static const String backIcon =
      '${ApplicationConstants.iconPath}back_icon.png';
  static const String arrowRotate =
      '${ApplicationConstants.iconPath}arrow_rotate.png';
  static const String eyeCross = '${ApplicationConstants.iconPath}eye_cros.png';
  static const String bahrain = '${ApplicationConstants.iconPath}bahrain.png';
  static const String oman = '${ApplicationConstants.iconPath}oman.png';
  static const String qatar = '${ApplicationConstants.iconPath}qatar.png';
  static const String saudiArabia =
      '${ApplicationConstants.iconPath}saudi_arabia.png';
  static const String saudiArabiaNew =
      '${ApplicationConstants.iconPath}saudi_arabia_new.png';
  static const String uae = '${ApplicationConstants.iconPath}uae.png';
  static const String infoRoundCircle =
      '${ApplicationConstants.iconPath}infornation.png';
  static const String checkbox =
      '${ApplicationConstants.iconPath}checkbox_circle.png';
  static const String checkboxFilled =
      '${ApplicationConstants.iconPath}checkbox_circle_filled.png';
  static const String checkboxSqure =
      '${ApplicationConstants.iconPath}checkbox_sqare.png';
  static const String checkboxSqureFilled =
      '${ApplicationConstants.iconPath}checkbox_suqare_filled.png';
  static const String faceId = '${ApplicationConstants.iconPath}face_lock.png';

  static const String unFillCircle =
      '${ApplicationConstants.iconPath}un_fill_circle.svg';
  static const String warningIcon =
      '${ApplicationConstants.iconPath}warning.png';
  static const String eye = '${ApplicationConstants.iconPath}eye.svg';
  static const String filterSort =
      '${ApplicationConstants.iconPath}filter-sort.svg';
  static const String documentBox =
      '${ApplicationConstants.iconPath}archivedocumentsbox.svg';
  static const String doneMessage =
      '${ApplicationConstants.iconPath}done_message_status.svg';
  static const String phoneCall =
      '${ApplicationConstants.iconPath}phone-call.svg';
  static const String warning =
      '${ApplicationConstants.iconPath}warning-circle.svg';
  static const String upDownArrow =
      '${ApplicationConstants.iconPath}up_down_arrow.svg';

  static const String read = '${ApplicationConstants.iconPath}read.svg';
  static const String wallet = '${ApplicationConstants.iconPath}wallet.svg';
  static const String alert = '${ApplicationConstants.iconPath}alert.svg';
  static const String attach = '${ApplicationConstants.iconPath}attach.svg';
  static const String camera = '${ApplicationConstants.iconPath}camera.svg';
  static const String pictureSquare =
      '${ApplicationConstants.iconPath}picture_square.svg';

  static const String messageSeen =
      '${ApplicationConstants.iconPath}Message Status.svg';
  static const String sendMessage =
      '${ApplicationConstants.iconPath}send-message-solid.svg';
  static const String plusIcon =
      '${ApplicationConstants.iconPath}plus-medium.svg';
  static const String microPhone =
      '${ApplicationConstants.iconPath}microphone-mic-rec-circle-solid.svg';
  static const String messageDelete =
      '${ApplicationConstants.iconPath}message_delete.svg';
  static const String audioWaves =
      '${ApplicationConstants.iconPath}audio_waves.png';

  static const String pauseButton = '${ApplicationConstants.iconPath}pause.svg';
  static const String recordButton =
      '${ApplicationConstants.iconPath}record-button-circle-solid.svg';
  static const String cameraIcon =
      '${ApplicationConstants.iconPath}camera-photo.svg';
  static const String imageIcon =
      '${ApplicationConstants.iconPath}image-picture-square.svg';
  static const String documentFileClip =
      '${ApplicationConstants.iconPath}document-file-clip.svg';
  static const String doneCheckSingle =
      '${ApplicationConstants.iconPath}done_check_single.svg';
  static const String pauseIcon = '${ApplicationConstants.iconPath}pause.png';
  static const String playIcon = '${ApplicationConstants.iconPath}play.png';
  static const String filterSettings =
      '${ApplicationConstants.iconPath}filter_settings.svg';
  static const String clip = '${ApplicationConstants.iconPath}clip.svg';
  static const String cancel = '${ApplicationConstants.iconPath}cancel.svg';
  static const String done = '${ApplicationConstants.iconPath}star.svg';
  static const String inProgress =
      '${ApplicationConstants.iconPath}Iclock_time.svg';
  static const String check = '${ApplicationConstants.iconPath}check.svg';
  static const String audioWavesPlay =
      '${ApplicationConstants.iconPath}audio_waves_view.svg';
  static const String messageEdit =
      '${ApplicationConstants.iconPath}message_edit.svg';
  static const String replyMessage =
      '${ApplicationConstants.iconPath}reply_message.svg';
  static const String homeWalletIcon =
      '${ApplicationConstants.iconPath}icon_wallet.svg';
  static const String homeMessageIcon =
      '${ApplicationConstants.iconPath}icon_message.svg';
  static const String homeHomeIcon =
      '${ApplicationConstants.iconPath}icon_home.svg';
}
