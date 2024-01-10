class GetTicketsResponseModel {
  int? ticketId;
  String? title;
  String? description;
  String? status;
  String? statusCode;
  int? createdAt;
  int? updatedAt;
  List<String>? attachments;

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
    attachments = json['attachments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attachments'] = this.attachments;
    return data;
  }
}