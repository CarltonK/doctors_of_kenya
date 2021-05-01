import 'package:doctors_of_kenya/models/models.dart';

class UserModel {
  String email;
  String password;
  String uid;
  String age;
  String sex;
  String firstName;
  String lastName;
  String designation;

  // Optional
  String token;

  // Optional for non-practitioner
  List<String> chronicConditions;
  List<String> medications;
  String primaryDoctor;
  List<String> otherDoctors;

  // Medical Practitioners
  String mpdbRegNumber;
  DateTime mpdbRegDate;
  AddressModel userAddress;
  ContactModel userContact;
  QualificationsModel professionalQualifications;

  UserModel({
    this.email,
    this.password,
    this.uid,
    this.age,
    this.sex,
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
    this.professionalQualifications,
    this.token,
  });

  Map<String, dynamic> toMainFirestoreDoc() => {
        'email': email,
        'uid': uid,
        'age': age,
        'sex': sex,
        'firstName': firstName,
        'lastName': lastName,
        'designation': designation,
        'chronicConditions': chronicConditions,
        'medications': medications,
        'primaryDoctor': primaryDoctor,
        'otherDoctors': otherDoctors,
        'mpdbRegNumber': mpdbRegNumber,
        'mpdbRegDate': mpdbRegDate,
        'userAddress': userAddress.toJson(),
        'userContact': userContact.toJson(),
        'professionalQualifications': professionalQualifications.toJson(),
      };
}
