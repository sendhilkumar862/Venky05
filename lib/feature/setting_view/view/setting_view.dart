import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/route.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/sheet/file_select.dart';
import '../../../custom/sheet/show_bottom_sheet.dart';
import '../../../custom/switch/app_switch.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/utils/common_function.dart';
import '../../../product/utils/typography.dart';
import '../../home/controller/home_controller.dart';
import '../../tutorial/language/controller/language_controller.dart';
import '../../tutorial/view/bottomSheets/country_bottom_sheet.dart';
import '../../tutorial/view/bottomSheets/language_bottom_sheet.dart';
import '../controller/setting_controller.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  CroppedFile? croppedFile;
  final SettingController _settingController = Get.put(SettingController());
  final LanguageController _languageController = Get.put(LanguageController());
  final HomeController _homeController = Get.find();

  Map<String, dynamic> arguments = <String, dynamic>{
    'id': '',
    'otp_id': '',
    'isScreen': false,
  };

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: HessaAppBar(
          title: 'Settings',
          isTitleOnly: true,
        ),
        body: ListView(
          children: <Widget>[
            profileWidget(width, context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _settingController.selectedProfile.value ==
                          ApplicationConstants.student
                      ? _settingController.studentSettingList.length
                      : _settingController.tutorSettingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final SettingHeading data =
                        _settingController.selectedProfile.value ==
                                ApplicationConstants.student
                            ? _settingController.studentSettingList[index]
                            : _settingController.tutorSettingList[index];
                    return settingListView(data);
                  }),
            ),
          ],
        ),
      ),
    );
  }

//==============================================================================
// ** Main Widget **
//==============================================================================

  Widget profileWidget(
    double width,
    BuildContext context,
  ) {
    return Obx(
      () => SizedBox(
        width: width,
        child: Column(
          children: <Widget>[
            profileImageView(context),
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 3),
              child: Text(
                  "${_homeController.homeData.value?.firstName ?? ""} ${_homeController.homeData.value?.lastName ?? ""}",
                  style: openSans.get20.w700.appTextColor),
            ),
            Text(_homeController.homeData.value?.email ?? '',
                style: openSans.get14.w500
                    .textColor(AppColors.appTextColor.withOpacity(0.50))),
          ],
        ),
      ),
    );
  }

  Widget settingListView(SettingHeading data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(data.header,
              style: openSans.get16.w700.textColor(
                AppColors.appTextColor,
              )),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.appBorderColor.withOpacity(0.5))),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.listDetail.length,
              itemBuilder: (BuildContext context, int i) {
                final SettingData response = data.listDetail[i];
                return childSettingListView(data, i, context, response);
              },
            )),
      ],
    );
  }

  Widget childSettingListView(
    SettingHeading data,
    int i,
    BuildContext context,
    SettingData response,
  ) {
    final String title = data.listDetail[i].title;

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => handleTitleClick(
            title,
            context,
            response,
          ),
          child: childSettingListTile(
              title: response.title, icon: response.surfixImage),
        ),
        if (i < data.listDetail.length - 1)
          Divider(
            height: 30,
            thickness: 1,
            color: AppColors.appBorderColor.withOpacity(0.5),
          )
      ],
    );
  }

  Widget childSettingListTile({
    required String icon,
    required String title,
  }) {
    // final LanguageViewModel languageViewModel = ref.watch(languageViewModelProvider);
    return Row(
      children: <Widget>[
        SvgPicture.asset(icon),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title != 'Add Mobile Number'
                        ? title
                        : _homeController.homeData.value?.mobile != null
                            ? 'Change Mobile Number'
                            : title,
                    style:
                        openSans.get14.w400.textColor(AppColors.appDarkBlack),
                  ),
                  if (_homeController.homeData.value?.mobile != null &&
                      title == 'Add Mobile Number')
                    Text(
                      _homeController.homeData.value?.mobile ?? '',
                      style:
                          openSans.get14.w400.textColor(AppColors.appDarkBlack),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (title == 'Change Country')
          Obx(
            () => SizedBox(
              child: selectCardView(
                icon: _languageController.selectedCountry.value?.flag_url,
                title: _languageController.selectedCountry.value?.name,
              ),
            ),
          ),
        if (title == 'Language')
          Obx(
            () => SizedBox(
                child: selectCardView(
              icon: _languageController
                  .languageIcon[_languageController.languageIndex.value],
              title: _languageController
                  .languages[_languageController.languageIndex.value],
            )),
          ),
        if (title == 'Login With Biometric')
          Obx(
            () => AppSwitch(
              isActive:
                  _settingController.authenticated.value != '' ? true : false,
              onTap: () {
                _settingController.authenticated.value == ''
                    ? _settingController.setLocalAuth()
                    : _settingController.removeLocalAuth();
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.arrowColor.withOpacity(0.5)),
          )
      ],
    );
  }

  Widget selectCardView({String? icon, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: AppImageAsset(
                fit: BoxFit.fill,
                image: icon ?? ImageConstants.globe,
                height: 16.px,
                width: 16.px,
              ),
            ),
          ),
          AppText(
            title ?? 'Select',
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

//==============================================================================
// ** Helper Widget **
//==============================================================================

  Widget profileImageView(BuildContext context) {
    return InkWell(
        onTap: () {
          addImageBottomSheet(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.appProfile,
            borderRadius: BorderRadius.circular(50),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset:
                    const Offset(0, 2), // changes the position of the shadow
              ),
            ],
          ),
          width: 65,
          height: 65,
          child: Obx(
            () => ClipOval(
              child: _homeController.homeData.value?.imageId != null &&
                      _homeController.homeData.value!.imageId!.isNotEmpty
                  ? SizedBox(
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: AppImageAsset(
                          image: _homeController.homeData.value?.imageId
                                  ?.getImageUrl('profile') ??
                              '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                          '${_homeController.homeData.value?.firstName ?? ''} ${_homeController.homeData.value?.lastName ?? ''}'
                              .extractInitials(),
                          style: openSans.get20.w700.white)),
            ),
          ),
        ));
  }

  void addImageBottomSheet(BuildContext context) {
    return showCommonBottomSheet(context: context, commonWidget: profileView(), showDragHandle: false);
  }

  Widget profileView() {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text('Add Image',
                            style: openSans.w700.get14.appTextColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                AppColors.downArrowColor.withOpacity(0.15)),
                        child: const Padding(
                          padding: EdgeInsets.all(3),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
                fileSelect(onTap: (int index){
                  if (index == 0) {
                    requestCameraPermission();
                  } else if (index == 1) {
                    uploadImage();
                  }
                  else if (index == 2) {
                    pickDocument();
                  }
                  Navigator.pop(context);
                }),
              ]),
        );
      },
    );
  }

  Future<void> requestCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
  final bool cameraStatus= handlePermissionResult(status);
     if(cameraStatus){
       _settingController.croppedFilePath = await captureImage()??'';
   if(_settingController.croppedFilePath!=''){
     await _settingController.uploadProfilePhoto();}
         }
  }





  Future<void> uploadImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 800,
          maxWidth: 800);
      if (pickedFile != null) {
        _settingController.croppedFilePath = await cropImage(pickedFile)??'';
       if(_settingController.croppedFilePath!=''){
        await _settingController.uploadProfilePhoto();}
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
      // Handle the error (show a snackbar, alert, or log it)
    }
  }

  Future<void> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'png', 'jpeg', 'jpg'],
    );
    if (result != null) {
      _settingController.croppedFilePath=result.files.single.path ??'';
      if(_settingController.croppedFilePath!=''){
        await _settingController.uploadProfilePhoto();}
    }
    }



  void handleTitleClick(
    String title,
    BuildContext context,
    SettingData response,
  ) {
    final SettingTitle settingTitle = getSettingTitle(title);
    switch (settingTitle) {
      case SettingTitle.changeName:
        Get.toNamed(Routes.changeNameView);
      case SettingTitle.addMobileNumber:
        _homeController.homeData.value?.mobile != null
            ? Get.toNamed(Routes.changeMobileNumberView)
            : Get.toNamed(Routes.addMobileView);
      case SettingTitle.changeMobileNumber:
        Get.toNamed(Routes.changeMobileNumberView);
      case SettingTitle.logout:
        _settingController.logout(context);
      case SettingTitle.manageAddress:
        Get.toNamed(Routes.manageAddressView);
      case SettingTitle.changeCountry:
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return CountryBottomsSheet(
                  setState: setState,
                );
              },
            );
          },
        );
      case SettingTitle.language:
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return LanguageBottomSheet(setState: setState);
              },
            );
          },
        );
      case SettingTitle.appSupport:
        Get.toNamed(Routes.appSupportView);
      case SettingTitle.changePassword:
        Get.toNamed(Routes.changePasswordView);
      case SettingTitle.manageSubscription:
        Get.toNamed(Routes.manageSubscription);
      case SettingTitle.manageAvailabilityTime:
        Get.toNamed(Routes.availableTimesView);
      case SettingTitle.loginWithBiometric:
        _settingController.authenticated.value == ''
            ? _settingController.setLocalAuth()
            : _settingController.removeLocalAuth();
    }
  }

  SettingTitle getSettingTitle(String title) {
    switch (title.toLowerCase()) {
      case 'change name':
        return SettingTitle.changeName;
      case 'change country':
        return SettingTitle.changeCountry;
      case 'language':
        return SettingTitle.language;
      case 'add mobile number':
        return SettingTitle.addMobileNumber;
      case 'manage address':
        return SettingTitle.manageAddress;
      case 'change password':
        return SettingTitle.changePassword;
      case 'app support':
        return SettingTitle.appSupport;
      case 'manage subscription':
        return SettingTitle.manageSubscription;
      case 'manage availability time':
        return SettingTitle.manageAvailabilityTime;
      case 'logout':
        return SettingTitle.logout;
      case 'login with biometric':
        return SettingTitle.loginWithBiometric;
      default:
        return SettingTitle.changeName;
    }
  }

  void showBottomSheet(BuildContext context,
      Widget Function(BuildContext, StateSetter) builder) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: builder,
        );
      },
    );
  }
}

class SettingHeading {
  SettingHeading({required this.header, required this.listDetail});

  final String header;
  List<SettingData> listDetail;
}

class SettingData {
  SettingData({
    required this.surfixImage,
    required this.title,
  });

  final String surfixImage;
  final String title;
}

class Address {
  Address(this.heading, this.address1, this.address2);
  String heading;
  String address1;
  String address2;
}
enum SettingTitle {
  changeName,
  changeCountry,
  language,
  addMobileNumber,
  changeMobileNumber,
  manageAddress,
  changePassword,
  appSupport,
  manageSubscription,
  manageAvailabilityTime,
  logout,
  loginWithBiometric,
}
