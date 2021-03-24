import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    print('Firestore has been initialized.');
  }

  Future saveUser(UserModel user, String uid) async {
    user.uid = uid;
    // Main Doc
    DocumentReference mainDocRef = _db.collection("users").doc(uid);

    // Save the email to the main document
    await mainDocRef.set(user.toMainFirestoreDoc());
    // Create a public document
  }
}
