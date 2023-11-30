import 'package:flutter/material.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/choice/src/modal/button.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/utils/typography.dart';
import '../../../class/class_detail/view/class_detail.dart';

class ManageAddressView extends StatefulWidget {
  const ManageAddressView({super.key});

  @override
  State<ManageAddressView> createState() => _ManageAddressViewState();
}

class _ManageAddressViewState extends State<ManageAddressView> {
//==============================================================================
// ** Properties **
//==============================================================================
  List<Address> location = <Address>[
    Address('Home', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    Address('Work', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    Address('Home', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
    Address('Work', 'City, Block No., Street Name, Street Name 2, HouseNo.,',
        'Floor No., Apartment No.'),
  ];
  int? selectedIndex;

//==============================================================================
// ** Life Cycle **
//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Text('Class Location', style: openSans.get20.w700),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.downArrowColor.withOpacity(0.15)),
                child: const Padding(
                  padding: EdgeInsets.all(3),
                  child: Icon(Icons.close),
                ),
              ),
            ),
          )
        ]),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: location.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Address data = location[index];
                    return listData(index, data, setState);
                  }),
            ],
          ),
        ),
      ),
      AppButton(
        onPressed: () {},
        title: 'Add New Address',
      ),
    ]);
  }
//==============================================================================
// ** Helper Widget **
//==============================================================================
  Widget listData(int index, Address data, StateSetter setState) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(data.heading, style: openSans.get17.w700),
                          if (selectedIndex == index)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color(0xfff0f5ff),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: Text('Default'),
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
                      // if (selectedIndex == index)
                      //   iconButtonWidget(
                      //       icon: Icons.done,
                      //       bgColor: AppColors.appColor,
                      //       iconSize: 18),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(data.address1),
                      Text(data.address2),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      iconButtonWidget(
                        icon: Icons.delete_outline_rounded,
                        padding: 8,
                        bgColor: AppColors.appRed,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: selectedIndex != index ? 10 : 0),
                        child: iconButtonWidget(
                          icon: Icons.edit,
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
                                backgroundColor:
                                    MaterialStatePropertyAll(AppColors.appBlue),
                                shape:
                                    MaterialStatePropertyAll(StadiumBorder())),
                            child: const Text('Set Default',
                                style: TextStyle(color: AppColors.white)))
                    ]),
              ],
            ),
          ),
        ));
  }

  Widget iconButtonWidget(
      {Color? bgColor,
      required IconData icon,
      double? iconSize,
      double? padding,
      void Function()? onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? AppColors.secondaryColor),
          child: Icon(
            icon,
            size: iconSize ?? 23,
            color: AppColors.white,
          )),
    );
  }
}
