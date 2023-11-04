// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImageAsset extends StatelessWidget {

  const AppImageAsset({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  });
  final String image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return ((image.isEmpty) || (image.contains('http')))
        ? CachedNetworkImage(
            imageUrl: image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            placeholder: (BuildContext context, String url) => const CircularProgressIndicator(color: Colors.red),
            errorWidget: (BuildContext context, String url, Object error) => const Icon(Icons.error, color: Colors.red),
          )
        : image.contains('json')
            ? Lottie.asset(image, height: height, width: width, fit: fit)
            : isFile
                ? Image.file(File(image), height: height, width: width, color: color, fit: fit)
                : image.split('.').last != 'svg'
                    ? Image.asset(image, fit: fit, height: height, width: width, color: color)
                    : SvgPicture.asset(image, height: height, width: width, color: color);
  }
}
