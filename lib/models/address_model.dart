class AddressModel {
  String location;
  double latitude;
  double longitude;
  AddressModel({this.location, this.latitude, this.longitude});

  Map<String, dynamic> toJson() => {
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
      };
}
