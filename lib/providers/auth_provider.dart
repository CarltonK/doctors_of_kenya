import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider extends DatabaseProvider with ChangeNotifier {
  final FirebaseAuth auth;
  User? currentUser;
  Status _status = Status.Uninitialized;

  Status get status => _status;
  User get user => currentUser!;

  UserModel? currentDokUser;
  UserModel get dokuser => currentDokUser!;

  AuthProvider.instance() : auth = FirebaseAuth.instance {
    // Comment this line for production
    auth.useEmulator("http://localhost:9099");
    auth.authStateChanges().listen(_onAuthStateChanged);
  }

  /*
  AUTH LISTENER
  */
  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      currentUser = firebaseUser;
      _status = Status.Authenticated;
      // Get User Document if user has document
      if (!firebaseUser.isAnonymous) {
        dynamic docResult = await retrieveSignInUsersDocument(currentUser!.uid);
        if (docResult.runtimeType == UserModel) {
          currentDokUser = docResult;
        }
        bool isAdmin = await checkAdmin(firebaseUser.email!);
        currentDokUser!.isAdmin = isAdmin;
      }
    }
    notifyListeners();
  }

  /*
  ANONYMOUS LOGIN
  */
  Future anonymousSignIn() async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await auth.signInAnonymously();
      currentUser = result.user;

      return Future.value(currentUser);
    } on FirebaseAuthException catch (error) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return error.message;
    }
  }

  /*
  USER REGISTRATION
  */
  Future createUser(UserModel user) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      currentUser = result.user;
      String uid = currentUser!.uid;

      // Send an email verification
      await currentUser!.sendEmailVerification();
      // Save the user to the database
      await saveUser(user, uid);

      return Future.value(currentUser);
    } on FirebaseAuthException catch (error) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return error.message;
    }
  }

  /*
  USER LOGIN
  */
  Future signInEmailPass(UserModel user) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      currentUser = result.user;

      return Future.value(currentUser);
    } on FirebaseAuthException catch (error) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return error.message;
    }
  }

  /*
  USER PASSWORD RESET
  */
  Future resetPassword(String email) async {
    try {
      // Check if email exists
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        // Send password reset email
        await auth.sendPasswordResetEmail(email: email);
        return Future.value(null);
      } else {
        return 'The user could not be found';
      }
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  /*
  USER LOGOUT
  */
  Future<void> signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
