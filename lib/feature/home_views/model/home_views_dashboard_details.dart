import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home_views_dashboard_details.g.dart';

@freezed
class Data {
  Item? item;

  Data({this.item});

  Data.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? Item?.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['item'] = item!.toJson();
    return data;
  }
}

class Item {
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? mobile;
  String? country;
  String? userStatus;

  Item({this.firstName, this.lastName, this.email, this.countryCode, this.mobile, this.country, this.userStatus});

  Item.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    country = json['country'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['mobile'] = mobile;
    data['country'] = country;
    data['userStatus'] = userStatus;
    return data;
  }
}

@JsonSerializable()
class DashBoardDetailsModel {
  Data? data;
  Status? status;

  DashBoardDetailsModel({this.data, this.status});

  DashBoardDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
    status = json['status'] != null ? Status?.fromJson(json['status']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['data'] = data!.toJson();
  //   data['status'] = status!.toJson();
  //   return data;
  // }
}

class Status {
  String? type;
  String? message;

  Status({this.type, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['message'] = message;
    return data;
  }
}

