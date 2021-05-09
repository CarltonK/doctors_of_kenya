import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String facilityName;
  String facilityReference;
  List<String> services;
  List<String> facilityPaymentModalities;

  ServiceModel({
    this.facilityName,
    this.facilityReference,
    this.services,
    this.facilityPaymentModalities,
  });

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return ServiceModel(
      facilityName: data['facilityName'] ?? '',
      facilityReference: data['facilityReference'],
      services: data['services'] ?? [],
      facilityPaymentModalities: data['facilityPaymentModalities'] ?? [],
    );
  }
}
