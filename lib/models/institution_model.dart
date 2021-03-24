import 'package:doctors_of_kenya/models/models.dart';

class InstitutionModel {
  String name;
  String type;
  ContactModel contacts;
  LocationModel location;
  List<String> services;
  List<String> practitioners;
  List<String> paymentModalities;

  InstitutionModel({
    this.name,
    this.contacts,
    this.location,
    this.services,
    this.practitioners,
    this.paymentModalities,
    this.type,
  });
}
