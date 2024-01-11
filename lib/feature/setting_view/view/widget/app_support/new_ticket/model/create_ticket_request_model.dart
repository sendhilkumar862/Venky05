import 'dart:io';

class CreateTicketRequestModel {
  CreateTicketRequestModel({this.ticketType, this.description,this.attachments});

  CreateTicketRequestModel.fromJson(Map<String, dynamic> json) {
    ticketType = json['ticketType'];
    description = json['description'];
    attachments= json['attachments'];
  }
  String? ticketType;
  String? description;
  List<File>? attachments;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketType'] = ticketType;
    data['description'] = description;
    data['attachments'] = attachments;
    return data;
  }
}