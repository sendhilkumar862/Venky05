import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../custom/appbar/appbar.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/utils/typography.dart';
import 'for_students.dart';
import 'for_teacher.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HessaAppBar(
          trailingText: 'cancel'.tr(),
          title: 'search'.tr(),
          isTitleOnly: true,
        ),
        body: DefaultTabController(
          length: 2,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              surfaceVariant: Colors.red,
                            ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.tabColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TabBar(
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              // Use the default focused overlay color
                              return states.contains(MaterialState.focused)
                                  ? null
                                  : Colors.transparent;
                            }),
                            unselectedLabelColor:
                                AppColors.appTextColor.withOpacity(0.5),
                            unselectedLabelStyle: openSans.get13.w500.red,
                            labelStyle: openSans.get13.w500,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: AppColors.appBlue,
                            indicatorPadding: const EdgeInsets.all(5),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.white),
                            onTap: (int index) {},
                            tabs: <Widget>[
                              Tab(
                                text: 'searchForClasses'.tr(),
                              ),
                              Tab(
                                text: 'searchForTeacher'.tr(),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [ForStudents(), ForTeacher()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
