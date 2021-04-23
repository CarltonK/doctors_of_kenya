import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider.empty();

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
}
