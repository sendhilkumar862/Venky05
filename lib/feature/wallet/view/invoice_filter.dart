import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../custom/app_button/app_button.dart';
import '../../../custom/choice/src/inline/list.dart';
import '../../../custom/choice/src/inline/main.dart';
import '../../../custom/choice/src/selection/controller/main.dart';
import '../../../custom/divider/divider.dart';
import '../../../custom/text/app_text.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/utils/typography.dart';

class InvoiceFilter extends StatefulWidget {
  const InvoiceFilter({super.key});

  @override
  State<InvoiceFilter> createState() => _InvoiceFilterState();
}

class _InvoiceFilterState extends State<InvoiceFilter> {
  List<String> shortByList = <String>[
    'Date',
    'Old to New',
    'New to Old',
    'Amount',
    'Low to High',
    'High to Low',
  ];
  List<String> filterByList = <String>[
    'Class Cost',
    'WithDraw',
    'Subscription',
  ];
  void filterByValue(List<String> value) {
    setState(() => shortByList = value);
  }

  void setSchoolValue(List<String> value) {
    setState(() => filterByList = value);
  }

  Set<int> shortBy = <int>{};
  Set<int> filterBy = <int>{};
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                     Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AppText('sort/Filter'.tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.appTextColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 80),
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
                  ]),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 2),
              child: AppText('sortBy'.tr(),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.appTextColor),
            ),
            InlineChoice<String>(
              clearable: true,
              value: shortByList,
              onChanged: setSchoolValue,
              itemCount: shortByList.length,
              itemBuilder: (ChoiceController<String> selection, int index) {
                return ChoiceChip(
                  shape: StadiumBorder(
                      side: BorderSide(
                          color: shortBy.contains(index)
                              ? AppColors.trans
                              : AppColors.appBorderColor.withOpacity(0.25))),
                  backgroundColor: AppColors.trans,
                  selected: shortBy.contains(index),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        shortBy
                            .add(index); // Add to the set for multi-selection
                      } else {
                        shortBy.remove(index); // Remove from the set
                      }
                    });
                  },
                  showCheckmark: false,
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(shortByList[index], style: openSans.get12.w600),
                  ),
                  selectedColor: AppColors.appBlue,
                  // Change this to your desired color
                  labelStyle: TextStyle(
                    color: shortBy.contains(index)
                        ? AppColors.white
                        : AppColors.appTextColor
                            .withOpacity(0.5), // Change text color
                  ),
                );
              },
              listBuilder: ChoiceList.createWrapped(),
            ),
            AppDivider(),
             Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: AppText('filterBy'.tr(),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.appTextColor),
            ),
            InlineChoice<String>(
              clearable: true,
              value: filterByList,
              onChanged: setSchoolValue,
              itemCount: filterByList.length,
              itemBuilder: (ChoiceController<String> selection, int index) {
                return ChoiceChip(
                  shape: StadiumBorder(
                      side: BorderSide(
                          color: filterBy.contains(index)
                              ? AppColors.trans
                              : AppColors.appBorderColor.withOpacity(0.25))),
                  backgroundColor: AppColors.trans,
                  selected: filterBy.contains(index),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filterBy
                            .add(index); // Add to the set for multi-selection
                      } else {
                        filterBy.remove(index); // Remove from the set
                      }
                    });
                  },
                  showCheckmark: false,
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child:
                        Text(filterByList[index], style: openSans.get12.w600),
                  ),
                  selectedColor: AppColors.appBlue,
                  // Change this to your desired color
                  labelStyle: TextStyle(
                    color: filterBy.contains(index)
                        ? AppColors.white
                        : AppColors.appTextColor
                            .withOpacity(0.5), // Change text color
                  ),
                );
              },
              listBuilder: ChoiceList.createWrapped(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: AppButton(
                onPressed: () {},
                title: 'clearSelections'.tr(),
                isDisable:
                    shortBy.isNotEmpty || filterBy.isNotEmpty ? false : true,
              ),
            ),
          ]),
    );
  }
}
