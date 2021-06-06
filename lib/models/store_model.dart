import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? type;

  StoreModel({
    this.type,
  });

  factory StoreModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return StoreModel(
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
      };
}
