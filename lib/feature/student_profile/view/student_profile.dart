import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../viewModel/student_profile_view_model.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView>
    with TickerProviderStateMixin {
  List<String> choicesValue = [];
  late final AnimationController _controller;
  final choicesMemoizer = AsyncMemoizer<List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
    return BaseView<StudentProfileViewModel>(
      viewModel: StudentProfileViewModel(),
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                leading: const Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text(
                  'Student Profile',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: SingleChildScrollView(
                  child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Mr. '),
                        Text('User Name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Message',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Unfavorite',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ]),
                        ),
                      ],
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
