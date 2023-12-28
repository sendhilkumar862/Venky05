

import 'package:get/get.dart';

import '../../core/api_end_points.dart';

extension StringLocalization on String {
  String get locale => this.tr;

  // xyz.getImageUrl('profile') =>  return url
  String getImageUrl(String type) {
    final String baseUrl = ApiEndpoint.downloader(DownloaderEndPoint.DOWNLOAD);
    final String imageUrl = '$baseUrl?type=$type&id=$this';
    return  imageUrl;
  }
}
