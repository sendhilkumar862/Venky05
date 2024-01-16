import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../config/routes/route.dart';
import '../../../../custom/app_button/app_button.dart';
import '../../../../custom/app_textformfield/text_field.dart';
import '../../../../custom/appbar/appbar.dart';
import '../../../../custom/cardView/info_card_view.dart';
import '../../../../custom/cardView/status_card_view.dart';
import '../../../../custom/choice/src/inline/list.dart';
import '../../../../custom/choice/src/inline/main.dart';
import '../../../../custom/choice/src/selection/controller/main.dart';
import '../../../../custom/image/app_image_assets.dart';
import '../../../../custom/sheet/show_bottom_sheet.dart';
import '../../../../custom/text/app_text.dart';
import '../../../../product/constants/colors/app_colors_constants.dart';
import '../../../../product/constants/image/image_constants.dart';
import '../../../../product/extension/string_extension.dart';
import '../../../../product/utils/typography.dart';
import '../Model/get_tickets_request_model.dart';
import '../controller/app_support_controller.dart';


class AppSupportView extends StatefulWidget {
  const AppSupportView({super.key});

  @override
  State<AppSupportView> createState() => _AppSupportViewState();
}

class _AppSupportViewState extends State<AppSupportView> {



  void setSchoolValue(List<String> value) {
    setState(() => _appSupportController.filterByList = value);
  }



  final AppSupportController _appSupportController =
  Get.put(AppSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HessaAppBar(
        title: 'App Support',
        isTitleOnly: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(()=>
            _appSupportController.isInitial.value?activeScreen():Center(
              child: SizedBox(
                height: 250,
                child: InfoCardVIew(
                  isShowButton: true,
                  title: 'No Tickets Found!',
                  subTitle:
                  'No tickets found. Please refine your search.',
                  cardColor: AppColors.white,
                  buttonTitle: 'Open New Ticket',
                  buttonTap: (){
                    Get.toNamed(Routes.newTicketView,arguments: false);
                  },
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget activeScreen(){
    return Obx(()=>
       Column(
         children: <Widget>[
           TextFormsField(
             controller: _appSupportController
                 .searchTicketController,
             // ignore: always_specify_types
             onChanged: (searchValue){
               if(searchValue.isNotEmpty)
               {
                 EasyDebounce.debounce(
                     'my-debounced', // <-- An ID for this particular debouncer
                     const Duration(milliseconds: 500), // <-- The debounce duration
                         ()=> _appSupportController.getTickets());

               }
             },
             hintText: 'search Tickets',
             prefix: Padding(
               padding: EdgeInsets.only(left: 10.px),
               child: const AppImageAsset(
                   image: ImageConstants.searchIcon,
                   height: 20),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 10),
             child: InkWell(
               onTap: () {
                 filterBottomSheet(context);
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   AppText(
                     'Sort / Filter',
                     fontSize: 14.px,
                     color: AppColors.appBlue,
                     fontWeight: FontWeight.w600,
                   ),
                   SizedBox(width: 5.px),
                   AppImageAsset(
                     image: ImageConstants.filterSettings,
                     height: 16.px,
                     width: 16.px,
                   ),
                 ],
               ),
             ),
           ),
           if(_appSupportController.getTicketsList.isEmpty)const Spacer(),
           if (_appSupportController.getTicketsList.isNotEmpty) Expanded(
               child: ListView.builder(
                 itemCount: _appSupportController.getTicketsList.length,
                 shrinkWrap: true,
                 physics: const AlwaysScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                   return Padding(
                     padding: const EdgeInsets.only(top: 10),
                     child: Column(
                       children: <Widget>[
                         GestureDetector(
                           onTap: (){
                             _appSupportController.appSupportDetailIndex=index;
                             Get.toNamed(Routes.pendingTickets);},
                           child: Row(
                             children: <Widget>[
                               Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text(
                                     _appSupportController.getTicketsList[index].title!=null?_appSupportController.getTicketsList[index].title!:'',
                                     style: openSans.get14.w500,
                                   ),
                                   Text(
                                     _appSupportController.getTicketsList[index].ticketId!=null?'#${_appSupportController.getTicketsList[index].ticketId!}':'',
                                     style: openSans.get10.w400.textColor(
                                         AppColors.appTextColor
                                             .withOpacity(0.5)),
                                   ),
                                   Text(
                                     _appSupportController.getTicketsList[index].createdAt!=null?_appSupportController.getTicketsList[index].createdAt!.toString().epochToNormal():'',
                                     style: openSans.get10.w400.textColor(
                                         AppColors.appTextColor
                                             .withOpacity(0.5)),
                                   ),
                                 ],
                               ),
                               const Spacer(),
                               Padding(
                                 padding: const EdgeInsets.only(right: 10),
                                 child: StatusCardView(status: _appSupportController.getTicketsList[index].status!=null? _appSupportController.getTicketsList[index].status!:'',),),
                               const Icon(
                                 Icons.arrow_forward_ios_rounded,
                                 size: 12,
                                 color: AppColors.arrowColor,
                               )
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top: 8.0),
                           child: Divider(
                             color:
                             AppColors.appBorderColor.withOpacity(0.5),
                           ),
                         )
                       ],
                     ),
                   );
                 },
               ),
             ) else InfoCardVIew(
               isShowButton: false,
               title: 'No Tickets Found!',
               subTitle:
               'No tickets found. Please refine your search.',
               cardColor: AppColors.white,
               buttonTitle: 'Open New Ticket',
             ),

           if(_appSupportController.getTicketsList.isEmpty)const Spacer(),
           Align(
             alignment: Alignment.bottomCenter,
             child: AppButton(
                 isDisable: false,
                 title: 'Open New Ticket',
                 onPressed: () {
                   Get.toNamed(Routes.newTicketView,arguments: false);
                 }),
           )
         ],
       ),
    );
  }

  void filterBottomSheet(BuildContext context) {
    return showCommonBottomSheet(
        context: context,
        showDragHandle: false,
        commonWidget: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10),
                      child: Row(children: [
                        const Spacer(flex: 2,),
                        const AppText('Sort / Filter',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.appTextColor),
                        const Spacer(flex: 1,),
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
                      ],),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right:10.0),
                          child: AppText('Date',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.appGrey),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width-100.px,
                          child: InlineChoice<String>(
                            clearable: true,
                            value: _appSupportController.shortByList,
                            onChanged: setSchoolValue,
                            itemCount: _appSupportController.shortByList.length,
                            itemBuilder:
                                (ChoiceController<String> selection, int index) {
                              return ChoiceChip(
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: _appSupportController.shortBy==index
                                            ? AppColors.trans
                                            : AppColors.appBorderColor
                                                .withOpacity(0.25))),
                                backgroundColor: AppColors.trans,
                                selected: _appSupportController.shortBy==index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _appSupportController.shortBy=index; // Add to the set for multi-selection
                                    } else {
                                      _appSupportController.shortBy=-1; // Remove from the set
                                    }

                                  });
                                  _appSupportController.getTickets();
                                },
                                showCheckmark: false,
                                label: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(_appSupportController.shortByList[index],
                                      style: openSans.get12.w600),
                                ),
                                selectedColor: AppColors.appBlue,
                                // Change this to your desired color
                                labelStyle: TextStyle(
                                  color: _appSupportController.shortBy==index
                                      ? AppColors.white
                                      : AppColors.appTextColor
                                          .withOpacity(0.5), // Change text color
                                ),
                              );
                            },
                            listBuilder: ChoiceList.createWrapped(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Divider(
                        height: 1,
                        color: const Color(0xffC5CEEE).withOpacity(0.5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 2),
                      child: AppText('Filter by',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.appTextColor),
                    ),
                    InlineChoice<String>(
                      clearable: true,
                      value: _appSupportController.filterByList,
                      onChanged: setSchoolValue,
                      itemCount: _appSupportController.filterByList.length,
                      itemBuilder:
                          (ChoiceController<String> selection, int index) {
                        return ChoiceChip(
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: _appSupportController.filterBy.contains(_appSupportController.filterByList[index])
                                      ? AppColors.trans
                                      : AppColors.appBorderColor
                                          .withOpacity(0.25))),
                          backgroundColor: AppColors.trans,
                          selected: _appSupportController.filterBy.contains(_appSupportController.filterByList[index]),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _appSupportController.filterBy.add(_appSupportController.filterByList[index]);
                                _appSupportController.getTickets();// Add to the set for multi-selection
                              } else {
                                _appSupportController.filterBy.remove(_appSupportController.filterByList[index]);
                                _appSupportController.getTickets();// Remove from the set
                              }
                            });
                          },
                          showCheckmark: false,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(_appSupportController.filterByList[index],
                                style: openSans.get12.w600),
                          ),
                          selectedColor: AppColors.appBlue,
                          // Change this to your desired color
                          labelStyle: TextStyle(
                            color: _appSupportController.filterBy.contains(_appSupportController.filterByList[index])
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
                        onPressed: () {
                        setState(() {
                          _appSupportController.shortBy=-1;
                          _appSupportController.filterBy.clear();
                           });
                        _appSupportController.getTickets();
                        },
                        title: 'Clear Selections',
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        isDisable: _appSupportController.shortBy!=-1 || _appSupportController.filterBy.isNotEmpty
                            ? false
                            : true,
                      ),
                    ),
                  ]),
            );
          },
        ));
  }
}
