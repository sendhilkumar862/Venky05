import 'package:flutter/material.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  bool isPending = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Center(
          child: InfoCardVIew(
            isPending: false,
            isShowButton: true,
            isSupport: false,
            isStatus: false,
            title: 'Complete Your Profile',
            message: 'Your account has been created Successfully',
            subTitle:
                "To kickstart your teaching journey and connect with students, please complete your profile. Revel in every lesson and share the joy of learning!",
            cardColor: AppColors.white,
            buttonTitle: 'Completed Profile',
            buttonTap: () {
              if (isPending) {
                setState(() {
                  isPending = !isPending;
                });
              } else {
                AppRouter.pushNamed(Routes.personalInfo);
              }
            },
          ),
        ),
        /* Center(
          child: InfoCardVIew(
            isPending: isPending,
            isShowButton: false,
            isSupport: true,
            title: 'Account Under Review',
            subTitle:
                "Once approved, you'll be ready to commence teaching, We'll notify you soon!.",
            cardColor: AppColors.white,
            buttonTitle: 'Class Details',
            buttonTap: () {
              if (isPending) {
                setState(() {
                  isPending = !isPending;
                });
              } else {
                AppRouter.push(ReUploadDocument());
              }
            },
          ),
        ),*/
        // return Expanded(
        //   child: ListView(
        //     children: <Widget>[
        //
        //       SizedBox(
        //         height: 20.px,
        //       ),
        //       SizedBox(height: 20.px),
        //       HeadingCardView(
        //           title: 'Related Classes', onTap: () {}, totalItem: '3'),
        //       SizedBox(
        //         height: 10.px,
        //       ),
        //       SizedBox(
        //         height: 226.px,
        //         child: ListView.separated(
        //           padding: const EdgeInsets.only(
        //               right: 15, top: 5, bottom: 20, left: 15),
        //           shrinkWrap: true,
        //           physics: const BouncingScrollPhysics(),
        //           itemCount: 3 ?? 0,
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (BuildContext context, int index) {
        //             return AppCardView(
        //               proposals: 0,
        //               cardTitle: 'Math',
        //               date: '12/12 12:30pm',
        //               timer: '1h 30m',
        //               money: '5.500 KWD',
        //               status: 'COMPLETED',
        //               isPro: true,
        //               avtar: ImageConstants.teacherAvtar,
        //               countryIcon: ImageConstants.countryIcon,
        //               countryName: 'Kuwait',
        //               reViewLength: 3,
        //               teacherName: 'Ahmed Ali',
        //               buttonTap: () {},
        //             );
        //           },
        //           separatorBuilder: (BuildContext context, int index) {
        //             return const SizedBox(
        //               width: 15,
        //             );
        //           },
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       SizedBox(height: 20.px),
        //       HeadingCardView(
        //           title: 'Related Classes', onTap: () {}, totalItem: '3'),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       SizedBox(
        //         height: 226.px,
        //         child: ListView.separated(
        //           padding: const EdgeInsets.only(
        //               right: 15, top: 5, bottom: 20, left: 15),
        //           shrinkWrap: true,
        //           physics: const BouncingScrollPhysics(),
        //           itemCount: 3 ?? 0,
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (BuildContext context, int index) {
        //             return AppCardView(
        //               proposals: 0,
        //               cardTitle: 'Math',
        //               date: '12/12 12:30pm',
        //               timer: '1h 30m',
        //               money: '5.500 KWD',
        //               status: 'COMPLETED',
        //               isPro: true,
        //               avtar: ImageConstants.teacherAvtar,
        //               countryIcon: ImageConstants.countryIcon,
        //               countryName: 'Kuwait',
        //               reViewLength: 3,
        //               teacherName: 'Ahmed Ali',
        //               buttonTap: () {},
        //             );
        //           },
        //           separatorBuilder: (BuildContext context, int index) {
        //             return const SizedBox(
        //               width: 15,
        //             );
        //           },
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       const SizedBox(
        //         height: 200,
        //       )
        //     ],
        //   ),
        // );
      ],
    );
  }
}
