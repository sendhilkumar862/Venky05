class UserAddress {
  UserAddress(
      {this.id,
        this.shortName,
        this.countryCode,
        this.mobile,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.location,
        this.isDefault,
        this.userId,
        this.createdAt,
        this.updatedAt});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortName = json['short_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    isDefault = json['is_default'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? shortName;
  String? countryCode;
  String? mobile;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  Location? location;
  int? isDefault;
  int? userId;
  int? createdAt;
  int? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['short_name'] = shortName;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['is_default'] = isDefault;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Location {

  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }
  String? lat;
  String? long;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}