import 'package:async/async.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hessah/config/routes/app_router.dart';
import 'package:hessah/config/routes/routes.dart';
import 'package:hessah/product/network/local/key_value_storage_service.dart';
import 'package:lottie/lottie.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/choice/choice.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/constants/app/app_constants.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/extension/colors_extension.dart';
import '../../../product/network/local/key_value_storage_base.dart';
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
  KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
  String selectedProfile = '';
/*  Set<String> selectedGrade = <String>{};
  Set<String> selectedSchool = <String>{};*/
  int? value = 0;
  int isSelect = 0;
/*  Set<int> selectedSchoolIndices = <int>{};
  Set<int> selectedCurriculumIndices = <int>{};
  Set<int> selectedSubjectIndices = <int>{};*/

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
              Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Observer(
              builder: (_) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: SafeArea(
                                child: Text(
                                  'customization'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
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
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                subtitle: Text('msgCustomization'.tr()),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'grade'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
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
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: InlineChoice<Curriculum>(
                                  clearable: true,
                                  loading: preferenceViewModel.grade?.isEmpty ??
                                      true,
                                  value: preferenceViewModel.grade ??
                                      <Curriculum>[],
                                  //onChanged: setChoicesValue,
                                  itemCount:
                                      preferenceViewModel.grade?.length ?? 0,
                                  itemBuilder:
                                      (ChoiceController<Curriculum> selection,
                                          int index) {
                                    return ChoiceChip(
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: preferenceViewModel
                                                      .selectedGrade
                                                      .contains(
                                                          preferenceViewModel
                                                                  .grade?[index]
                                                                  .value ??
                                                              emptyString)
                                                  ? AppColors.trans
                                                  : AppColors.appBorderColor)),
                                      backgroundColor: AppColors.trans,
                                      selected: preferenceViewModel
                                          .selectedGrade
                                          .contains(preferenceViewModel
                                                  .grade?[index].value ??
                                              emptyString),
                                      onSelected: (bool isSelected) {
                                        setState(() {
                                          if (isSelected) {
                                            preferenceViewModel.selectedGrade
                                                .add(preferenceViewModel
                                                        .grade?[index].value ??
                                                    emptyString);
                                          } else {
                                            preferenceViewModel.selectedGrade
                                                .remove(preferenceViewModel
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
                                        color: preferenceViewModel.selectedGrade
                                                .contains(preferenceViewModel
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
                            if (preferenceViewModel.selectedGrade.isNotEmpty)
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
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
                            if (preferenceViewModel.selectedGrade.isNotEmpty)
                              InlineChoice<Curriculum>(
                                clearable: true,
                                loading:
                                    preferenceViewModel.schoolType?.isEmpty ??
                                        true,
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
                                            color: preferenceViewModel
                                                    .selectedSchoolIndices
                                                    .contains(
                                                        preferenceViewModel
                                                                .schoolType?[
                                                                    index]
                                                                .value ??
                                                            emptyString)
                                                ? AppColors.trans
                                                : AppColors.appBorderColor)),
                                    backgroundColor: AppColors.trans,
                                    selected: preferenceViewModel
                                        .selectedSchoolIndices
                                        .contains(preferenceViewModel
                                                .schoolType?[index].value ??
                                            emptyString),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          preferenceViewModel
                                              .selectedSchoolIndices
                                              .add(preferenceViewModel
                                                      .schoolType?[index]
                                                      .value ??
                                                  emptyString); // Add to the set for multi-selection
                                        } else {
                                          preferenceViewModel
                                              .selectedSchoolIndices
                                              .remove(preferenceViewModel
                                                      .schoolType?[index]
                                                      .value ??
                                                  emptyString); // Remove from the set
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
                                      color: preferenceViewModel
                                              .selectedSchoolIndices
                                              .contains(preferenceViewModel
                                                      .schoolType?[index]
                                                      .value ??
                                                  emptyString)
                                          ? AppColors.white
                                          : AppColors
                                              .black, // Change text color
                                    ),
                                  );
                                },
                                listBuilder: ChoiceList.createWrapped(),
                              ),
                            if (preferenceViewModel.selectedGrade.isNotEmpty)
                              AppDivider(),
                            if (preferenceViewModel
                                .selectedSchoolIndices.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                            if (preferenceViewModel
                                .selectedSchoolIndices.isNotEmpty)
                              InlineChoice<Curriculum>(
                                clearable: true,
                                value: preferenceViewModel.curriculum ??
                                    <Curriculum>[],
                                loading:
                                    preferenceViewModel.curriculum?.isEmpty ??
                                        true,
                                //onChanged: setSchoolValue,
                                itemCount:
                                    preferenceViewModel.curriculum?.length ?? 0,
                                itemBuilder:
                                    (ChoiceController<Curriculum> selection,
                                        int index) {
                                  return ChoiceChip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: preferenceViewModel
                                                    .selectedCurriculumIndices
                                                    .contains(
                                                        preferenceViewModel
                                                                .curriculum?[
                                                                    index]
                                                                .value ??
                                                            emptyString)
                                                ? AppColors.trans
                                                : AppColors.appBorderColor)),
                                    backgroundColor: AppColors.trans,
                                    selected: preferenceViewModel
                                        .selectedCurriculumIndices
                                        .contains(preferenceViewModel
                                                .curriculum?[index].value ??
                                            emptyString),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          preferenceViewModel
                                              .selectedCurriculumIndices
                                              .add(preferenceViewModel
                                                      .curriculum?[index]
                                                      .value ??
                                                  emptyString); // Add to the set for multi-selection
                                        } else {
                                          preferenceViewModel
                                              .selectedCurriculumIndices
                                              .remove(preferenceViewModel
                                                      .curriculum?[index]
                                                      .value ??
                                                  emptyString); // Remove from the set
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
                                      color: preferenceViewModel
                                              .selectedCurriculumIndices
                                              .contains(preferenceViewModel
                                                      .curriculum?[index]
                                                      .value ??
                                                  emptyString)
                                          ? AppColors.white
                                          : AppColors
                                              .black, // Change text color
                                    ),
                                  );
                                },
                                listBuilder: ChoiceList.createWrapped(),
                              ),
                            if (preferenceViewModel
                                .selectedSchoolIndices.isNotEmpty)
                              AppDivider(),
                            if (preferenceViewModel
                                .selectedCurriculumIndices.isNotEmpty)
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
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
                            if (preferenceViewModel
                                .selectedCurriculumIndices.isNotEmpty)
                              InlineChoice<Curriculum>(
                                clearable: true,
                                loading: preferenceViewModel.subject?.isEmpty ??
                                    true,
                                value: preferenceViewModel.subject ??
                                    <Curriculum>[],
                                //onChanged: setSchoolValue,
                                itemCount:
                                    preferenceViewModel.subject?.length ?? 0,
                                itemBuilder:
                                    (ChoiceController<Curriculum> selection,
                                        int index) {
                                  return ChoiceChip(
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: preferenceViewModel
                                                    .selectedSubjectIndices
                                                    .contains(index)
                                                ? AppColors.trans
                                                : AppColors.appBorderColor)),
                                    backgroundColor: AppColors.trans,
                                    selected: preferenceViewModel
                                        .selectedSubjectIndices
                                        .contains(preferenceViewModel
                                                .subject?[index].value ??
                                            emptyString),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          preferenceViewModel
                                              .selectedSubjectIndices
                                              .add(preferenceViewModel
                                                      .subject?[index].value ??
                                                  emptyString); // Add to the set for multi-selection
                                        } else {
                                          preferenceViewModel
                                              .selectedSubjectIndices
                                              .remove(preferenceViewModel
                                                      .subject?[index].value ??
                                                  emptyString); // Remove from the set
                                        }
                                      });
                                    },
                                    showCheckmark: false,
                                    label: Text(preferenceViewModel
                                            .subject?[index].value ??
                                        emptyString),
                                    selectedColor: AppColors
                                        .appBlue, // Change this to your desired color
                                    labelStyle: TextStyle(
                                      color: preferenceViewModel
                                              .selectedSubjectIndices
                                              .contains(preferenceViewModel
                                                      .subject?[index].value ??
                                                  emptyString)
                                          ? AppColors.white
                                          : AppColors
                                              .black, // Change text color
                                    ),
                                  );
                                },
                                listBuilder: ChoiceList.createWrapped(),
                              ),
                            if (preferenceViewModel
                                .selectedCurriculumIndices.isNotEmpty)
                              AppDivider(),
                          ],
                        ),
                      ),
                    ),
                    AppButton(
                        isDisable: preferenceViewModel.selectedGrade.isEmpty,
                        title: 'saveMyPreferences'.tr(),
                        onPressed: () {
                          preferenceViewModel.setUserPreference().then((value) {
                            Navigator.of(context).pop();
                            selectedProfile = keyValueStorageBase.getCommon(
                                    String, KeyValueStorageService.profile) ??
                                '';
                            if (selectedProfile ==
                                ApplicationConstants.student) {
                              AppRouter.pushNamed(Routes.HomeScreenRoute);
                            }
                          });
                        })
                  ],
                );
              },
            )),
      ),
    );
  }
}
