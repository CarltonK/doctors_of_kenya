import 'package:doctors_of_kenya/models/models.dart';

class ContactModel {
  String? personalNumber;
  String? officeNumber;
  String? email;
  // SocialMediaModel? socialMediaModel = SocialMediaModel(
  //     twitterHandle: null, facebookHandle: null, youtubeHandle: null);
  String? emergency;
  List<dynamic> otherNumbers;

  ContactModel({
    this.personalNumber,
    this.officeNumber,
    this.email,
    // this.socialMediaModel,
    this.emergency,
    this.otherNumbers = const <String>[],
  });

  Map<String, dynamic> toJson() => {
        'personalNumber': personalNumber,
        'officeNumber': officeNumber,
        'email': email,
        // 'socialMediaModel':
        //     socialMediaModel != null ? socialMediaModel!.toJson() : null,
        'emergency': emergency,
        'otherNumbers': otherNumbers,
      };

  factory ContactModel.fromMap(Map<String, dynamic> data) {
    return ContactModel(
      personalNumber: data['personalNumber'] ?? '',
      officeNumber: data['officeNumber'] ?? '',
      email: data['email'] ?? '',
      emergency: data['emergency'] ?? '',
      otherNumbers: data['otherNumbers'] ?? [],
      //socialMediaModel: SocialMediaModel.fromMap(data['socialMediaModel']),
    );
  }
}
