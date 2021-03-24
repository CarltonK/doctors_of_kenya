import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    print('Firestore has been initialized.');
  }

  Future saveUser(UserModel user, String uid) async {
    // Associate uid to crashlytics
    FirebaseCrashlytics.instance.setUserIdentifier(uid);

    user.uid = uid;

    // Main Doc
    DocumentReference mainDocRef = _db.collection("users").doc(uid);

    // Save the email to the main document
    await mainDocRef.set(user.toMainFirestoreDoc());
    // Create a public document
  }
}
