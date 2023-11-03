import 'package:flutter/material.dart';

import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/choice/src/inline/list.dart';
import '../../../../custom/choice/src/inline/main.dart';
import '../../../../custom/choice/src/selection/controller/main.dart';
import '../../../../custom/divider/divider.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppButton(
            title: '',
            onPressed: () {
              locationModalBottomSheet();
            },
            isDisable: false,
          )
        ],
      ),
    );
  }

  void locationModalBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
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
                            const AppText('Sort / Filter',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.appTextColor),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 80),
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
                          ]),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: AppText('Sort by',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.appTextColor),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: shortByList,
                      onChanged: setSchoolValue,
                      itemCount: shortByList.length,
                      itemBuilder:
                          (ChoiceController<String> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: shortBy.contains(index)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor
                                          .withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: shortBy.contains(index),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                shortBy.add(
                                    index); // Add to the set for multi-selection
                              } else {
                                shortBy.remove(index); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(shortByList[index],
                                style: openSans.get12.w600),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: AppText('Filter by',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.appTextColor),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: filterByList,
                      onChanged: setSchoolValue,
                      itemCount: filterByList.length,
                      itemBuilder:
                          (ChoiceController<String> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: filterBy.contains(index)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor
                                          .withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: filterBy.contains(index),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                filterBy.add(
                                    index); // Add to the set for multi-selection
                              } else {
                                filterBy.remove(index); // Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(filterByList[index],
                                style: openSans.get12.w600),
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
                        title: 'Clear Selections',
                        isDisable: shortBy.isNotEmpty || filterBy.isNotEmpty
                            ? false
                            : true,
                      ),
                    ),
                  ]),
            );
          });
        });
  }
}
