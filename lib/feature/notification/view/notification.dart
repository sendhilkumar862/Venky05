import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/appbar/appbar.dart';
import '../../../custom/image/app_image_assets.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';
import '../viewModel/notification_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(
      viewModel: NotificationViewModel(),
      onModelReady: (NotificationViewModel model) {
        model.init();
        model.setContext(context);
      },
      onPageBuilder:
          (BuildContext context, NotificationViewModel notificationViewModel) =>
              Scaffold(
        appBar: HessaAppBar(
          isTitleOnly: true,
          title: 'notification'.tr(),
          isBack: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
          child: Column(
            children: [
              Row(
                children: [
                  AppImageAsset(
                    image: ImageConstants.upDownArrow,
                    height: 16.px,
                    width: 16.px,
                  ),
                  SizedBox(width: 8.px),
                  AppText(
                    'Sort',
                    fontSize: 14.px,
                    color: AppColors.appBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today',
                            style: openSans.get12.w700.copyWith(
                                color:
                                    AppColors.appTextColor.withOpacity(0.5))),
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Container(),
                                Text('datat',
                                    style: openSans.get12.w700.copyWith(
                                        color: AppColors.appTextColor
                                            .withOpacity(0.5))),
                              ],
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
