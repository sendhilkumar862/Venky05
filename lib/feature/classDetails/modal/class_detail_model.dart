

class ClassDetailsModel {

  ClassDetailsModel(
      {this.displayId,
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
      this.canRescheduleClass,
      this.canWithdrawProposal,
      this.proposalsCount});

  ClassDetailsModel.fromJson(Map<String, dynamic> json) {
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
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    proposalsCount= json['proposalsCount'];
    allowAtStudentLoc = json['allow_at_student_loc'];
    role = json['role'];
    isOwner = json['isOwner'];
    myProposaldetails = json['myProposaldetails'] != null
        ?  MyProposaldetails.fromJson(json['myProposaldetails'])
        : null;
    canEditSubmittedProposal = json['canEditSubmittedProposal'];
    canSubmitProposal = json['canSubmitProposal'];
    canCancelClass = json['canCancelClass'];
    canBookClass = json['canBookClass'];
    canCancelClass = json['canCancelClass'];
    canWithdrawProposal = json['canWithdrawProposal'];
  }
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
  bool? canWithdrawProposal;
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