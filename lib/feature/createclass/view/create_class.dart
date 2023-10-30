import 'package:flutter/material.dart';

import '../../../product/constants/colors/app_colors_constants.dart';

class SchoolList {
  SchoolList({
    required this.isSelect,
    required this.title,
  });
  final String title;
  late bool isSelect;
}

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  List<String> grade = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    'University',
  ];
  List<SchoolList> school = <SchoolList>[
    SchoolList(isSelect: false, title: 'Public'),
    SchoolList(isSelect: false, title: 'Private'),
  ];
  List<SchoolList> subject = <SchoolList>[
    SchoolList(isSelect: false, title: 'Arabic'),
    SchoolList(isSelect: false, title: 'Math'),
    SchoolList(isSelect: false, title: 'Science'),
    SchoolList(isSelect: false, title: 'Islamic'),
    SchoolList(isSelect: false, title: 'physics'),
    SchoolList(isSelect: false, title: 'Chemisty'),
    SchoolList(isSelect: false, title: 'English'),
    SchoolList(isSelect: false, title: 'French'),
    SchoolList(isSelect: false, title: 'Deutsch'),
    SchoolList(isSelect: false, title: 'Arts'),
  ];
  int isGradeSelect = 0;
  int isSchoolSelect = 0;
  int isSubjectSelect = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // var std
    // List<EmiAmount> emiData = [
    //   EmiAmount(std:"6 Month" ),
    // ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          const Text('Create Class',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          TextButton(
              onPressed: () {},
              child: const Text('Cancel',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)))
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Class Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text('Grade',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              Wrap(
                  children: List.generate(
                      grade.length,
                      (int index) => InkWell(
                            onTap: () {
                              setState(() {
                                isGradeSelect = index;
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              height: 32,
                              width: grade[index] == 'University' ? 83 : 50,
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: isGradeSelect == index
                                      ? const Color(0xff002BC7)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: const Color(0xffC5CEEE))),
                              child: Center(
                                  child: Text(
                                grade[index],
                                style: TextStyle(
                                    color: isGradeSelect != index
                                        ? const Color(0xff051335).withOpacity(0.5)
                                        : Colors.white),
                              )),
                            ),
                          ))),
              const Divider(),
              const Text('School',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              Wrap(
                  children: List.generate(
                      school.length,
                      (int index) => InkWell(
                            onTap: () {
                              setState(() {
                                school[index].isSelect =
                                    !school[index].isSelect;
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              height: 32,
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: school[index].isSelect
                                      ? const Color(0xff002BC7)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: const Color(0xffC5CEEE))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 7),
                                child: FittedBox(
                                  child: Center(
                                    child: Text(
                                      school[index].title,
                                      style: TextStyle(
                                          color: school[index].isSelect == false
                                              ? const Color(0xff051335)
                                                  .withOpacity(0.5)
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Subject',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              Wrap(
                  children: List.generate(
                      subject.length,
                      (int index) => InkWell(
                            onTap: () {
                              setState(() {
                                subject[index].isSelect =
                                    !subject[index].isSelect;
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              height: 32,
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: subject[index].isSelect
                                      ? const Color(0xff002BC7)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: const Color(0xffC5CEEE))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 7),
                                child: FittedBox(
                                  child: Center(
                                    child: Text(
                                      subject[index].title,
                                      style: TextStyle(
                                          color:
                                              subject[index].isSelect == false
                                                  ? const Color(0xff051335)
                                                      .withOpacity(0.5)
                                                  : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('class summary',
                    style:
                        TextStyle(color: const Color(0xff051335).withOpacity(0.5))),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xff051335).withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    hintText: 'class summary',
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff051335))),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Divider(
                  height: 1,
                  color: Color(0xffC5CEEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff002BC7)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () {},
                    child: const Text(
                      'Next for Class Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmiAmount {
  EmiAmount({
    required this.std,
  });
  final String std;
}
