import 'package:doctors_of_kenya/models/models.dart';

class QualificationsModel {
  List<String> undergraduateDegree;
  List<String> internshipCentre;
  List<String> postGraduateDegree;
  List<String> fellowship;
  List<String> specializations;
  List<String> shortCourses;
  List<String> specialInterests;
  List<InstitutionModel> affiliatedInstitutions;

  QualificationsModel({
    this.undergraduateDegree = const <String>[],
    this.internshipCentre = const <String>[],
    this.postGraduateDegree = const <String>[],
    this.fellowship = const <String>[],
    this.specializations = const <String>[],
    this.shortCourses = const <String>[],
    this.specialInterests = const <String>[],
    this.affiliatedInstitutions = const <InstitutionModel>[],
  });

  Map<String, dynamic> toJson() => {
        'undergraduateDegree': undergraduateDegree,
        'internshipCentre': internshipCentre,
        'postGraduateDegree': postGraduateDegree,
        'fellowship': fellowship,
        'specializations': specializations,
        'shortCourses': shortCourses,
        'specialInterests': specialInterests,
        'affiliatedInstitutions': affiliatedInstitutions,
      };
}
