import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/dialog/success_fail_dialog.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/switch/app_switch.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/app/app_utils.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../controller/class_details_controller.dart';

// ignore: must_be_immutable
class BookingBottomSheet extends StatefulWidget {
  BookingBottomSheet({super.key, this.height,this.isRouting='back', this.isBook='true'});
  double? height;
  String? isRouting;
  String? isBook;

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  final ClassDetailsController _classDetailsController = Get.put(ClassDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _classDetailsController.initiatePayment();

  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    _classDetailsController.initiatePaymentModel.value
        .totalAmount==null?const SizedBox.shrink():Container(
        padding: EdgeInsets.only(left: 15.px, right: 15.px),
        height:  widget.height ?? MediaQuery.of(context).size.height * 0.72.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.px),
            topRight: Radius.circular(30.px),
          ),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 14.px),
                alignment: Alignment.center,
                height: 25.px,
                width: 25.px,
                decoration: const BoxDecoration(
                    color: AppColors.appLightGrey, shape: BoxShape.circle),
                child: AppImageAsset(
                  image: ImageConstants.closeIcon,
                  height: 20.px,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 15.px,
                ),
                AppText(
                  'Booking Confirmation',
                  fontSize: 14.px,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 10.px,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    'Payment Method',
                    fontSize: 16.px,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.px,
                ),
                Row(
                  children: <Widget>[
                    AppImageAsset(
                      image: ImageConstants.kNetLogo,
                      height: 20.px,
                    ),
                    SizedBox(width: 8.px),
                    AppImageAsset(
                      image: ImageConstants.visaLogo,
                      height: 12.px,
                    ),
                    SizedBox(width: 8.px),
                    AppImageAsset(
                      image: ImageConstants.mastercardLogo,
                      height: 20.px,
                    ),
                    SizedBox(width: 8.px),
                    AppImageAsset(
                      image: ImageConstants.applePayLogo,
                      height: 20.px,
                    ),
                    SizedBox(width: 8.px),
                    AppImageAsset(
                      image: ImageConstants.gPayLogo,
                      height: 20.px,
                    ),
                    SizedBox(width: 8.px),
                  ],
                ),
                SizedBox(
                  height: 18.px,
                ),
                Row(
                  children: <Widget>[
                    AppText(
                      'Use Wallet',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    SizedBox(
                      width: 5.px,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AppText('${_classDetailsController.initiatePaymentModel.value
                            .balance?.split('.')[0]}',
                            fontSize: 16.px, fontWeight: FontWeight.w700),
                        AppText('.${_classDetailsController.initiatePaymentModel.value
                            .balance?.split('.')[1]} KWD',
                            fontSize: 12.px, fontWeight: FontWeight.w700),
                      ],
                    ),
                    SizedBox(
                      width: 10.px,
                    ),
                    InkWell(
                      onTap: () {},
                      child: AppSwitch(isActive: true),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                AppDivider(),
                SizedBox(
                  height: 10.px,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    'Payment Summary',
                    fontSize: 16.px,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      'Class Cost',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AppText('${_classDetailsController.initiatePaymentModel.value
                            .classCost?.split('.')[0]}',
                            fontSize: 16.px, fontWeight: FontWeight.w700),
                        AppText('.${_classDetailsController.initiatePaymentModel.value
                            .classCost?.split('.')[1]} KWD',
                            fontSize: 12.px, fontWeight: FontWeight.w700),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      'Number of Sessions',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    AppText('${_classDetailsController.initiatePaymentModel.value
                        .sessions}',
                        fontSize: 16.px,
                        fontWeight: FontWeight.w700,
                        color: AppColors.appGrey)
                  ],
                ),
                SizedBox(height: 8.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      'Number of Students',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    AppText('${_classDetailsController.initiatePaymentModel.value
                        .maxParticipants}',
                        fontSize: 16.px,
                        fontWeight: FontWeight.w700,
                        color: AppColors.appGrey)
                  ],
                ),
                AppDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      'Total Classes Cost',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AppText('${_classDetailsController.initiatePaymentModel.value
                            .totalClassCost?.toDouble().toString().split('.')[0]}',
                            fontSize: 16.px, fontWeight: FontWeight.w700),
                        AppText('.${_classDetailsController.initiatePaymentModel.value
                            .totalClassCost?.toDouble().toString().split('.')[1]} KWD',
                            fontSize: 12.px, fontWeight: FontWeight.w700),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      'Hessah Fees',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AppText('${_classDetailsController.initiatePaymentModel.value
                            .fees?.toString().split('.')[0]}',
                            fontSize: 16.px,
                            fontWeight: FontWeight.w700,
                            color: AppColors.appGrey),
                        AppText('.${_classDetailsController.initiatePaymentModel.value
                            .fees?.toString().split('.')[1]} KWD',
                            fontSize: 12.px,
                            fontWeight: FontWeight.w700,
                            color: AppColors.appGrey),
                      ],
                    ),
                  ],
                ),
                AppDivider(),
                SizedBox(
                  height: 5.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      'Amount to pay',
                      fontSize: 12.px,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appGrey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AppText('${_classDetailsController.initiatePaymentModel.value
                            .totalAmount?.toString().split('.')[0]}',
                            fontSize: 16.px, fontWeight: FontWeight.w700),
                        AppText('.${_classDetailsController.initiatePaymentModel.value
                            .totalAmount?.toString().split('.')[1]} KWD',
                            fontSize: 12.px, fontWeight: FontWeight.w700),
                      ],
                    ),
                  ],
                ),

                AppButton(
                  isDisable: false,
                  borderColor: AppColors.appBlue,
                  height: 45.px,
                  title: widget.isBook=='true'?'Book and Pay':widget.isBook=='Pay'?'Pay':'Approve and Pay',
                  onPressed: () async{
                    final String status= await  _classDetailsController.makePayment(_classDetailsController.initiatePaymentModel.value.id!);
                        if(status=='true') {
                          Get.back();
                          // ignore: use_build_context_synchronously
                          showModalBottomSheet(
                            context: context,
                            constraints: BoxConstraints(
                              maxWidth:
                              // ignore: use_build_context_synchronously
                              (MediaQuery.of(context).size.width - 30)
                                  .px,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            builder: (BuildContext context) {
                              return SuccessFailsInfoDialog(
                                title: 'Success',
                                buttonTitle: 'Done',
                                content:
                                widget.isBook=='true'?'You have successfully booked your class, and you will get notification to pay after the teacher accept the class.':'You have successfully booked your class!',
                                isRouting:  widget.isRouting,
                                tranId: _classDetailsController.transactionId,

                              );
                            },
                          );
                        }else if(status=='Insufficient funds!'){
                          AppUtils.showFlushBar(
                            context: Routes.navigatorKey.currentContext!,
                            message: status,
                          );
                        }
                        else{
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      }
                ),

              ],
            ),
          ],
        ),
      ),
    );


  }


}
