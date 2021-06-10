import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';

class FacilityModel {
  String? name;
  String? facilityType;
  ContactModel? contacts;
  LocationModel? location;
  List<dynamic> paymentModalities;

  FacilityModel({
    this.name,
    this.contacts,
    this.location,
    this.paymentModalities = const <String>[],
    this.facilityType,
  });

  factory FacilityModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return FacilityModel(
      name: data['name'] ?? '',
      facilityType: data['facilityType'] ?? 'public',
      contacts: ContactModel.fromMap(data['contacts']),
      location: LocationModel.fromMap(data['location']),
      paymentModalities: data['paymentModalities'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'facilityType': facilityType,
        'paymentModalities': paymentModalities,
        'contacts': contacts != null ? contacts!.toJson() : null,
        'location': location != null ? location!.toJson() : null,
      };
}
