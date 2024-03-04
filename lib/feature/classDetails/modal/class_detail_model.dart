import 'package:hessah/feature/classDetails/modal/proposal_model.dart';
import 'package:hessah/feature/classDetails/modal/rescheduleInfo_model.dart';
import 'package:hessah/feature/classDetails/modal/students_model.dart';

class ClassDetailsModel {
  ClassDetailsModel(
      {this.userName,
      this.displayId,
      this.classNumber,
      this.subject,
      this.school,
      this.curriculum,
      this.grade,
      this.description,
      this.sessions,
      this.minParticipants,
      this.maxParticipants,
      this.duration,
      this.classTime,
      this.cost,
      this.currency,
      this.status,
      this.address,
      this.location,
      this.allowAtStudentLoc,
      this.role,
      this.isOwner,
      this.myProposaldetails,
      this.canEditSubmittedProposal,
      this.canSubmitProposal,
      this.canCancelClass,
      this.canBookClass,
        this.rescheduleInfo,
      this.canRescheduleClass,
        this.canApproveTheReschedule,
        this.canRejectTheReschedule,
      this.canWithdrawProposal,
      this.canPay,
      this.proposalsCount,
      this.teacherDetails,
      this.proposals,
      this.canApproveCancel,
      this.canRejectCancel});

  ClassDetailsModel.fromJson(Map<String, dynamic> json) {
    userName = json['username'];
    displayId = json['displayId'];
    classNumber = json['classNumber'];
    subject = json['subject'];
    school = json['school'];
    curriculum = json['curriculum'];
    grade = json['grade'];
    description = json['description'];
    sessions = json['sessions'];
    minParticipants = json['minParticipants'];
    maxParticipants = json['maxParticipants'];
    duration = json['duration'];
    classTime = json['classTime'];
    cost = json['cost'];
    currency = json['currency'];
    status = json['status'];
    address = json['address'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    proposalsCount = json['proposalsCount'];
    allowAtStudentLoc = json['allow_at_student_loc'];
    role = json['role'];
    isOwner = json['isOwner'];
    myProposaldetails = json['myProposaldetails'] != null
        ? MyProposaldetails.fromJson(json['myProposaldetails'])
        : null;
    canEditSubmittedProposal = json['canEditSubmittedProposal'];
    canSubmitProposal = json['canSubmitProposal'];
    canCancelClass = json['canCancelClass'];
    canBookClass = json['canBookClass'];
    canCancelClass = json['canCancelClass'];
    canRescheduleClass=json['canRescheduleClass'];
    canApproveCancel = json['canApproveTheCancellation'];
    canRejectCancel = json['canRejectTheCancellation'];
    canWithdrawProposal = json['canWithdrawProposal'];
    canApproveTheReschedule=json['canApproveTheReschedule'];
    canRejectTheReschedule=json['canRejectTheReschedule'];
   if (json['rescheduleInfo'] != null) {
     rescheduleInfo = <RescheduleInfo>[];
      // ignore: avoid_dynamic_calls
      json['rescheduleInfo'].forEach((v) {
        rescheduleInfo!.add(RescheduleInfo.fromJson(v));
      });
    }
    if (json['scheduleInfo'] != null) {
      scheduleInfo = <RescheduleInfoModel>[];
      // ignore: avoid_dynamic_calls
      json['scheduleInfo'].forEach((v) {
        scheduleInfo!.add(RescheduleInfoModel.fromJson(v));
      });
    }
    canPay = json['canPay'];
    teacherDetails = json['teacherDetails'] != null
        ? TeacherDetails.fromJson(json['teacherDetails'])
        : null;
    studentDetails = json['studentDetails'] != null
        ? StudentDetails.fromJson(json['studentDetails'])
        : null;
    if (json['proposals'] != null) {
      proposals = <ProposalModel>[];
      // ignore: avoid_dynamic_calls
      json['proposals'].forEach((v) {
        proposals!.add(ProposalModel.fromJson(v));
      });
    }
    if (json['students'] != null) {
      students = <StudentsModel>[];
      // ignore: avoid_dynamic_calls
      json['students'].forEach((v) {
        students!.add(StudentsModel.fromJson(v));
      });
    }
  }
  String? userName;
  String? displayId;
  String? classNumber;
  String? subject;
  String? school;
  String? curriculum;
  String? grade;
  String? description;
  int? sessions;
  int? minParticipants;
  int? maxParticipants;
  int? duration;
  int? classTime;
  String? cost;
  String? currency;
  String? status;
  String? address;
  Location? location;
  int? allowAtStudentLoc;
  String? role;
  int? isOwner;
  int? proposalsCount;
  MyProposaldetails? myProposaldetails;
  bool? canEditSubmittedProposal;
  bool? canRescheduleClass;
  bool? canBookClass;
  bool? canSubmitProposal;
  bool? canCancelClass;
  bool? canApproveCancel;
  bool? canRejectCancel;
  bool? canWithdrawProposal;
  bool? canPay;
  bool? canApproveTheReschedule;
  bool? canRejectTheReschedule;
  TeacherDetails? teacherDetails;
  List<RescheduleInfo>? rescheduleInfo;
  List<RescheduleInfoModel>? scheduleInfo;
  StudentDetails? studentDetails;
  List<ProposalModel>? proposals;
  List<StudentsModel>? students;
}

class Location {
  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }
  String? lat;
  String? long;
}

class MyProposaldetails {
  MyProposaldetails(
      {this.pCost,
      this.pCurrency,
      this.pClassTime,
      this.pSessions,
      this.pDuration,
      this.id});

  MyProposaldetails.fromJson(Map<String, dynamic> json) {
    pCost = json['p_cost'];
    pCurrency = json['p_currency'];
    pClassTime = json['p_classTime'];
    pSessions = json['p_sessions'];
    pDuration = json['p_duration'];
    id = json['p_id'];
  }
  String? pCost;
  String? pCurrency;
  int? pClassTime;
  int? pSessions;
  int? pDuration;
  String? id;
}

class TeacherDetails {
  TeacherDetails(
      {this.userId,
      this.name,
      this.imageId,
      this.country,
      this.flagUrl,
      this.rating,
      //  this.subject,
      this.subscription});

  TeacherDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    imageId = json['imageId'];
    country = json['country'];
    flagUrl = json['flagUrl'];
    rating = json['rating'];
    // subject = json['subject'].cast<String>();
    subscription = json['subscription'];
  }
  int? userId;
  String? name;
  String? imageId;
  String? country;
  String? flagUrl;
  int? rating;
  String? subscription;
  // List<String>? subject;
}
class RescheduleInfo {
  RescheduleInfo(
      {this.classId,
        this.classScheduleId,
        this.startTime,
        this.endTime,
        this.userId,
        });

  RescheduleInfo.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    classScheduleId = json['class_schedule_id'];
    startTime = json['old_start_time'];
    endTime = json['start_time'];
    userId = json['user_id'];
  }
  String? classId;
  int? classScheduleId;
  int? startTime;
  int? endTime;
  int? userId;
}
class StudentDetails {
  StudentDetails(
      {this.userId,
      this.name,
      this.imageId,
      this.subject,
      this.school,
      this.curriculum,
      this.grade});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    imageId = json['imageId'];
    // ignore: avoid_dynamic_calls
    subject = json['subject'].cast<String>();
    // ignore: avoid_dynamic_calls
    school = json['school'].cast<String>();
    // ignore: avoid_dynamic_calls
    curriculum = json['curriculum'].cast<String>();
    // ignore: avoid_dynamic_calls
    grade = json['grade'].cast<String>();
  }
  int? userId;
  String? name;
  String? imageId;
  List<String>? subject;
  List<String>? school;
  List<String>? curriculum;
  List<String>? grade;
}
