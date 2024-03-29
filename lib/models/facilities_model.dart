import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class FacilityModel {
  String? docId;
  String? name;
  String? facilityType;
  ContactModel? contacts;
  LocationModel? location;
  List<dynamic> paymentModalities;
  bool isVerified;

  FacilityModel({
    this.name,
    this.contacts,
    this.location,
    this.paymentModalities = const <String>[],
    this.facilityType,
    this.docId,
    this.isVerified = false,
  });

  factory FacilityModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();

    return FacilityModel(
      name: data['name'] ?? '',
      facilityType: data['facilityType'] ?? 'public',
      contacts: ContactModel.fromMap(data['contacts']),
      location: LocationModel.fromMap(data['location']),
      paymentModalities: data['paymentModalities'] ?? [],
      docId: doc.id,
      isVerified: data['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'facilityType': facilityType,
        'paymentModalities': paymentModalities,
        'contacts': contacts != null ? contacts!.toJson() : null,
        'location': location != null ? location!.toJson() : null,
        'isVerified': isVerified
      };
}
