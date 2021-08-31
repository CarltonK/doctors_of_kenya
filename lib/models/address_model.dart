class AddressModel {
  String? location;
  double? latitude;
  double? longitude;
  String? poBox;
  AddressModel({this.location, this.latitude, this.longitude, this.poBox});

  Map<String, dynamic> toJson() => {
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'poBox': poBox,
      };
}
