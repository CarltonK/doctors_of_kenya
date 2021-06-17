import 'dart:async';
import 'package:doctors_of_kenya/helpers/helpers.dart';
import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/screens/screens.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: BackgroundPainter(),
            ),
            LoginBody(),
          ],
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  // Form
  final _loginFormKey = GlobalKey<FormState>();

  // Focus Nodes
  final _focusPassword = FocusNode();

  // Validation
  static ValidationHelper _validationHelper = ValidationHelper.empty();

  // Identifiers
  static String? _email;
  static String? _password;
  static UserModel? _userModel;
  static dynamic _loginResult;

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

  void saveEmail(String? value) {
    _email = value!.trim();
    // print('Email -> $_email');
  }

  // ******Password Stuff*******
  Widget _passwordField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.vpn_key),
        ),
        focusNode: _focusPassword,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).unfocus();
          _loginButtonPressed(context);
        },
        validator: _validationHelper.validatePassword,
        onSaved: savePassword,
      ),
    );
  }

  void savePassword(String? value) {
    _password = value!.trim();
    // print('Password -> $_password');
  }

  Future<bool> _loginHandler(BuildContext context, UserModel user) async {
    _loginResult = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signInEmailPass(user);

    if (_loginResult.runtimeType == String) {
      return false;
    }
    return true;
  }

  Future<bool> _anonLoginHandler(BuildContext context) async {
    _loginResult = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).anonymousSignIn();

    if (_loginResult.runtimeType == String) {
      return false;
    }
    return true;
  }

  _loginButtonPressed(BuildContext context) {
    final FormState form = _loginFormKey.currentState!;
    if (form.validate()) {
      form.save();

      // Create a user instance
      _userModel = UserModel(
        email: _email,
        password: _password,
      );

      _loginHandler(context, _userModel!).then((value) {
        if (!value) {
          Timer(Duration(milliseconds: 500), () async {
            await showInfoDialog(
              _scaffoldKey.currentContext!,
              _loginResult,
            );
          });
        }
      }).catchError((error) {
        Timer(Duration(milliseconds: 500), () async {
          await showInfoDialog(
            _scaffoldKey.currentContext!,
            error.toString(),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: layoutPadding(context),
        // const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
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
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hello',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Sign in to your Account',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 16),
                        _emailField(context),
                        const SizedBox(height: 16),
                        _passwordField(context),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                            SlideLeftTransition(
                              page: ResetPasswordScreen(),
                            ),
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GlobalActionButton(
                          action: 'Login',
                          onPressed: () => _loginButtonPressed(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              NavigationHelper(
                leading: "Don't have an account?",
                action: "Register Now",
                onTap: () => Navigator.of(context).push(
                  SlideLeftTransition(
                    page: RegistrationScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              NavigationHelper(
                leading: "Only want to have a look around?",
                action: "Sign In",
                onTap: () {
                  _anonLoginHandler(context).then((value) {
                    if (!value) {
                      Timer(Duration(milliseconds: 500), () async {
                        await showInfoDialog(
                          _scaffoldKey.currentContext!,
                          _loginResult,
                        );
                      });
                    }
                  }).catchError((error) {
                    Timer(Duration(milliseconds: 500), () async {
                      await showInfoDialog(
                        _scaffoldKey.currentContext!,
                        error.toString(),
                      );
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
