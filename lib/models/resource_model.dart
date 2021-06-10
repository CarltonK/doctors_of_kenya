import 'package:cloud_firestore/cloud_firestore.dart';

class ResourceModel {
  String? resourceType;

  ResourceModel({
    this.resourceType,
  });

  factory ResourceModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return ResourceModel(
      resourceType: data['resourceType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'resourceType': resourceType,
      };
}
