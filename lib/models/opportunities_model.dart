import 'package:cloud_firestore/cloud_firestore.dart';

class OpportunityModel {
  String? employmentType;

  OpportunityModel({
    this.employmentType,
  });

  factory OpportunityModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return OpportunityModel(
      employmentType: data['employmentType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'employmentType': employmentType,
      };
}
