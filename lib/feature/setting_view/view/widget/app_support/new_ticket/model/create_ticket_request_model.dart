class CreateTicketRequestModel {
  CreateTicketRequestModel({this.ticketType, this.description});

  CreateTicketRequestModel.fromJson(Map<String, dynamic> json) {
    ticketType = json['ticketType'];
    description = json['description'];
  }
  String? ticketType;
  String? description;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketType'] = ticketType;
    data['description'] = description;
    return data;
  }
}