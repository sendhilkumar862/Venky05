import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/routes/app_router.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/sheet/show_bottom_sheet.dart';
import '../../../custom/switch/app_switch.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../../tutorial/language/viewModel/language_view_model.dart';
import '../../tutorial/mobileEnter/view/mobile_view.dart';
import '../../tutorial/password/view/password_view.dart';
import '../../tutorial/view/bottomSheets/country_bottom_sheet.dart';
import '../../tutorial/view/bottomSheets/language_bottom_sheet.dart';
import 'manage_sub.dart';
import 'widget/app_support_view.dart';
import 'widget/change_name_view.dart';
import 'widget/manage_adress_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
//==============================================================================
// ** Properties **
//==============================================================================

  List<SettingHeading> settingDataList = <SettingHeading>[
    SettingHeading(header: 'Personal Information', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/profile.svg', title: 'Change Name'),
      SettingData(
          surfixImage: 'assets/icons/mobile.svg', title: 'Add Mobile Number'),
      SettingData(
          surfixImage: 'assets/icons/pin_location.svg',
          title: 'Manage Address'),
    ]),
    SettingHeading(header: 'Personal Information', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/globe_pin.svg', title: 'Change Country'),
      SettingData(
          surfixImage: 'assets/icons/globe_pin.svg',
          title: 'Manage Subscription'),
      SettingData(
          surfixImage: 'assets/icons/language_translate.svg',
          title: 'Language'),
    ]),
    SettingHeading(header: 'Support', listDetail: <SettingData>[
      SettingData(surfixImage: 'assets/icons/ring.svg', title: 'App Support'),
    ]),
    SettingHeading(header: 'Security', listDetail: <SettingData>[
      SettingData(
          surfixImage: 'assets/icons/lock.svg', title: 'Change Password'),
      SettingData(
          surfixImage: 'assets/icons/face_id.svg',
          title: 'Login With Biometric'),
      SettingData(
        surfixImage: 'assets/icons/log_out.svg',
        title: 'Logout',
      ),
    ]),
  ];
  List<ProfileList> profileListData = <ProfileList>[
    ProfileList(text: 'Take Photo', icon: ImageConstants.camera),
    ProfileList(text: 'Add Image', icon: ImageConstants.pictureSquare),
    ProfileList(text: 'Add File', icon: ImageConstants.attach),
  ];

  XFile? pickedFile;
  CroppedFile? croppedFile;
  String croppedFilePath = '';
  late PermissionStatus cameraPermissionStatus;

//==============================================================================
// ** Life Cycle **
//==============================================================================

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return BaseView<LanguageViewModel>(
        viewModel: LanguageViewModel(),
        onModelReady: (LanguageViewModel languageViewModel) {
          languageViewModel.setContext(context);
          languageViewModel.init();
        },
        onPageBuilder:
            (BuildContext context, LanguageViewModel languageViewModel) {
          return Observer(
              warnWhenNoObservables: false,
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: HessaAppBar(
                    title: 'Class Details',
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
                            itemCount: settingDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final SettingHeading data =
                                  settingDataList[index];
                              return settingListView(data, languageViewModel);
                            }),
                      ),
                    ],
                  ),
                );
              });
        });
  }

//==============================================================================
// ** Main Widget **
//==============================================================================

  Widget profileWidget(double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: <Widget>[
          profileImageView(context),
          Padding(
            padding: const EdgeInsets.only(top: 13, bottom: 3),
            child: Text('User Name', style: openSans.get20.w700.appTextColor),
          ),
          Text('mail@domain.com',
              style: openSans.get14.w500
                  .textColor(AppColors.appTextColor.withOpacity(0.50))),
        ],
      ),
    );
  }

  Widget settingListView(
      SettingHeading data, LanguageViewModel languageViewModel) {
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
            width: 343,
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
                return childSettingListView(
                    data, i, context, languageViewModel, response);
              },
            )),
      ],
    );
  }

  Widget childSettingListView(SettingHeading data, int i, BuildContext context,
      LanguageViewModel languageViewModel, SettingData response) {
    final String title = data.listDetail[i].title;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () =>
              handleTitleClick(title, context, languageViewModel, response),
          child: childSettingListTile(languageViewModel,
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

  Widget childSettingListTile(
    LanguageViewModel languageViewModel, {
    required String icon,
    required String title,
  }) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(icon),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: openSans.get14.w400.textColor(AppColors.appDarkBlack),
            ),
          ),
        ),
        if (title == 'Language')
          SizedBox(
              width: 90,
              child: selectCardView(
                icon: languageViewModel
                    .languageIcon[languageViewModel.languageIndex],
                title: languageViewModel
                    .languages[languageViewModel.languageIndex],
              )),
        if (title == 'Login With Biometric')
          AppSwitch(
            isActive: false,
          )
        else
          const Icon(Icons.arrow_forward_ios_rounded)
      ],
    );
  }

  void manageAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        // showDragHandle: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        context: context,
        builder: (BuildContext bc) {
          return const ManageAddressView();
        });
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
                image: icon ?? ImageConstants.globe,
                height: 16.px,
                width: 16.px,
              ),
            ),
          ),
          AppText(
            title ?? '',
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          const Spacer(),
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
          child: ClipOval(
            child: croppedFilePath.isNotEmpty
                ? Image.file(
                    File(croppedFilePath),
                    fit: BoxFit.cover,
                  )
                : Center(child: Text('UN', style: openSans.get20.w700.white)),
          ),
        ));
  }

  void addImageBottomSheet(BuildContext context) {
    return showCommonBottomSheet(context: context, commonWidget: profileView());
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
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Align(
                        child: Text('Add Image',
                            style: openSans.w700.get14.appTextColor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
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
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 20),
                  child: ListView.builder(
                    itemCount: profileListData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final ProfileList data = profileListData[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        AppImageAsset(
                                          image: data.icon,
                                          height: 35.px,
                                          width: 35.px,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            data.text,
                                            style: openSans.w400.get16.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.downArrowColor
                                          .withOpacity(0.5),
                                      size: 15,
                                      weight: 80,
                                    )
                                  ]),
                              onTap: () async {
                                if (index == 0) {
                                  requestCameraPermission();
                                  captureImage(context);
                                } else if (index == 1) {
                                  uploadImage(context);
                                }
                                Navigator.pop(context);
                                setState(() {});
                              },
                            ),
                          ),
                          Divider(
                            color: AppColors.appBorderColor.withOpacity(0.5),
                            thickness: 1,
                            height: 30,
                          )
                        ],
                      );
                    },
                  ),
                )
              ]),
        );
      },
    );
  }

  Future<void> requestCameraPermission() async {
    final PermissionStatus status = await Permission.camera.request();
    handlePermissionResult(status);
  }

  void handlePermissionResult(PermissionStatus status) {
    if (status.isGranted) {
      // Access the camera
      print('Camera permission granted');
    } else if (status.isDenied) {
      // Permission denied
      print('Camera permission denied');
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      print('Camera permission permanently denied');
      openAppSettings(); // Open app settings for the user to grant permission
    }
    setState(() {
      cameraPermissionStatus = status;
    });
  }

  Future<void> captureImage(BuildContext context) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      cropImage(pickedFile, context);
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    try {
      final XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await cropImage(pickedFile, context);
      }
    } catch (e) {
      print('Error picking image: $e');
      // Handle the error (show a snackbar, alert, or log it)
    }
  }

  Future<void> cropImage(XFile? pickedFile, BuildContext context) async {
    if (pickedFile != null) {
      try {
        final CroppedFile? cropFile = await ImageCropper().cropImage(
            sourcePath: pickedFile.path,
            compressFormat: ImageCompressFormat.png,
            compressQuality: 100,
            aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
            uiSettings: <PlatformUiSettings>[
              AndroidUiSettings(
                hideBottomControls: false,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true,
              ),
            ]);
        if (cropFile != null) {
          setState(() {
            croppedFile = cropFile;
            croppedFilePath = cropFile.path;
          });
        }
      } catch (e) {
        print('Error cropping image: $e');
      }
    }
  }

  void handleTitleClick(String title, BuildContext context,
      LanguageViewModel languageViewModel, SettingData response) {
    final SettingTitle settingTitle = getSettingTitle(title);

    switch (settingTitle) {
      case SettingTitle.changeName:
        AppRouter.push(const ChangeNameView());
      case SettingTitle.addMobileNumber:
        AppRouter.push(const MobileView());
      case SettingTitle.manageAddress:
        manageAddressBottomSheet(context);
      case SettingTitle.changeCountry:
        showBottomSheet(context, (BuildContext context, setState) {
          return CountryBottomsSheet(
            setState: setState,
            languageViewModel: languageViewModel,
          );
        });
      case SettingTitle.language:
        showBottomSheet(context, (BuildContext context, setState) {
          return LanguageBottomSheet(
            languageViewModel: languageViewModel,
            setState: setState,
          );
        });
      case SettingTitle.appSupport:
        AppRouter.push(const AppSupportView());
      case SettingTitle.changePassword:
        AppRouter.push(PasswordView());
      case SettingTitle.manageSubscription:
        AppRouter.push(const ManageSubscription());
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

class ProfileList {
  ProfileList({required this.text, required this.icon});

  final String text;
  final String icon;
}

enum SettingTitle {
  changeName,
  changeCountry,
  language,
  addMobileNumber,
  manageAddress,
  changePassword,
  appSupport,
  manageSubscription
}
