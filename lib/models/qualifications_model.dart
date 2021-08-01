import 'package:doctors_of_kenya/models/models.dart';

class QualificationsModel {
  List<String> qualifications;
  String? qualificationYear;
  List<FacilityModel> affiliatedInstitutions;

  QualificationsModel({
    this.qualifications = const <String>[],
    this.qualificationYear,
    this.affiliatedInstitutions = const <FacilityModel>[],
  });

  Map<String, dynamic> toJson() => {
        'undergraduateDegree': qualifications,
        'affiliatedInstitutions': affiliatedInstitutions,
      };
}
