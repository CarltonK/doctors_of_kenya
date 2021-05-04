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
        'mpdbRegDate': mpdbRegDate,
        'userAddress': userAddress != null ? userAddress.toJson() : null,
        'userContact': userContact != null ? userContact.toJson() : null,
        'qualifications':
            qualifications != null ? qualifications.toJson() : null,
        'registeredOn': registeredOn,
      };
}
