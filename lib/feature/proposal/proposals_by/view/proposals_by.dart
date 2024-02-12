import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/typography.dart';
import '../../../classDetails/controller/class_details_controller.dart';
import '../../../classDetails/view/bottomSheetView/booking_bottom_view.dart';
import '../controller/proposals_by_controller.dart';


class ProposalsBy extends StatefulWidget {
   ProposalsBy({super.key,required this.classId});
  String classId;

  @override
  State<ProposalsBy> createState() => _ProposalsByState();
}

class _ProposalsByState extends State<ProposalsBy> {
  final ProposalsByController _proposalsByController=Get.put(ProposalsByController());
  final ClassDetailsController _classDetailsController = Get.put(ClassDetailsController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classDetailsController.scrollController.addListener(pagination);
  }
  void pagination() async{
    if (_classDetailsController.scrollController.position.pixels ==
        _classDetailsController.scrollController.position.maxScrollExtent) {
      // ignore: avoid_dynamic_calls
      if( _classDetailsController.classData.value.proposalsCount!=null && _classDetailsController.classData.value.proposalsCount! >_classDetailsController.proposalList.length){
        _classDetailsController.startIndex= _classDetailsController.startIndex+1;
        // ignore: avoid_dynamic_calls
        await _classDetailsController.getProposalDetails( _classDetailsController.classId, _classDetailsController.startIndex,isReload: true);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: (MediaQuery.of(context).size.height * 0.92).px,
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
              margin: EdgeInsets.only(top: 14.px, right: 15.px),
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
                height: 25.px,
              ),
              AppText('Proposals By',
                  fontWeight: FontWeight.w700, fontSize: 14.px),
              SizedBox(
                height: 30.px,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                  physics: BouncingScrollPhysics(),
                  itemCount: _classDetailsController.proposalList.length,
                  shrinkWrap: true,
                  controller: _classDetailsController.scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.px,
                      mainAxisSpacing: 10.px,
                      childAspectRatio: 0.8),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        _proposalsByController.getProposalDetails( _classDetailsController.proposalList[index].proposalId??'',widget.classId);
                        _classDetailsController.proposalId=_classDetailsController.proposalList[index].proposalId??'';
                        proposalByTeacherBottomSheet(index);
                      },
                      child: DetailsCardView(
                          cardMargin: EdgeInsets.only(
                              right: 15.px, top: 10.px, bottom: 27.px),
                          reViewLength: _classDetailsController.proposalList[index].rating,
                          name: _classDetailsController.proposalList[index].name??'',
                          avatar:_classDetailsController.proposalList[index].imageId?.getImageUrl('profile'),
                          countryIcon: _classDetailsController.proposalList[index].flagUrl,
                          countryName: _classDetailsController.proposalList[index].country,
                          isPro: true,
                          isBookmarked: true,
                          subjects: _classDetailsController.proposalList[index].cost),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void proposalByTeacherBottomSheet(int index) {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (BuildContext context) {
        return Obx(()=>_proposalsByController.proposalDetailModel.value.proposalDetails?.cost!=null?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Proposal By', style: openSans.get14.w700),
                          SizedBox(
                            width: width * 0.25,
                          ),
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.downArrowColor.withOpacity(0.15)),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                              ))
                        ],
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Mr. ',
                              style: TextStyle(
                                color: AppColors.appDarkBlack,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.px,
                              ),
                            ),
                            TextSpan(
                              text: _classDetailsController.proposalList[index].name??'',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.appDarkBlack,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.px,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColors.bgQuaternary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Original Class Details',
                        style: openSans.get16.w700.appTextColor,
                      ),
                      Column(children: [
                        Row(children: [
                      Padding(
                      padding:
                          const EdgeInsets.only(right: 15, top: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        width: 18,
                        height: 18,
                        'assets/icons/date_icon.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(_proposalsByController.proposalDetailModel.value.originalDetails!.classTime!.toString().epochToNormal()),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(right: 15, top: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        width: 18,
                        height: 18,
                        'assets/icons/timer_icon.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(_proposalsByController.proposalDetailModel.value.originalDetails!.duration!.toString().timeConvert()),
                      )
                    ],
                  ),
                ),
                        ],),
                        Row(children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 15, top: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  'assets/icons/date_icon.png',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text('${_proposalsByController.proposalDetailModel.value.originalDetails!.cost??''} KWD / Session'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 15, top: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  'assets/icons/read_book_icon.png',
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text('1 Session'),
                                )
                              ],
                            ),
                          ),
                        ],)
                      ],)
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:  AppColors.ctaQuaternary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text(
                      'Proposal Details',
                      style: openSans.get16.w700.appTextColor,
                    ),
                    Row(children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 15, top: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              width: 18,
                              height: 18,
                              'assets/icons/date_icon.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(_proposalsByController.proposalDetailModel.value.proposalDetails!.classTime!.toString().epochToNormal()),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 15, top: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              width: 18,
                              height: 18,
                              'assets/icons/timer_icon.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(_proposalsByController.proposalDetailModel.value.proposalDetails!.duration!.toString().timeConvert()),
                            )
                          ],
                        ),
                      ),
                    ],),
                    Row(children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 15, top: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              width: 18,
                              height: 18,
                              'assets/icons/date_icon.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('${_proposalsByController.proposalDetailModel.value.proposalDetails!.cost??''} KWD / Session'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 15, top: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              width: 18,
                              height: 18,
                              'assets/icons/read_book_icon.png',
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('1 Session'),
                            )
                          ],
                        ),
                      ),
                    ],)
                  ],)
                ),
                AppButton(
                  isDisable: false,
                  borderColor: AppColors.appBlue,
                  height: 45.px,
                  title: 'Approve The Proposal',
                  onPressed: () async{
                   final bool status= await _classDetailsController.approveProposal(_classDetailsController.proposalId??'');
                   if(status) {
                     // ignore: use_build_context_synchronously
                     showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return BookingBottomSheet(
                            height: MediaQuery.of(context).size.height * 0.62.px,
                        isBook: false,
                        isRouting: '',);

                      },
                    );
                   }
                  },
                ),
              ],
            ),
          ):const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

class Header {
  Header({required this.heading, required this.headingData});

  final String heading;
  List<HeaderData> headingData;
}

class HeaderData {
  HeaderData({required this.icon, required this.title});

  final String icon;
  final String title;
}
