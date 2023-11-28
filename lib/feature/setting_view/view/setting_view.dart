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
import '../../tutorial/view/bottomSheets/country_bottom_sheet.dart';
import '../../tutorial/view/bottomSheets/language_bottom_sheet.dart';
import 'change_name_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  List<ProfileList> profileListData = <ProfileList>[
    ProfileList(text: 'Take Photo', icon: ImageConstants.camera),
    ProfileList(text: 'Add Image', icon: ImageConstants.pictureSquare),
    ProfileList(text: 'Add File', icon: ImageConstants.attach),
  ];
  XFile? pickedFile;
  CroppedFile? croppedFile;
  String croppedFilePath = '';
  late PermissionStatus cameraPermissionStatus;
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                    children: [
                      SizedBox(
                        width: width,
                        child: Column(children: [
                          InkWell(
                              onTap: () {
                                addImageBottomSheet(context);
                              },
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: ClipOval(
                                  child: croppedFilePath.isNotEmpty
                                      ? Image.file(
                                          File(croppedFilePath),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "https://img.freepik.com/premium-photo/portrait-male-delivery-man-holding-cargo-box_296537-1507.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              )
                              //     Container(
                              //   decoration: BoxDecoration(
                              //   color: AppColors.appBlue,
                              //     borderRadius: BorderRadius.circular(50),
                              //     boxShadow: <BoxShadow>[
                              //       BoxShadow(
                              //         color: Colors.black.withOpacity(0.2),
                              //         spreadRadius: 2,
                              //         blurRadius: 4,
                              //         offset: const Offset(
                              //             0, 2), // changes the position of the shadow
                              //       ),
                              //     ],
                              //   ),
                              //   width: 60,
                              //   height: 60,
                              // ),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text('User Name',
                                style: openSans.get20.w700.appTextColor),
                          ),
                          Text('mail@domain.com',
                              style: openSans.get14.w500.textColor(
                                  AppColors.appTextColor.withOpacity(0.50))),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: settingDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = settingDataList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(data.header,
                                        style: openSans.get16.w700.textColor(
                                          AppColors.appTextColor,
                                        )),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.appBorderColor
                                                  .withOpacity(0.5))),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data.listDetail.length,
                                        itemBuilder: (context, i) {
                                          var response = data.listDetail[i];
                                          return Column(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  if (data.listDetail[i]
                                                          .title ==
                                                      'Change Name') {
                                                    AppRouter.push(
                                                        ChangeNameView());
                                                  } else if (data.listDetail[i]
                                                          .title ==
                                                      'Change Country') {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              25.0),
                                                        ),
                                                      ),
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              setState) {
                                                            return CountryBottomsSheet(
                                                                setState:
                                                                    setState,
                                                                languageViewModel:
                                                                    languageViewModel);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  } else if (data.listDetail[i]
                                                          .title ==
                                                      'Language') {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              setState) {
                                                            return LanguageBottomSheet(
                                                                languageViewModel:
                                                                    languageViewModel,
                                                                setState:
                                                                    setState);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                        response.surfixImage),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          response.title,
                                                          style: openSans
                                                              .get14.w400
                                                              .textColor(AppColors
                                                                  .appDarkBlack),
                                                        ),
                                                      ),
                                                    ),
                                                    if (data.listDetail[i]
                                                            .title ==
                                                        'Login With Biometric')
                                                      AppSwitch(
                                                        isActive: false,
                                                      )
                                                    else
                                                      const Icon(Icons
                                                          .arrow_forward_ios_rounded)
                                                  ],
                                                ),
                                              ),
                                              if (i <
                                                  data.listDetail.length - 1)
                                                Divider(
                                                  height: 30,
                                                  thickness: 1,
                                                  color: AppColors
                                                      .appBorderColor
                                                      .withOpacity(0.5),
                                                )
                                            ],
                                          );
                                        },
                                      )),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Widget selectCardView({String? icon, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.px,
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 12.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.px),
          border: Border.all(color: AppColors.lightPurple, width: 1.5.px),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: AppImageAsset(
                image: icon ?? ImageConstants.globe,
                height: 25.px,
                width: 25.px,
              ),
            ),
            SizedBox(
              width: 12.px,
            ),
            AppText(
              title ?? '',
              fontWeight: FontWeight.w400,
            ),
            const Spacer(),
            AppImageAsset(
              image: ImageConstants.downIcon,
              height: 16.px,
              color: AppColors.appGrey,
            ),
          ],
        ),
      ),
    );
  }

  void addImageBottomSheet(BuildContext context) {
    return showCommonBottomSheet(
        context: context,
        commonWidget: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
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
                                  color: AppColors.downArrowColor
                                      .withOpacity(0.15)),
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
                          ProfileList data = profileListData[index];
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                data.text,
                                                style:
                                                    openSans.w400.get16.black,
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
                                      croppedFilePath;
                                    } else if (index == 1) {
                                      uploadImage(context);
                                      croppedFilePath;
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                              Divider(
                                color:
                                    AppColors.appBorderColor.withOpacity(0.5),
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
        ));
  }

  Future<void> _cropImage(XFile? pickedFile, context) async {
    if (pickedFile != null) {
      try {
        final CroppedFile? cropFile = await ImageCropper().cropImage(
            sourcePath: pickedFile.path,
            compressFormat: ImageCompressFormat.png,
            compressQuality: 100,
            aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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

  Future<void> uploadImage(context) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await _cropImage(pickedFile, context);
      }
    } catch (e) {
      print('Error picking image: $e');
      // Handle the error (show a snackbar, alert, or log it)
    }
  }

  Future<void> captureImage(context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _cropImage(pickedFile, context);
    }
  }

  void requestCameraPermission() async {
    var status = await Permission.camera.request();
    handlePermissionResult(status);
  }

  void handlePermissionResult(PermissionStatus status) {
    if (status.isGranted) {
      // Access the camera
      print("Camera permission granted");
    } else if (status.isDenied) {
      // Permission denied
      print("Camera permission denied");
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      print("Camera permission permanently denied");
      openAppSettings(); // Open app settings for the user to grant permission
    }
    setState(() {
      cameraPermissionStatus = status;
    });
  }
}

class SettingHeading {
  SettingHeading({required this.header, required this.listDetail});

  final String header;
  List<SettingData> listDetail;
}

class ProfileList {
  ProfileList({required this.text, required this.icon});

  final String text;
  final String icon;
}

class SettingData {
  SettingData({
    required this.surfixImage,
    required this.title,
  });

  final String surfixImage;
  final String title;
}
