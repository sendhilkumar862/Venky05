class RescheduleInfoModel {

  RescheduleInfoModel({this.classScheduleId, this.startTime});

  RescheduleInfoModel.fromJson(Map<String, dynamic> json) {
    classScheduleId = json['classScheduleId'];
    startTime = json['startTime'];
  }
  int? classScheduleId;
  int? startTime;

}