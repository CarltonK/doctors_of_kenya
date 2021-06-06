import 'package:cloud_firestore/cloud_firestore.dart';

class FacilityServiceModel {
  String? facilityName;
  String? facilityReference;
  List<dynamic>? services;
  List<dynamic>? facilityPaymentModalities;

  FacilityServiceModel({
    this.facilityName,
    this.facilityReference,
    this.services,
    this.facilityPaymentModalities,
  });

  factory FacilityServiceModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return FacilityServiceModel(
      facilityName: data['facilityName'] ?? '',
      facilityReference: data['facilityReference'],
      services: data['services'] ?? [],
      facilityPaymentModalities: data['facilityPaymentModalities'] ?? [],
    );
  }
}
