import 'dart:io';

class ReplyTicketRequestModel {
  ReplyTicketRequestModel({ this.description,this.attachments});

  ReplyTicketRequestModel.fromJson(Map<String, dynamic> json) {
    description = json['message'];
    attachments= json['attachments'];
  }
  String? description;
  List<File>? attachments;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = description;
    data['attachments'] = attachments;
    return data;
  }
}