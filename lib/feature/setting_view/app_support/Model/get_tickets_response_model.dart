class GetTicketsResponseModel {

  GetTicketsResponseModel(
      {this.ticketId,
        this.title,
        this.description,
        this.status,
        this.statusCode,
        this.createdAt,
        this.updatedAt,
        this.attachments});

  GetTicketsResponseModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    statusCode = json['status_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      // ignore: avoid_dynamic_calls
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
  }
  int? ticketId;
  String? title;
  String? description;
  String? status;
  String? statusCode;
  int? createdAt;
  int? updatedAt;
  List<Attachments>? attachments;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['status_code'] = statusCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {

  Attachments({this.attachmentId});

  Attachments.fromJson(Map<String, dynamic> json) {
    attachmentId = json['attachment_id'];
  }
  String? attachmentId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attachment_id'] = attachmentId;
    return data;
  }
}
