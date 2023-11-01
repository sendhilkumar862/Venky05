import 'package:flutter/material.dart';

import '../../product/constants/image/image_constants.dart';
import '../image/app_image_assets.dart';
import '../text/app_text.dart';

class StudentCardView extends StatelessWidget {
  const StudentCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        AppImageAsset(
          image: ImageConstants.avtar,
          height: 48,
        ),
        SizedBox(
          height: 6,
        ),
        AppText(
          'User Name',
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ],
    );;
  }
}
