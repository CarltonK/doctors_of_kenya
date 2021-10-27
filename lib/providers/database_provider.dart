// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_of_kenya/models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseProvider() {
    // Comment this line for production
    // bool isAndroid = Platform.isAndroid;
    // String host = isAndroid ? '10.0.2.2:5002' : 'localhost:5002';
    // _db.settings = Settings(host: host, sslEnabled: false);
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

  //Add Facility
  Future addFacility(FacilityModel facility) async {
    try {
      DocumentReference facilityDocRef = _db.collection("facilities").doc();
      await facilityDocRef.set(facility.toJson());
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future retrievePublicUserDocument(String uid) async {
    try {
      DocumentReference userDoc = _db.doc('users/$uid/public_profile/$uid');
      DocumentSnapshot publicSnapshot = await userDoc.get();
      return UserModel.fromPublicDocument(publicSnapshot);
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future retrieveSignInUsersDocument(String uid) async {
    try {
      DocumentReference userDoc = _db.doc('users/$uid/private_profile/$uid');
      DocumentSnapshot publicSnapshot = await userDoc.get();
      return UserModel.fromPrivateDocument(publicSnapshot);
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Populate (Practitioners / Home) Page
  ///
  /// Retrieve practitioners by type
  Future retrievePractitioners(String type) async {
    QuerySnapshot querySnapshot;
    try {
      Query colGroupRef = _db.collectionGroup('public_profile');
      Query baseQuery =
          colGroupRef.where('designation', isEqualTo: 'Practitioner');
      Query secondaryQuery =
          baseQuery.where('practitionerType', isEqualTo: type);
      Query tripleQuery = secondaryQuery.where('isVerified', isEqualTo: true);
      querySnapshot = await tripleQuery.get();
      return querySnapshot.docs
          .map((document) => UserModel.fromPublicDocument(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future retrieveAllPractitioners() async {
    QuerySnapshot querySnapshot;
    try {
      Query colGroupRef = _db.collectionGroup('public_profile');
      Query baseQuery =
          colGroupRef.where('designation', isEqualTo: 'Practitioner');
      Query secondaryQuery = baseQuery.where('isVerified', isEqualTo: false);
      querySnapshot = await secondaryQuery.get();
      return querySnapshot.docs
          .map((document) => UserModel.fromPublicDocument(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  ///Populate Concierge Page
  Future retrieveConcierge(String type) async {
    QuerySnapshot querySnapshot;
    try {
      Query colGroupRef = _db.collectionGroup('public_profile');
      Query baseQuery = colGroupRef.where('designation', isEqualTo: 'Liason');
      Query secondaryQuery =
          baseQuery.where('practitionerType', isEqualTo: type);
      querySnapshot = await secondaryQuery.get();
      return querySnapshot.docs
          .map((document) => UserModel.fromPublicDocument(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Populate Services Page
  Future retrieveServices(String service) async {
    QuerySnapshot querySnapshot;
    try {
      CollectionReference colRef = _db.collection('facility_service');
      Query baseQuery = colRef.where('services', arrayContains: service);
      querySnapshot = await baseQuery.get();
      return querySnapshot.docs
          .map((document) => FacilityServiceModel.fromFirestore(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Populate Facilities Page
  Future retrieveFacilities(String type) async {
    QuerySnapshot querySnapshot;
    try {
      CollectionReference colRef = _db.collection('facilities');
      Query baseQuery = colRef.where('facilityType', isEqualTo: type);
      querySnapshot = await baseQuery.get();
      return querySnapshot.docs
          .map((document) => FacilityModel.fromFirestore(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }
  //Admin retrieve facilities

  Future adminRetrieveFacilities() async {
    QuerySnapshot querySnapshot;
    try {
      CollectionReference colRef = _db.collection('facilities');
      Query baseQuery = colRef.where('isVerified', isEqualTo: false);
      querySnapshot = await baseQuery.get();
      return querySnapshot.docs
          .map((document) => FacilityModel.fromFirestore(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Populate Store Page
  Future retrieveStore(String itemType) async {
    QuerySnapshot querySnapshot;
    try {
      CollectionReference colRef = _db.collection('store');
      Query baseQuery = colRef.where('itemType', isEqualTo: itemType);
      querySnapshot = await baseQuery.get();
      return querySnapshot.docs
          .map((document) => StoreModel.fromFirestore(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Populate Resources
  Future retrieveResources(String itemType) async {
    QuerySnapshot querySnapshot;
    try {
      CollectionReference colRef = _db.collection('resources');
      Query baseQuery = colRef.where('resourceType', isEqualTo: itemType);
      querySnapshot = await baseQuery.get();
      return querySnapshot.docs
          .map((document) => ResourceModel.fromFirestore(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  ///Populate Opportunities
  Future retrieveOpportunities(String itemType) async {
    QuerySnapshot querySnapshot;
    try {
      CollectionReference colRef = _db.collection('opportunities');
      Query baseQuery = colRef.where('employmentType', isEqualTo: itemType);
      querySnapshot = await baseQuery.get();
      return querySnapshot.docs
          .map((document) => OpportunityModel.fromFirestore(document))
          .toList();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Admin Accept Practitioner
  Future adminAcceptPractitioner(String uid) async {
    try {
      CollectionReference colRef = _db.collection('users');
      await colRef
          .doc(uid)
          .collection('public_profile')
          .doc(uid)
          .update({'isVerified': true});
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  ///Admin Reject Practitioner
  Future adminRejectPractitioner(String uid) async {
    try {
      CollectionReference colRef = _db.collection('users');
      await colRef.doc(uid).collection('public_profile').doc(uid).delete();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Admin Accept Facility
  Future adminAcceptFacility(String docId) async {
    try {
      CollectionReference colRef = _db.collection('facilities');
      await colRef.doc(docId).update({'isVerified': true});
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  /// Admin Reject Facility
  Future adminRejectFacility(String docId) async {
    try {
      CollectionReference colRef = _db.collection('facilities');
      await colRef.doc(docId).delete();
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  //Admin or normal user

  Future<bool> checkAdmin(String email) async {
    try {
      CollectionReference colRef = _db.collection('admins');
      QuerySnapshot snapshot =
          await colRef.where('email', isEqualTo: email).get();
      if (snapshot.docs.isEmpty) {
        return false;
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
