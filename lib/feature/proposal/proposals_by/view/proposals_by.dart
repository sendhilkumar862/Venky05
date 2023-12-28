import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/cardView/details_card_view.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../../classDetails/view/bottomSheetView/booking_bottom_view.dart';
import '../controller/proposals_by_controller.dart';


class ProposalsBy extends StatefulWidget {
  const ProposalsBy({super.key});

  @override
  State<ProposalsBy> createState() => _ProposalsByState();
}

class _ProposalsByState extends State<ProposalsBy> {
  final ProposalsByController _proposalsByController=Get.put(ProposalsByController());
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
                  itemCount: 8,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.px,
                      mainAxisSpacing: 10.px,
                      childAspectRatio: 0.8),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        proposalByTeacherBottomSheet();
                      },
                      child: DetailsCardView(
                          reViewLength: 3,
                          name: 'User Name',
                          avatar: ImageConstants.teacherAvtar,
                          countryIcon: ImageConstants.countryIcon,
                          countryName: 'Kuwait',
                          isPro: true,
                          isBookmarked: true,
                          subjects: '5,500 KED per session'),
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

  void proposalByTeacherBottomSheet() {
    final double width = MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                            text: 'Teacher Name',
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
              ListView.builder(
                itemCount: _proposalsByController.dataList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var data = _proposalsByController.dataList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 140,
                      width: width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: index == 0
                              ? AppColors.bgQuaternary
                              : AppColors.ctaQuaternary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.heading,
                            style: openSans.get16.w700.appTextColor,
                          ),
                          Wrap(
                            children: List.generate(
                              _proposalsByController
                                  .dataList[index].headingData.length,
                              (i) {
                                var data1 = _proposalsByController
                                    .dataList[index].headingData[i];
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        width: 18,
                                        height: 18,
                                        data1.icon,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(data1.title),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.px,
              ),
              AppButton(
                isDisable: false,
                borderColor: AppColors.appBlue,
                height: 45.px,
                title: 'Approve The Proposal',
                onPressed: () {
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
                          height: MediaQuery.of(context).size.height * 0.62.px);
                    },
                  );
                },
              ),
            ],
          ),
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
