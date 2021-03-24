import 'package:doctors_of_kenya/models/models.dart';

class ContactModel {
  String personalNumber;
  String officeNumber;
  String email;
  SocialMediaModel socialMediaModel;
  String emergency;
  List<String> otherNumbers;

  ContactModel({
    this.personalNumber,
    this.officeNumber,
    this.email,
    this.socialMediaModel,
    this.emergency,
    this.otherNumbers = const <String>[],
  });
}
