// ignore_for_file: always_specify_types, sort_constructors_first, avoid_dynamic_calls

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../custom/choice/src/modal/button.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/constants/image/image_constants.dart';
import '../../../product/utils/typography.dart';

class ListData extends StatefulWidget {
  final List<CommonClass> commonList;
  final Widget? label;
  final Widget? image;

  const ListData({
    super.key,
    required this.commonList,
    this.label,
    this.image,
  });

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.commonList.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedIndex == index
                        ? AppColors.appBlue
                        : AppColors.gray.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(widget.commonList[index].heading,
                                  style: openSans.get17.w700),
                              if (selectedIndex == index)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color(0xfff0f5ff),
                                      ),
                                      child:  Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        child: Text('default'.tr()),
                                      )),
                                ),
                            ],
                          ),
                          if (selectedIndex == index)
                            const ChoiceConfirmButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: AppColors.appBlue,
                              ),
                            )
                          else
                            ChoiceConfirmButton(
                                icon: Icon(
                              Icons.circle_outlined,
                              color: AppColors.gray.withOpacity(0.25),
                            ))
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 13),
                      child: Row(
                        children: [
                          widget.label ?? const SizedBox.shrink(),
                          Expanded(
                            child: Text(widget.commonList[index].title,
                                overflow: TextOverflow.visible),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        widget.image ?? SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(widget.commonList[index].subTitle),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          iconButtonWidget(
                            icon: ImageConstants.delete,
                            padding: 8,
                            bgColor: AppColors.secondaryRed,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10,
                                right: selectedIndex != index ? 10 : 0),
                            child: iconButtonWidget(
                              icon: ImageConstants.penEdit,
                              padding: 8,
                              bgColor: AppColors.appBlue,
                            ),
                          ),
                          if (selectedIndex != index)
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                  selectedIndex = index;
                                  print('selectedIndex:-- $selectedIndex');
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.appBlue),
                                    shape: MaterialStatePropertyAll(
                                        StadiumBorder())),
                                child:  Text('setDefault'.tr(),
                                    style: TextStyle(color: AppColors.white)))
                        ]),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget iconButtonWidget(
      {Color? bgColor,
      required String icon,
      double? iconSize,
      double? padding,
      void Function()? onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.secondaryColor),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                icon,
                height: 20,
                width: 20,
              ))),
    );
  }
}

class CommonClass {
  CommonClass(this.heading, this.title, this.subTitle);

  String heading;
  String title;
  String subTitle;
}
