
class AddressRequestModel {

  AddressRequestModel(
      {this.shortName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.location,
        this.isDefault});

  AddressRequestModel.fromJson(Map<String, dynamic> json) {
    shortName = json['short_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    isDefault = json['is_default'];
  }
  String? shortName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  Location? location;
  bool? isDefault;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['short_name'] = shortName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['is_default'] = isDefault;
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