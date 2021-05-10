import 'package:flutter/foundation.dart';

class LocationModel {
  double latitude;
  double longitude;
  String county;
  String town;

  LocationModel({
    this.latitude,
    this.longitude,
    this.county,
    this.town,
  });

  factory LocationModel.fromMap(Map<String, dynamic> data) {
    return LocationModel(
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
      county: data['county'] ?? '',
      town: data['town'] ?? '',
    );
  }
}
