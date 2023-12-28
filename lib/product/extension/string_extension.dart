

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

  //get the name of the User
String extractInitials(String input) {
  final List<String> names = input.split(' ');
  String initials = '';

  for (final String name in names) {
    if (name.isNotEmpty) {
      initials += name.substring(0, 1).toUpperCase();
      if (initials.length < 2) {
        // If the length is still less than 2, consider the next character
        initials += name.length > 1 ? name.substring(1, 2).toUpperCase() : '';
      }
      if (initials.length >= 2) {
        break; // Limit the result to a total of two characters
      }
    }
  }

  return initials;
}
}
