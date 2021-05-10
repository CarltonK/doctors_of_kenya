import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';

class UserModel {
  String email;
  String password;
  String uid;
  DateTime dob;
  String gender;
  String firstName;
  String lastName;
  String designation;
  String profilePicture;
  DateTime registeredOn;

  // Optional
  String token;

  // Optional for non-practitioner
  List<String> chronicConditions;
  List<String> medications;
  String primaryDoctor;
  List<String> otherDoctors;

  // Required for Medical Practitioners
  String mpdbRegNumber;
  String practitionerType;
  String practitionerSpeciality;
  DateTime mpdbRegDate;
  AddressModel userAddress;
  ContactModel userContact;
  QualificationsModel qualifications;

  UserModel({
    this.email,
    this.password,
    this.uid,
    this.dob,
    this.gender,
    this.firstName,
    this.lastName,
    this.practitionerType = 'unspecified',
    this.practitionerSpeciality,
    this.profilePicture,
    this.designation = 'General',
    this.chronicConditions = const <String>[],
    this.medications = const <String>[],
    this.primaryDoctor,
    this.otherDoctors = const <String>[],
    this.mpdbRegNumber,
    this.mpdbRegDate,
    this.userAddress,
    this.userContact,
    this.qualifications,
    this.token,
    this.registeredOn,
  });

  factory UserModel.fromPublicDocument(DocumentSnapshot doc) {
    Map data = doc.data();
    return UserModel(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      profilePicture: data['profilePicture'] ?? null,
      email: data['email'] ?? null,
      registeredOn: DateTime.fromMillisecondsSinceEpoch(
          data['registeredOn'].millisecondsSinceEpoch),
      designation: data['designation'] ?? null,
      practitionerType: data['practitionerType'] ?? null,
      practitionerSpeciality: data['practitionerSpeciality'] ?? null,
      uid: doc.id,
    );
  }

  Map<String, dynamic> toMainFirestoreDoc() => {
        'email': email,
        'uid': uid,
        'dob': dob,
        'gender': gender,
        'firstName': firstName,
        'lastName': lastName,
        'designation': designation,
        'chronicConditions': chronicConditions,
        'medications': medications,
        'primaryDoctor': primaryDoctor,
        'otherDoctors': otherDoctors,
        'mpdbRegNumber': mpdbRegNumber,
        'practitionerType': practitionerType,
        'practitionerSpeciality': practitionerSpeciality,
        'profilePicture': profilePicture,
        'mpdbRegDate': mpdbRegDate,
        'userAddress': userAddress != null ? userAddress.toJson() : null,
        'userContact': userContact != null ? userContact.toJson() : null,
        'qualifications':
            qualifications != null ? qualifications.toJson() : null,
        'registeredOn': registeredOn,
      };
}
