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
  static const String emptyState =
      '${ApplicationConstants.imagePath}empty_state.json';
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
  static const String completeProfile =
      '${ApplicationConstants.animationPath}complete_profile_animation.json';

  //     ======================= Images =======================     //

  static const String appBarBG =
      '${ApplicationConstants.imagePath}appbar_bg.png';
  static const String avtar = '${ApplicationConstants.imagePath}avtar.png';
  static const String teacherAvtar =
      '${ApplicationConstants.imagePath}teacher_avtar.png';
  static const String starSecondary =
      '${ApplicationConstants.imagePath}star_secondary.png';
  static const String replyHessahIcon =
      '${ApplicationConstants.iconPath}icon_hessah_reply.png';
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
  static const String individualIcon =
      '${ApplicationConstants.iconPath}individual_icon.png';
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
  static const String withdrawIcon =
      '${ApplicationConstants.iconPath}withdraw.png';
  static const String subscriptionIcon =
      '${ApplicationConstants.iconPath}subscription.png';
  static const String filterIcon =
      '${ApplicationConstants.iconPath}filter_icon.png';
  static const String forwardIcon =
      '${ApplicationConstants.iconPath}forward_right.svg';
  static const String downIcon =
      '${ApplicationConstants.iconPath}arrow_down.png';
  static const String usIcon = '${ApplicationConstants.iconPath}US.png';
  static const String usIconNew =
      '${ApplicationConstants.iconPath}united_states_new.png';
  static const String ukIcon =
      '${ApplicationConstants.iconPath}united_kingdom.png';
  static const String bookPerson =
      '${ApplicationConstants.iconPath}book_person.png';
  static const String graduateIcon =
      '${ApplicationConstants.iconPath}graduate_hat.png';
  static const String parentIcon =
      '${ApplicationConstants.iconPath}icon_parent.svg';
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
  static const String homeWalletIconSelected =
      '${ApplicationConstants.iconPath}icon_wallet_selected.svg';
  static const String homeMessageIconSelected =
      '${ApplicationConstants.iconPath}icon_message_selected.svg';
  static const String homeHomeIconSelected =
      '${ApplicationConstants.iconPath}icon_home_selected.svg';
  static  const String rightArrowProceed =
      '${ApplicationConstants.iconPath}right_arrow_proceed.svg';
  static const String earthIcon = '${ApplicationConstants.iconPath}earth.svg';
  static const String kuwaitFlag =
      '${ApplicationConstants.iconPath}kuwait_flag.svg';



//Assets
  static const String registerIcon = 'assets/logos/register_logo.svg';
  static const String statusIcon = 'assets/logos/status.svg';
  static const String chatFabIcon = 'assets/logos/chat_fab.svg';
  static const String moreIcon = 'assets/logos/shape.svg';
  static const String noContactsIcon = 'assets/logos/no_contacts.png';
  static const String noChatIcon = 'assets/logos/no_messages.png';
  static const String noCallImage = 'assets/logos/ic_no_call_history.webp';
  static const String profileIcon = 'assets/logos/avatar.svg';
  static const String rightArrowIcon = 'assets/logos/forward_arrow.svg';
  static const String chatIcon = 'assets/logos/chat.svg';
  static const String staredMsgIcon = 'assets/logos/stared message.svg';
  static const String notificationIcon = 'assets/logos/Notifications.svg';
  static const String tickRound = 'assets/logos/tick_round.svg';
  static const String tickRoundBlue = 'assets/logos/tick_round_blue.svg';
  static const String blockedIcon = 'assets/logos/blocked_contacts.svg';
  static const String archiveIcon = 'assets/logos/Archive_ic_settings.svg';
  static const String lockIcon = 'assets/logos/lock.svg';
  static const String lockOutlineBlack = 'assets/logos/lock_outline_black.svg';
  static const String aboutIcon = 'assets/logos/About and Help.svg';
  static const String connectionIcon = 'assets/logos/antenna.svg';
  static const String toggleOffIcon = 'assets/logos/toggle OFF.svg';
  static const String reportIcon = 'assets/logos/stared message-1.svg';
  static const String logoutIcon = 'assets/logos/logout.svg';
  static const String pencilEditIcon = 'assets/logos/pencil.svg';
  static  const String tickIcon = 'assets/logos/tick.svg';
  static const String smileIcon = 'assets/logos/smile.svg';
  static  const String icQrScannerWebLogin = 'assets/logos/ic_qr_scanner_web_login.png';
  static const String redirectLastMessage = 'assets/logos/ic_redirect_last_message.png';

  static  const String icLogo = 'assets/logos/ic_logo.png';
  static  const String icChrome = 'assets/logos/ic_chrome.png';
  static const String icEdgeBrowser = 'assets/logos/ic_edge_browser.png';
  static const String icMozilla = 'assets/logos/ic_mozilla.png';
  static const String icSafari = 'assets/logos/ic_safari.png';
  static const String icIe = 'assets/logos/ic_ie.png';
  static  const String icOpera = 'assets/logos/ic_opera.png';
  static const String icUc = 'assets/logos/ic_uc.png';
  static const String icDefaultBrowser = 'assets/logos/ic_default_browser.png';
  static  const String eyeOn = 'assets/logos/eye_on.png';
  static  const String eyeOff = 'assets/logos/eye_off.png';

//Dashboard Recent Chats
  static  const String archive = 'assets/logos/archive.svg';
  static const String unarchive = 'assets/logos/unarchive.svg';
  static const String mute = 'assets/logos/mute.svg';
  static const String unMute = 'assets/logos/unmute.svg';
  static const String pushpin = 'assets/logos/pushpin.svg';
  static const String pin = 'assets/logos/pin.svg';
  static const String unpin = 'assets/logos/unpin.svg';

// const String audioImg = 'assets/logos/audio.svg';
  static const String audioImg = 'assets/logos/headset_img.svg';
  static const String headsetImg = 'assets/logos/headset_white.svg';
  static const String documentImg = 'assets/logos/document_icon.svg';
  static  const String cameraImg = 'assets/logos/camera.svg';
  static const String contactImg = 'assets/logos/contact_icon.svg';
  static  const String galleryImg = 'assets/logos/gallery.svg';
  static const String locationImg = 'assets/logos/location_icon.svg';
  static const String rightArrow = 'assets/logos/right_arrow.svg';
  static const String previewAddImg = 'assets/logos/preview_add.svg';

  static  const String downloading = 'assets/logos/downloading.svg';
  static  const String videoPlay = 'assets/logos/video_play.svg';
  static const String videoCamera = 'assets/logos/video_camera.svg';
  static const String audioPlay = 'assets/logos/audio_play.svg';
  static  const String audioMicBg = 'assets/logos/audio_mic.svg';
  static  const String audioMic = 'assets/logos/mic.svg';
  static  const String audioMic1 = 'assets/logos/mic1.svg';
  static  const String musicIcon = 'assets/logos/music_icon.svg';
  static const String profileImage = 'assets/logos/profile_img.png';

  static const String linkImage = 'assets/logos/link.svg';
  static const String txtImage = 'assets/logos/txt.svg';
  static const String csvImage = 'assets/logos/csv.svg';
  static const String pdfImage = 'assets/logos/pdf.svg';
  static const String pptImage = 'assets/logos/ppt.svg';
  static const String pptxImage = 'assets/logos/pptx.svg';
  static  const String xlsImage = 'assets/logos/xls.svg';
  static  const String xlsxImage = 'assets/logos/xlsx.svg';
  static  const String docImage = 'assets/logos/doc.svg';
  static  const String docxImage = 'assets/logos/docx.svg';
  static  const String apkImage = 'assets/logos/apk.svg';
  static  const String mContactIcon = 'assets/logos/contact_chat.svg';
  static  const String mDocumentIcon = 'assets/logos/document_chat.svg';
  static  const String zipImage = 'assets/logos/zip.svg';
  static  const String rarImage = 'assets/logos/rar.svg';
  static  const String mImageIcon = 'assets/logos/image.svg';
  static  const String mLocationIcon = 'assets/logos/location_chat.svg';
  static const String mVideoIcon = 'assets/logos/ic_video.svg';
  static  const String mAudioIcon = 'assets/logos/noun_Audio_3408360.svg';
  static  const String mAudioRecordIcon = 'assets/logos/record_reply_preview.svg';
  static const String audioWhite = 'assets/logos/audio_white.svg';
  static const String videoWhite = 'assets/logos/video_icon.svg';
  static  const String cornerShadow = 'assets/logos/ic_baloon.png';
  static const String disabledIcon = 'assets/logos/disabled.png';

  static  const String videoCall = 'assets/logos/videocall.svg';
  static  const String call = 'assets/logos/call.svg';

  static   const String quickCall = 'assets/logos/quick_call.svg';
  static const String quickInfo = 'assets/logos/quick_info.svg';
  static  const String quickMessage = 'assets/logos/quick_message.svg';
  static  const String quickVideo = 'assets/logos/quick_video.svg';

  static  const String replyIcon = 'assets/logos/reply.svg';
  static const String cancelIcon = 'assets/logos/close.svg';
  static const String favouriteIcon = 'assets/logos/star.svg';
  static  const String unFavouriteIcon = 'assets/logos/unstar.svg';
  static  const String copyIcon = 'assets/logos/copy.svg';
  static  const String uploadIcon = 'assets/logos/upload.svg';
  static  const String downloadIcon = 'assets/logos/download.svg';
  static  const String shareIcon = 'assets/logos/share.svg';
  static const String starSmallIcon = 'assets/logos/star_small_icon.svg';

  static const String seenIcon = 'assets/logos/seen.svg';
  static  const String unSendIcon = 'assets/logos/unsent.svg';
  static  const String deliveredIcon = 'assets/logos/delivered.svg';
  static  const String acknowledgedIcon = 'assets/logos/acknowledged.svg';

//Animation
  static const String deleteDustbin = 'assets/animation/delete_dustbin.json';
  static const String audioJson = 'assets/animation/enable_mic.json';
  static  const String audioJson1 = 'assets/animation/enable_mic1.json';

  static  const String profileImg = 'assets/logos/profile_img.png';
  static  const String groupImg = 'assets/logos/ic_grp_bg.png';
  static  const String imageEdit = 'assets/logos/ic_image_edit.svg';
  static const String edit = 'assets/logos/ic_edit.svg';
  static  const String imageOutline = 'assets/logos/image_outline.svg';
  static  const String addUser = 'assets/logos/add_user.svg';
  static  const String reportUser = 'assets/logos/report_user.svg';
  static  const String reportGroup = 'assets/logos/report_group.svg';
  static const String leaveGroup = 'assets/logos/leave_group.svg';

  static const String contactSelectTick = 'assets/logos/contact_select.svg';
  static  const String closeContactIcon = 'assets/logos/close_icon_contact.svg';

  static const String emailIcon = 'assets/logos/email.svg';
  static const String phoneIcon = 'assets/logos/phone.svg';
  static  const String deleteBin = 'assets/logos/delete_bin.svg';
  static  const String deleteBinWhite = 'assets/logos/delete_bin_white.svg';

  static const String filePermission = "assets/logos/file_permission.svg";
  static  const String audioPermission = "assets/logos/audio_permission.svg";
  static  const String cameraPermission = "assets/logos/camera_permission.svg";
  static  const String contactPermission = "assets/logos/contact_permission.svg";
  static  const String contactSyncPermission = "assets/logos/contact_media_permission.svg";
  static  const String settingsPermission = "assets/logos/settings_permission.svg";
  static  const String locationPinPermission = "assets/logos/location_pin_permission.svg";
  static  const String recordAudioVideoPermission =
      "assets/logos/record_audio_video_permission.svg";

  static  const String icAdminBlocked = "assets/logos/ic_admin_blocked.svg";
  static  const String icExpand = "assets/logos/ic_expand.svg";
  static const String icCollapse = "assets/logos/ic_collapse.svg";

  static  const String forwardMedia = "assets/logos/forward_media.svg";
  static  const String arrowDown = "assets/logos/arrow_down.svg";
  static const String arrowUp = "assets/logos/arrow_up.svg";

  static const String mediaBg = "assets/logos/ic_baloon.svg";

//contact sync
  static  const String syncIcon = "assets/logos/sync.svg";
  static  const String contactSyncBg = "assets/logos/contact_sync_bg.png";
  static  const String contactBookFill = "assets/logos/contacts_book_fill.svg";
  static  const String emailContactIcon = "assets/logos/emailcontact_icon.svg";

// const String icBioBackground = "assets/logos/ic_bio_background.svg";
  static  const String icBioBackground = "assets/logos/ic_bio_background.png";
  static  const String icDeleteIcon = "assets/logos/ic_delete_icon.svg";
}
