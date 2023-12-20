import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/cardView/app_card_view.dart';
import '../../../../custom/cardView/heading_card_view.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/info_card_view_horizontal.dart';
import '../../../../product/base/view/base_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/network/local/key_value_storage_base.dart';
import '../../../../product/network/local/key_value_storage_service.dart';
import '../../../home/viewModel/home_view_model.dart';
import 'classes_view.dart';
class ActivitiesView extends StatefulWidget {
  const ActivitiesView({Key? key}) : super(key: key);

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  String selectedProfile = '';
  String selectedUserStatus = '';
  bool isPending = false;

  @override
  void initState() {
    super.initState();
    selectedProfile =
        keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ?? '';
  }


  @override
  Widget build(BuildContext context) {
   return  BaseView<HomeViewModel>(
        viewModel: HomeViewModel(),
    onModelReady: (HomeViewModel model) {
    model.setContext(context);
    },
    onPageBuilder: (BuildContext context, HomeViewModel homeData) {
         return Observer(builder: (BuildContext context) {
            if(homeData.homeData!=null){
              if (homeData.homeData?.userStatus =='99' ) {
                return const ClassesView();
              }
              else {
                return Expanded(
                  child: ListView(
                    children: <Widget>[
                      InfoCardVIew(
                        isShowButton: true,
                        title: 'No Activities Found!',
                        subTitle:
                        "You don't have any pending activities that require your action. If there are scheduled classes or new proposals for the classes you created, etc...\nyou will find them here.",
                        cardColor: AppColors.white,
                        buttonTitle: 'Create Class',
                        buttonTap: () {
                          AppRouter.pushNamed(Routes.createClass);
                        },
                      ),
                      SizedBox(
                        height: 20.px,
                      ),
                      InfoCardViewHorizontal(
                        heading: 'Upcoming Classes',
                        isShowButton: true,
                        title: 'Create a new class and receive proposals from teachers',
                        cardColor: AppColors.lightPurple,
                        buttonTap: () {},
                      ),
                      SizedBox(height: 20.px),
                      SizedBox(height: 20.px),
                      HeadingCardView(
                          title: 'Related Classes', onTap: () {}, totalItem: '3'),
                      SizedBox(
                        height: 10.px,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.290,
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                              right: 15.px, top: 5.px, bottom: 20.px, left: 15.px),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return AppCardView(
                              cardTitle: 'Math',
                              date: '12/12 12:30pm',
                              timer: '1h 30m',
                              money: '5.500 KWD',
                              status: 'PENDING',
                              isPro: true,
                              avtar: ImageConstants.teacherAvtar,
                              countryIcon: ImageConstants.countryIcon,
                              countryName: 'Kuwait',
                              reViewLength: 3,
                              teacherName: 'Ahmed Ali',
                              buttonTap: () {
                                AppRouter.pushNamed(Routes.proposalDetailsView);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 15.px,
                            );
                          },
                        ),
                      ),
                      HeadingCardView(
                          title: 'Related Classes', onTap: () {}, totalItem: '3'),
                      SizedBox(
                        height: 10.px,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.290,
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                              right: 15.px, top: 5.px, bottom: 20.px, left: 15.px),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return AppCardView(
                              cardTitle: 'Math',
                              date: '12/12 12:30pm',
                              timer: '1h 30m',
                              money: '5.500 KWD',
                              status: 'PENDING',
                              isPro: true,
                              avtar: ImageConstants.teacherAvtar,
                              countryIcon: ImageConstants.countryIcon,
                              countryName: 'Kuwait',
                              reViewLength: 3,
                              teacherName: 'Ahmed Ali',
                              buttonTap: () {},
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 15.px,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 200.px,
                      )
                    ],
                  ),
                );
              }}else{
              return const SizedBox.shrink();
            } },);
       });}

  }


