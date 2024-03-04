class RescheduleInfoModel {

  RescheduleInfoModel({this.classScheduleId, this.startTime, this.session});

  RescheduleInfoModel.fromJson(Map<String, dynamic> json) {
    classScheduleId = json['classScheduleId'];
    startTime = json['startTime'];
    session = json['session'];
  }
  int? classScheduleId;
  int? startTime;
  int? session;

}