import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/app_button/app_button.dart';
import '../../../custom/choice/choice.dart';
import '../../../custom/divider/divider.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/extension/colors_extension.dart';
import '../viewModel/preference_view_model.dart';

class PreferenceView extends StatefulWidget {
  const PreferenceView({super.key});

  @override
  State<PreferenceView> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends State<PreferenceView>
    with TickerProviderStateMixin {
  List<String> choicesValue = [];
  late final AnimationController _controller;
  Set<String> selectedGrade = {};
  Set<String> selectedSchool = {};
  int? value = 0;
  int isSelect = 0;
  Set<int> selectedSchoolIndices = Set<int>();
  Set<int> selectedCurriculumIndices = Set<int>();
  Set<int> selectedSubjectIndices = Set<int>();
  List<String> school = [
    "Public",
    "Private",
  ];
  List<String> curriculum = [
    "Arabic",
    "American",
    "British",
  ];
  List<String> Subject = [
    "Arabic",
    "Math",
    "Science",
    "Islamic",
    "Physics",
    "Chemisty",
    "English",
    "French",
    "Deutsch",
    "Arts",
  ];

  final choicesMemoizer = AsyncMemoizer<List<dynamic>>();

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

  void setChoicesValue(List<String> value) {
    setState(() => choicesValue = value);
  }

  void setSchoolValue(List<String> value) {
    setState(() => school = value);
  }

  Future<List<dynamic>> getChoices() async {
    try {
      const url = "https://randomuser.me/api/?inc=name,picture,email&results=5";
      final res = await Dio().get(url);
      final data = res.data['results'];
      return Future.value(data);
    } on DioException catch (e) {
      throw ErrorDescription(e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PreferenceViewModel>(
      viewModel: PreferenceViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<List<dynamic>>(
          initialData: const [],
          future: choicesMemoizer.runOnce(getChoices),
          builder: (context, snapshot) {
            final choices = snapshot.data ?? [];
            return Scaffold(
              body: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: SafeArea(
                        child: Text(
                          'Customization',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0, color: Colors.transparent),
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
                        title: const Text(
                          'Customize your education journey now!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        subtitle: const Text(
                            'Tailor your education journey by selecting preferences for a personalized experience'),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Grade',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Select 1 or more',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: InlineChoice<String>(
                          clearable: true,
                          loading: snapshot.connectionState ==
                              ConnectionState.waiting,
                          value: choicesValue,
                          onChanged: setChoicesValue,
                          itemCount: choices.length,
                          itemBuilder: (selection, i) {
                            final choice = choices.elementAt(i);
                            final value = choice['email'];
                            final label = choice['name']['first'] +
                                ' ' +
                                choice['name']['last'];
                            // final avatar = choice['picture']['thumbnail'];
                            return ChoiceChip(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: selectedGrade.contains(value)
                                          ? AppColors.trans
                                          : AppColors.appBorderColor)),
                              backgroundColor: AppColors.trans,
                              selected: selectedGrade.contains(value),
                              onSelected: (isSelected) {
                                setState(() {
                                  if (isSelected) {
                                    selectedGrade.add(value);
                                  } else {
                                    selectedGrade.remove(value);
                                  }
                                });
                              },
                              showCheckmark: false,
                              label: Text(label),
                              selectedColor: AppColors
                                  .appColor, // Change this to your desired color
                              labelStyle: TextStyle(
                                color: selectedGrade.contains(value)
                                    ? AppColors.white
                                    : AppColors.black, // Change text color
                              ),
                            );
                          },
                          listBuilder: ChoiceList.createWrapped(
                              width: MediaQuery.of(context).size.width),
                        ),
                      ),
                    ),
                    const AppDivider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'School',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '(optional)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: school,
                      onChanged: setSchoolValue,
                      itemCount: school.length,
                      itemBuilder: (selection, index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: selectedSchoolIndices.contains(index)
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
                          label: Text(school[index]),
                          selectedColor: AppColors
                              .appColor, // Change this to your desired color
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
                        children: [
                          Text(
                            'Curriculum',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: curriculum,
                      onChanged: setSchoolValue,
                      itemCount: curriculum.length,
                      itemBuilder: (selection, index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color:
                                      selectedCurriculumIndices.contains(index)
                                          ? AppColors.trans
                                          : AppColors.appBorderColor)),
                          backgroundColor: AppColors.trans,
                          selected: selectedCurriculumIndices.contains(index),
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
                          label: Text(curriculum[index]),
                          selectedColor: AppColors
                              .appColor, // Change this to your desired color
                          labelStyle: TextStyle(
                            color: selectedCurriculumIndices.contains(index)
                                ? AppColors.white
                                : AppColors.black, // Change text color
                          ),
                        );
                      },
                      listBuilder: ChoiceList.createWrapped(),
                    ),
                    AppDivider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'Subject',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '(optional)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: Subject,
                      onChanged: setSchoolValue,
                      itemCount: Subject.length,
                      itemBuilder: (selection, index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: selectedSubjectIndices.contains(index)
                                      ? AppColors.trans
                                      : AppColors.appBorderColor)),
                          backgroundColor: AppColors.trans,
                          selected: selectedSubjectIndices.contains(index),
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
                          label: Text(Subject[index]),
                          selectedColor: AppColors
                              .appColor, // Change this to your desired color
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
                          title: 'Save My Preferences', onPressed: () {}),
                    )
                  ],
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}
