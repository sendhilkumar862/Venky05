import 'package:get/get.dart';

import '../../core/api_end_points.dart';

extension StringLocalization on String {
  String get locale => this.tr;

  // xyz.getImageUrl('profile') =>  return url
  String getImageUrl(String type) {
    final String baseUrl = ApiEndpoint.downloader(DownloaderEndPoint.DOWNLOAD);
    final String imageUrl = '$baseUrl?type=$type&id=$this';

    return imageUrl;
  }

  //get the name of the User
  String extractInitials() {
    final List<String> names = split(' ');
    String initials = '';

    for (final String name in names) {
      if (name.isNotEmpty) {
        initials += name.substring(0, 1).toUpperCase();
        // if (initials.length < 2) {
        //   // If the length is still less than 2, consider the next character
        //   initials += name.length > 1 ? name.substring(1, 2).toUpperCase() : '';
        // }
        if (initials.length >= 2) {
          break; // Limit the result to a total of two characters
        }
      }
    }

    return initials;
  }
  int toEpoch(){
    List splitter=this.split(' ');
    List dataSplitter=splitter[0].split('-');
    // ignore: avoid_dynamic_calls
    String date=dataSplitter[2]+'-'+(dataSplitter[1].length==1?'0${dataSplitter[1]}':dataSplitter[1])+'-'+(dataSplitter[0].length==1?'0${dataSplitter[0]}':dataSplitter[0]);
    String time= time12to24Format('${splitter[1]} ${splitter[2]}');
    final DateTime datetime= DateTime.parse('$date $time:00');
    return datetime.millisecondsSinceEpoch;
  }
  String time12to24Format(String time) {
// var time = "12:01 AM";
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String meridium = time.split(":").last.split(" ").last.toLowerCase();
    if (meridium == "pm") {
      if (h != 12) {
        h = h + 12;
      }
    }
    if (meridium == "am") {
      if (h == 12) {
        h = 00;
      }
    }
    String newTime = "${h == 0 ? "00" :(h.toString().length==1?'0$h':h)}:${m == 0 ? "00" : (m.toString().length==1?'0$m':m)}";
    return newTime;
  }
}
