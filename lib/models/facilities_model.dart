import 'package:cloud_firestore/cloud_firestore.dart';
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
    this.paymentModalities = const <String>[],
    this.type,
  });

  factory FacilityModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return FacilityModel(
      name: data['name'] ?? '',
      type: data['type'] ?? 'public',
      contacts: ContactModel.fromMap(data['contacts']) ?? null,
      location: LocationModel.fromMap(data['location']) ?? null,
      paymentModalities: data['paymentModalities'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'paymentModalities': paymentModalities,
        'contacts': contacts != null ? contacts.toJson() : null,
        'location': location != null ? location.toJson() : null,
      };
}
