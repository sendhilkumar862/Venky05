import 'package:flutter_easyloading/flutter_easyloading.dart';


showLoading() {
  EasyLoading.show(
    status: "Loading...",
  );
}

// Center(
//       child: Lottie.asset(
//         ImageConstants.loader, // Path to your Lottie JSON file
//       ),
//     )

hideLoading() {
  EasyLoading.dismiss(animation: true);
}
