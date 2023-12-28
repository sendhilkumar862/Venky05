// import 'package:get/get.dart';
//
// import '../../../../product/network/local/key_value_storage_base.dart';
// import '../../../../product/network/local/key_value_storage_service.dart';
//
// class ProposalDetailController extends GetxController{
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchMap();
//     getProfile();
//   }
//
//   KeyValueStorageBase keyValueStorageBase = KeyValueStorageBase();
//   final KeyValueStorageService keyValueStorageService =
//   KeyValueStorageService();
//
//   @observable
//   String selectedProfile = '';
//
//   @observable
//   CameraPosition? kGooglePlex;
//
//   @observable
//   Completer<GoogleMapController> mapController =
//   Completer<GoogleMapController>();
//
//   List<Header> dataList = [
//     Header(heading: 'Original Class Details', headingData: [
//       HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
//       HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
//       HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
//       HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
//       HeaderData(
//           icon: 'assets/icons/read_book_icon.png',
//           title: '5.000 KWD / Session'),
//     ]),
//     Header(heading: 'Proposal Details', headingData: [
//       HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
//       HeaderData(icon: 'assets/icons/date_icon.png', title: '12/12 12:30pm'),
//       HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
//       HeaderData(icon: 'assets/icons/timer_icon.png', title: '1h 30m'),
//       HeaderData(
//           icon: 'assets/icons/read_book_icon.png',
//           title: '5.000 KWD / Session'),
//     ]),
//   ];
//
//   @action
//   Future<void> fetchMap() async {
//     try {
//       kGooglePlex = CameraPosition(
//         target: LatLng(
//           double.parse('24.7136'),
//           double.parse('46.6753'),
//         ),
//         zoom: 14.4746,
//       );
//     } on SocketException catch (e) {
//       logs('Catch SocketException in getContactUsInfo --> ${e.message}');
//     }
//   }
//
//   @action
//   void getProfile() {
//     selectedProfile =
//         keyValueStorageBase.getCommon(String, KeyValueStorageService.profile) ??
//             ApplicationConstants.student;
//   }
// }
