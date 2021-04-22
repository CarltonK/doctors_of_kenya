import 'package:doctors_of_kenya/constants/constants.dart';
import 'package:doctors_of_kenya/helpers/helpers.dart';
import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: BackgroundPainter(),
            ),
            RegistrationBody(),
          ],
        ),
      ),
    );
  }
}

class RegistrationBody extends StatelessWidget {
  // Form
  final _registrationFormKey = GlobalKey<FormState>();

  // Focus Nodes
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  // Validation
  static ValidationHelper _validationHelper = ValidationHelper.empty();

  // Identifiers
  static String _email;
  static String _password;
  static String _confirmPassword;
  static UserModel _userModel;

  // ******Email Stuff*******
  Widget _emailField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusPassword);
        },
        validator: _validationHelper.validateEmailAddress,
        onSaved: saveEmail,
      ),
    );
  }

  void saveEmail(String value) {
    _email = value.trim();
    // print('Email -> $_email');
  }

  // ******Password Stuff*******
  Widget _passwordField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.vpn_key),
        ),
        focusNode: _focusPassword,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusConfirmPassword);
        },
        validator: _validationHelper.validatePassword,
        onSaved: savePassword,
      ),
    );
  }

  void savePassword(String value) {
    _password = value.trim();
    // print('Password -> $_password');
  }

  // ******Password Confirm Stuff*******
  Widget _passwordConfirmField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.vpn_key),
        ),
        focusNode: _focusConfirmPassword,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).unfocus();
          _registrationButtonPressed();
        },
        onSaved: saveConfirmPassword,
      ),
    );
  }

  void saveConfirmPassword(String value) {
    _confirmPassword = value.trim();
    // print('Password (2) -> $_confirmPassword');
  }

  _registrationButtonPressed() {
    final FormState form = _registrationFormKey.currentState;
    if (form.validate()) {
      form.save();

      // Create a user instance
      _userModel = UserModel(
        email: _email,
        password: _password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: layoutPadding(context),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 100),
              const SizedBox(height: 16),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Form(
                    key: _registrationFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Create an Account',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 16),
                        _emailField(context),
                        const SizedBox(height: 16),
                        _passwordField(context),
                        const SizedBox(height: 16),
                        _passwordConfirmField(context),
                        const SizedBox(height: 16),
                        GlobalActionButton(
                          action: 'Register',
                          onPressed: () => _registrationButtonPressed(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              NavigationHelper(
                leading: "Already have an account?",
                action: "Login",
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
