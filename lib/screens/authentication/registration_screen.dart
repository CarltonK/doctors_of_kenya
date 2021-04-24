import 'dart:async';
// import 'package:doctors_of_kenya/constants/constants.dart';
import 'package:doctors_of_kenya/helpers/helpers.dart';
import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RegistrationScreen extends StatelessWidget {
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
            RegistrationStepper(),
          ],
        ),
      ),
    );
  }
}

class RegistrationStepper extends StatefulWidget {
  @override
  _RegistrationStepperState createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  // Identifiers
  int _currentStep = 0;
  StepperType _stepperType = StepperType.vertical;
  String _email;
  String _password;
  String _confirmPassword;
  UserModel _userModel;
  dynamic _registrationResult;

  // Focus Nodes
  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusConfirmPassword = FocusNode();

  // Form
  final _registrationFormKey = GlobalKey<FormState>();

  // TextControllers
  TextEditingController passwordMain;
  TextEditingController passwordSecondary;

  // Validation
  ValidationHelper _validationHelper = ValidationHelper.empty();

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    // ignore: unnecessary_statements
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    // ignore: unnecessary_statements
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  // ******Email Stuff*******
  Widget _emailField() {
    return Container(
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
  Widget _passwordField() {
    return Container(
      child: TextFormField(
        controller: passwordMain,
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
  Widget _passwordConfirmField() {
    return Container(
      child: TextFormField(
        controller: passwordSecondary,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'Confirm password',
          prefixIcon: const Icon(Icons.vpn_key),
        ),
        validator: (value) {
          if (passwordMain.text != value) {
            return 'Passwords do not match';
          }
          return null;
        },
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

  Future<bool> _regHandler(UserModel user) async {
    _registrationResult = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).createUser(user);

    if (_registrationResult.runtimeType == String) {
      return false;
    }
    return true;
  }

  _registrationButtonPressed() {
    final FormState form = _registrationFormKey.currentState;
    if (form.validate()) {
      form.save();

      // Create a user instance
      _userModel = UserModel(
        email: _email,
        password: _password == _confirmPassword ? _confirmPassword : null,
      );

      _regHandler(_userModel).then((value) {
        if (!value) {
          Timer(Duration(milliseconds: 500), () async {
            await showInfoDialog(
              _scaffoldKey.currentContext,
              _registrationResult,
            );
          });
        } else {
          Navigator.of(context).pop();
        }
      }).catchError((error) {
        Timer(Duration(milliseconds: 500), () async {
          await showInfoDialog(
            _scaffoldKey.currentContext,
            error.toString(),
          );
        });
      });
    }
  }

  @override
  void initState() {
    passwordMain = TextEditingController();
    passwordSecondary = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    passwordMain.dispose();
    passwordSecondary.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 3,
                child: Stepper(
                  steps: <Step>[
                    Step(
                      title: Text(
                        'Account',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      content: Column(
                        children: [
                          _emailField(),
                          _passwordField(),
                          _passwordConfirmField(),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text(
                        'Account',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      content: Column(
                        children: [
                          _emailField(),
                          _passwordField(),
                          _passwordConfirmField(),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                  type: _stepperType,
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
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
    );
  }
}

// class RegistrationBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       child: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         padding: layoutPadding(context),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 100),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FlutterLogo(size: 100),
//               const SizedBox(height: 16),
//               Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 elevation: 3,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 24,
//                   ),
//                   child: Form(
//                     key: _registrationFormKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Welcome',
//                           style: Theme.of(context).textTheme.headline5,
//                         ),
//                         const SizedBox(height: 3),
//                         Text(
//                           'Create an Account',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         const SizedBox(height: 16),
//                         _emailField(context),
//                         const SizedBox(height: 16),
//                         _passwordField(context),
//                         const SizedBox(height: 16),
//                         _passwordConfirmField(context),
//                         const SizedBox(height: 16),
//                         GlobalActionButton(
//                           action: 'Register',
//                           onPressed: () => _registrationButtonPressed(context),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               NavigationHelper(
//                 leading: "Already have an account?",
//                 action: "Login",
//                 onTap: () => Navigator.of(context).pop(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
