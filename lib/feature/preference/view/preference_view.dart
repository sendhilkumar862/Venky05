import 'package:async/async.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/choice/choice.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/extension/colors_extension.dart';
import '../model/preference_model.dart';
import '../viewModel/preference_view_model.dart';

class PreferenceView extends StatefulWidget {
  const PreferenceView({super.key});

  @override
  State<PreferenceView> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends State<PreferenceView>
    with TickerProviderStateMixin {
  List<String> choicesValue = <String>[];
  late final AnimationController _controller;
  Set<String> selectedGrade = <String>{};
  Set<String> selectedSchool = <String>{};
  int? value = 0;
  int isSelect = 0;
  Set<int> selectedSchoolIndices = <int>{};
  Set<int> selectedCurriculumIndices = <int>{};
  Set<int> selectedSubjectIndices = <int>{};

  final AsyncMemoizer<List> choicesMemoizer = AsyncMemoizer<List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PreferenceViewModel>(
      viewModel: PreferenceViewModel(),
      onModelReady: (PreferenceViewModel model) {
        model.init();
        model.setContext(context);
      },
      onPageBuilder:
          (BuildContext context, PreferenceViewModel preferenceViewModel) =>
              MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Observer(
                    builder: (_) {
                      return Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SafeArea(
                              child: Text(
                                'customization'.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0, color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.circular(20), //<-- SEE HERE
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              tileColor: HexColor('#F0F5FF'),
                              leading: Lottie.asset(
                                'assets/animations/building_animation.json',
                                controller: _controller,
                                onLoaded: (LottieComposition composition) {
                                  _controller.duration = composition.duration;
                                  _controller.repeat();
                                },
                              ),
                              title: Text(
                                'msgCustomizationNow'.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              subtitle: Text('msgCustomization'.tr()),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'grade'.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'selectMore'.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: InlineChoice<Curriculum>(
                                clearable: true,
                                loading:
                                    preferenceViewModel.grade?.isEmpty ?? true,
                                value:
                                    preferenceViewModel.grade ?? <Curriculum>[],
                                //onChanged: setChoicesValue,
                                itemCount:
                                    preferenceViewModel.grade?.length ?? 0,
                                itemBuilder:
                                    (ChoiceController<Curriculum> selection,
                                        int index) {
                                  return ChoiceChip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: selectedGrade.contains(
                                                    preferenceViewModel
                                                            .grade?[index]
                                                            .value ??
                                                        emptyString)
                                                ? AppColors.trans
                                                : AppColors.appBorderColor)),
                                    backgroundColor: AppColors.trans,
                                    selected: selectedGrade.contains(
                                        preferenceViewModel
                                                .grade?[index].value ??
                                            emptyString),
                                    onSelected: (bool isSelected) {
                                      setState(() {
                                        if (isSelected) {
                                          selectedGrade.add(preferenceViewModel
                                                  .grade?[index].value ??
                                              emptyString);
                                        } else {
                                          selectedGrade.remove(
                                              preferenceViewModel
                                                      .grade?[index].value ??
                                                  emptyString);
                                        }
                                      });
                                    },
                                    showCheckmark: false,
                                    label: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(preferenceViewModel
                                              .grade?[index].value ??
                                          emptyString),
                                    ),
                                    selectedColor: AppColors
                                        .appBlue, // Change this to your desired color
                                    labelStyle: TextStyle(
                                      color: selectedGrade.contains(
                                              preferenceViewModel
                                                      .grade?[index].value ??
                                                  emptyString)
                                          ? AppColors.white
                                          : AppColors
                                              .black, // Change text color
                                    ),
                                  );
                                },
                                listBuilder: ChoiceList.createWrapped(
                                    width: MediaQuery.of(context).size.width),
                              ),
                            ),
                          ),
                          AppDivider(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'school'.tr(),
                                  style: const TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'optional'.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InlineChoice<Curriculum>(
                            clearable: true,
                            loading:
                                preferenceViewModel.schoolType?.isEmpty ?? true,
                            value: preferenceViewModel.schoolType ??
                                <Curriculum>[],
                            itemCount:
                                preferenceViewModel.schoolType?.length ?? 0,
                            itemBuilder:
                                (ChoiceController<Curriculum> selection,
                                    int index) {
                              return ChoiceChip(
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: selectedSchoolIndices
                                                .contains(index)
                                            ? AppColors.trans
                                            : AppColors.appBorderColor)),
                                backgroundColor: AppColors.trans,
                                selected: selectedSchoolIndices.contains(index),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedSchoolIndices.add(
                                          index); // Add to the set for multi-selection
                                    } else {
                                      selectedSchoolIndices
                                          .remove(index); // Remove from the set
                                    }
                                  });
                                },
                                showCheckmark: false,
                                label: Text(preferenceViewModel
                                        .schoolType?[index].value ??
                                    emptyString),
                                selectedColor: AppColors
                                    .appBlue, // Change this to your desired color
                                labelStyle: TextStyle(
                                  color: selectedSchoolIndices.contains(index)
                                      ? AppColors.white
                                      : AppColors.black, // Change text color
                                ),
                              );
                            },
                            listBuilder: ChoiceList.createWrapped(),
                          ),
                          AppDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'curriculum'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          InlineChoice<Curriculum>(
                            clearable: true,
                            value: preferenceViewModel.curriculum ??
                                <Curriculum>[],
                            loading:
                                preferenceViewModel.curriculum?.isEmpty ?? true,
                            //onChanged: setSchoolValue,
                            itemCount:
                                preferenceViewModel.curriculum?.length ?? 0,
                            itemBuilder:
                                (ChoiceController<Curriculum> selection,
                                    int index) {
                              return ChoiceChip(
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: selectedCurriculumIndices
                                                .contains(index)
                                            ? AppColors.trans
                                            : AppColors.appBorderColor)),
                                backgroundColor: AppColors.trans,
                                selected:
                                    selectedCurriculumIndices.contains(index),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedCurriculumIndices.add(
                                          index); // Add to the set for multi-selection
                                    } else {
                                      selectedCurriculumIndices
                                          .remove(index); // Remove from the set
                                    }
                                  });
                                },
                                showCheckmark: false,
                                label: Text(preferenceViewModel
                                        .curriculum?[index].value ??
                                    emptyString),
                                selectedColor: AppColors
                                    .appBlue, // Change this to your desired color
                                labelStyle: TextStyle(
                                  color: selectedCurriculumIndices
                                          .contains(index)
                                      ? AppColors.white
                                      : AppColors.black, // Change text color
                                ),
                              );
                            },
                            listBuilder: ChoiceList.createWrapped(),
                          ),
                          AppDivider(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'subject'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'optional'.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InlineChoice<Curriculum>(
                            clearable: true,
                            loading:
                                preferenceViewModel.subject?.isEmpty ?? true,
                            value:
                                preferenceViewModel.subject ?? <Curriculum>[],
                            //onChanged: setSchoolValue,
                            itemCount: preferenceViewModel.subject?.length ?? 0,
                            itemBuilder:
                                (ChoiceController<Curriculum> selection,
                                    int index) {
                              return ChoiceChip(
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: selectedSubjectIndices
                                                .contains(index)
                                            ? AppColors.trans
                                            : AppColors.appBorderColor)),
                                backgroundColor: AppColors.trans,
                                selected:
                                    selectedSubjectIndices.contains(index),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedSubjectIndices.add(
                                          index); // Add to the set for multi-selection
                                    } else {
                                      selectedSubjectIndices
                                          .remove(index); // Remove from the set
                                    }
                                  });
                                },
                                showCheckmark: false,
                                label: Text(
                                    preferenceViewModel.subject?[index].value ??
                                        emptyString),
                                selectedColor: AppColors
                                    .appBlue, // Change this to your desired color
                                labelStyle: TextStyle(
                                  color: selectedSubjectIndices.contains(index)
                                      ? AppColors.white
                                      : AppColors.black, // Change text color
                                ),
                              );
                            },
                            listBuilder: ChoiceList.createWrapped(),
                          ),
                          AppDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: AppButton(
                                title: 'saveMyPreferences'.tr(),
                                onPressed: () {}),
                          )
                        ],
                      );
                    },
                  ))),
        ),
      ),
    );
  }
}
