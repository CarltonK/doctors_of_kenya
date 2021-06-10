import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? itemType;

  StoreModel({
    this.itemType,
  });

  factory StoreModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return StoreModel(
      itemType: data['itemType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'itemType': itemType,
      };
}
