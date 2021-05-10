import 'package:doctors_of_kenya/models/models.dart';

class FacilityModel {
  String name;
  String type;
  ContactModel contacts;
  LocationModel location;
  List<dynamic> paymentModalities;

  FacilityModel({
    this.name,
    this.contacts,
    this.location,
    this.paymentModalities,
    this.type,
  });
}
