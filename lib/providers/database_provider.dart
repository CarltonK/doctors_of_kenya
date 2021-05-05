// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    // Comment this line for production
    // String host = Platform.isAndroid ? '192.168.2.111:8080' : 'localhost:8080';
    // _db.settings = Settings(
    //   host: host,
    //   sslEnabled: false,
    // );
  }

  Future saveUser(UserModel user, String uid) async {
    try {
      user.uid = uid;
      // Main Doc
      DocumentReference mainDocRef = _db.collection("users").doc(uid);
      // Save data
      await mainDocRef.set(user.toMainFirestoreDoc());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future retrievePublicDocument(String uid) async {
    try {
      DocumentReference userDoc = _db.doc('users/$uid/public_profile/$uid');
      DocumentSnapshot publicSnapshot = await userDoc.get();
      return UserModel.fromPublicDocument(publicSnapshot);
    } on FirebaseException catch (error) {
      return error.message;
    }
  }
}
