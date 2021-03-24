import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth;
  User currentUser;
  Status _status = Status.Uninitialized;

  Status get status => _status;
  User get user => currentUser;

  DatabaseProvider database = DatabaseProvider();

  AuthProvider.instance() : auth = FirebaseAuth.instance {
    auth.authStateChanges().listen(_onAuthStateChanged);
  }

  /*
  AUTH LISTENER
  */
  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      currentUser = firebaseUser;
      _status = Status.Authenticated;
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
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      currentUser = result.user;

      return Future.value(currentUser);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
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
        email: user.email,
        password: user.password,
      );
      currentUser = result.user;
      String uid = currentUser.uid;

      // Send an email verification
      currentUser.sendEmailVerification();
      // Save the user to the database
      await database.saveUser(user, uid);

      return Future.value(currentUser);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      var response;
      if (e.toString().contains("ERROR_WEAK_PASSWORD")) {
        response = 'Your password is weak. Please choose another.';
      }
      if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        response = 'The email format entered is invalid.';
      }
      if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")) {
        response = 'An account with the same email exists.';
      }
      return response;
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
        email: user.email,
        password: user.password,
      );
      currentUser = result.user;

      return Future.value(currentUser);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      var response;
      if (e.toString().contains("ERROR_WRONG_PASSWORD")) {
        response = 'Invalid credentials. Please try again.';
      }
      if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        response = 'The email format entered is invalid.';
      }
      if (e.toString().contains("ERROR_USER_NOT_FOUND")) {
        response = 'Please register first.';
      }
      if (e.toString().contains("ERROR_USER_DISABLED")) {
        response = 'Your account has been disabled.';
      }
      if (e.toString().contains("ERROR_TOO_MANY_REQUESTS")) {
        response = 'Too many requests. Please try again in 2 minutes.';
      }
      return response;
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
