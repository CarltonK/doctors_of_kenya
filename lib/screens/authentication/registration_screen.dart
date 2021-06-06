import 'dart:async';
// import 'package:doctors_of_kenya/constants/constants.dart';
import 'package:doctors_of_kenya/helpers/helpers.dart';
import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
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
  String? _firstName, _lastName;
  String? _email;
  String? _password;
  String? _confirmPassword;
  UserModel? _userModel;
  dynamic _registrationResult;
  String? _currentDesignation;
  List<String> _designations = ['Practitioner', 'Liaison', 'General'];
  String? _selectedGender;
  List<String> _genders = ['Male', 'Female', 'Do not wish to disclose'];
  final int _eighteenYearsInDays = 6570;
  DateTime? _dob;
  List<String> _chronicConditions = [];
  List<String> _currentMedications = [];
  String? _primaryDoctor;
  List<String> _otherDoctors = [];
  String? _mpdbNumber;
  DateTime? _mpdbRegistrationDate;
  bool _formComplete = false;

  // Focus Nodes
  final FocusNode _focusLastName = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusConfirmPassword = FocusNode();
  final FocusNode _focusOtherDoctors = FocusNode();
  final FocusNode _focusMedications = FocusNode();
  final FocusNode _focusConditions = FocusNode();

  // Form
  final _accountFormKey = GlobalKey<FormState>();

  // TextControllers
  TextEditingController? passwordMain;
  TextEditingController? passwordSecondary;

  // Validation
  ValidationHelper _validationHelper = ValidationHelper.empty();

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    // ignore: unnecessary_statements
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
    if (_currentStep == 3 && _formComplete) {
      _registrationButtonPressed();
    }
  }

  cancel() {
    // ignore: unnecessary_statements
    _currentStep >= 1 ? setState(() => _currentStep -= 1) : null;
  }

  // ******Name Stuff*******
  Widget _firstNameField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'First Name',
          prefixIcon: const Icon(Icons.person),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusLastName);
        },
        validator: _validationHelper.validateNames,
        onSaved: saveFirstName,
      ),
    );
  }

  Widget _lastNameField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _focusLastName,
        decoration: InputDecoration(
          labelText: 'Last Name',
          prefixIcon: const Icon(Icons.person),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusEmail);
        },
        validator: _validationHelper.validateNames,
        onSaved: saveLastName,
      ),
    );
  }

  void saveFirstName(String? value) {
    _firstName = value!.trim();
  }

  void saveLastName(String? value) {
    _lastName = value!.trim();
  }

  // ******Email Stuff*******
  Widget _emailField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _focusEmail,
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
  }

  // ******Password Stuff*******
  Widget _passwordField() {
    return Container(
      child: TextFormField(
        controller: passwordMain,
        textInputAction: TextInputAction.next,
        obscureText: true,
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

  void savePassword(String? value) {
    _password = value!.trim();
  }

  // ******Password Confirm Stuff*******
  Widget _passwordConfirmField() {
    return Container(
      child: TextFormField(
        controller: passwordSecondary,
        textInputAction: TextInputAction.done,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirm password',
          prefixIcon: const Icon(Icons.vpn_key),
        ),
        validator: (value) {
          if (passwordMain!.text != value) {
            return 'Passwords do not match';
          }
          return null;
        },
        focusNode: _focusConfirmPassword,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).unfocus();
          // setState(() => _currentStep += 1);
        },
        onSaved: saveConfirmPassword,
      ),
    );
  }

  void saveConfirmPassword(String? value) {
    _confirmPassword = value!.trim();
  }

  Future<bool> _regHandler(UserModel user) async {
    _registrationResult = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).createUser(user);

    if (_registrationResult.runtimeType == String) {
      return false;
    }
    _userModel!.uid = _registrationResult.uid;
    return true;
  }

  // ******Designation Stuff*******
  _designationSelector() {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(top: 15),
      decoration: Constants.kBoxDecorationStyle,
      child: DropdownButton<String>(
        value: _currentDesignation,
        style: Theme.of(context).textTheme.subtitle1,
        onChanged: _designationChanged,
        icon: Icon(Icons.arrow_downward, color: Theme.of(context).accentColor),
        hint: Text('Choose', style: Theme.of(context).textTheme.subtitle1),
        items: _designations
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e, style: Theme.of(context).textTheme.subtitle1),
              ),
            )
            .toList(),
        isExpanded: true,
        isDense: false,
        underline: Container(color: Colors.transparent),
      ),
    );
  }

  _designationChanged(String? value) {
    setState(() {
      _currentDesignation = value;
      if (_currentDesignation == 'Liasion') _formComplete = true;
    });
  }

  // ******Gender Stuff*******
  _genderSelector() {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(top: 15),
      decoration: Constants.kBoxDecorationStyle,
      child: DropdownButton<String>(
        value: _selectedGender,
        style: Theme.of(context).textTheme.subtitle1,
        onChanged: _genderChanged,
        icon: Icon(Icons.arrow_downward, color: Theme.of(context).accentColor),
        hint: Text('Gender', style: Theme.of(context).textTheme.subtitle1),
        items: _genders
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e, style: Theme.of(context).textTheme.subtitle1),
              ),
            )
            .toList(),
        isExpanded: true,
        isDense: false,
        underline: Container(color: Colors.transparent),
      ),
    );
  }

  _genderChanged(String? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  // ******Date Selector Stuff*******
  Widget _dateSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of Birth',
            style: Constants.subheadlineStyle,
          ),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now().subtract(
                Duration(days: _eighteenYearsInDays),
              ),
              initialDateTime: DateTime.now().subtract(
                Duration(days: _eighteenYearsInDays + 1),
              ),
              onDateTimeChanged: (DateTime newDateTime) {
                _dob = newDateTime;
              },
            ),
          ),
        ],
      ),
    );
  }

  // ******Practitioners Stuff*******
  // ******Mpdb number Stuff*******
  Widget _mpdbField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'MPDB Registration Number',
          prefixIcon: const Icon(Icons.app_registration),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).unfocus();
        },
        validator: _validationHelper.validateMpdbNumber,
        onSaved: saveMpdbNumber,
      ),
    );
  }

  void saveMpdbNumber(String? value) {
    _mpdbNumber = value!.trim();
  }

  // ******Mpdb registration date Stuff*******
  Widget _mpdbRegDateSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MPDB Registration Date',
            style: Constants.subheadlineStyle,
          ),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                _mpdbRegistrationDate = newDateTime;
                setState(() {
                  _formComplete = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // ******Non-practitioners Stuff*******
  // ******Primary Doctor Stuff*******
  Widget _primaryDoctorField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Primary doctor',
          helperText: 'There is no need to add `Dr.` before the name',
          prefixIcon: const Icon(Icons.person),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusOtherDoctors);
        },
        onSaved: savePrimaryDoctor,
      ),
    );
  }

  void savePrimaryDoctor(String? value) {
    _primaryDoctor = value!.trim();
  }

  // ******Other Doctors Stuff*******
  Widget _otherDoctorsField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _focusOtherDoctors,
        decoration: InputDecoration(
          labelText: 'Other doctors',
          helperText: 'Please enter the names separated by a comma (,)',
          prefixIcon: const Icon(Icons.people),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusConditions);
        },
        onSaved: saveOtherDoctors,
      ),
    );
  }

  void saveOtherDoctors(String? value) {
    if (value!.contains(',')) {
      _otherDoctors = [...value.split(',')];
    } else {
      _otherDoctors.add(value);
    }
  }

  // ******Conditions Stuff*******
  Widget _conditionsField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _focusConditions,
        decoration: InputDecoration(
          labelText: 'Current conditions',
          helperText: 'Please enter your conditions separated by a comma (,)',
          prefixIcon: const Icon(Icons.sick),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_focusMedications);
        },
        onSaved: saveConditions,
      ),
    );
  }

  void saveConditions(String? value) {
    if (value!.contains(',')) {
      _chronicConditions = [...value.split(',')];
    } else {
      _chronicConditions.add(value);
    }
  }

  // ******Medications Stuff*******
  Widget _medicationsField() {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: _focusMedications,
        decoration: InputDecoration(
          labelText: 'Medications',
          helperText: 'Please enter your medications separated by a comma (,)',
          prefixIcon: const Icon(Icons.local_pharmacy),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).unfocus();
          setState(() {
            _formComplete = true;
          });
        },
        onSaved: saveMedications,
      ),
    );
  }

  void saveMedications(String? value) {
    if (value!.contains(',')) {
      _currentMedications = [...value.split(',')];
    } else {
      _currentMedications.add(value);
    }
  }

  _registrationButtonPressed() {
    final FormState form = _accountFormKey.currentState!;

    if (_selectedGender == null) {
      showInfoDialog(
        _scaffoldKey.currentContext!,
        'Please select your gender',
      );
    } else if (_dob == null) {
      showInfoDialog(
        _scaffoldKey.currentContext!,
        'Please select your date of birth',
      );
    } else if (_currentDesignation == null) {
      showInfoDialog(
        _scaffoldKey.currentContext!,
        'Please select your designation',
      );
    } else {
      if (form.validate()) {
        form.save();

        // Create a user instance
        _userModel = UserModel(
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          password: _password == _confirmPassword ? _confirmPassword : null,
          gender: _selectedGender,
          dob: _dob,
          designation: _currentDesignation,
          primaryDoctor: _primaryDoctor,
          otherDoctors: _otherDoctors,
          chronicConditions: _chronicConditions,
          medications: _currentMedications,
          mpdbRegNumber: _mpdbNumber,
          mpdbRegDate: _mpdbRegistrationDate,
          registeredOn: DateTime.now(),
        );

        _regHandler(_userModel!).then((value) {
          if (!value) {
            Timer(Duration(milliseconds: 500), () async {
              await showInfoDialog(
                _scaffoldKey.currentContext!,
                _registrationResult,
              );
            });
          } else {
            Navigator.of(context).pop();
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

    passwordMain!.dispose();
    passwordSecondary!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100, top: 100),
        child: SingleChildScrollView(
          child: Form(
            key: _accountFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 3,
                  child: Stepper(
                    steps: <Step>[
                      Step(
                        title: Text(
                          'Personal Information (1/2)',
                          style: Constants.headlineStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'Required',
                          style: Constants.subheadlineStyle,
                        ),
                        content: Column(
                          children: [
                            _firstNameField(),
                            _lastNameField(),
                            _emailField(),
                            _passwordField(),
                            _passwordConfirmField(),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text(
                          'Personal Information (2/2)',
                          style: Constants.headlineStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'Required',
                          style: Constants.subheadlineStyle,
                        ),
                        content: Column(
                          children: [
                            _genderSelector(),
                            _dateSelector(),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: Text(
                          'Designation',
                          style: Constants.headlineStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        content: Column(
                          children: [
                            _designationSelector(),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      _currentDesignation == 'Practitioner'
                          ? Step(
                              title: Text(
                                'Practitioners',
                                style: Constants.headlineStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                'Required',
                                style: Constants.subheadlineStyle,
                              ),
                              content: Column(
                                children: [
                                  _mpdbField(),
                                  _mpdbRegDateSelector(),
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 3
                                  ? StepState.complete
                                  : StepState.disabled,
                            )
                          : _currentDesignation == 'General'
                              ? Step(
                                  title: Text(
                                    'General',
                                    style: Constants.headlineStyle.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Optional',
                                    style: Constants.subheadlineStyle,
                                  ),
                                  content: Column(
                                    children: [
                                      _primaryDoctorField(),
                                      _otherDoctorsField(),
                                      _conditionsField(),
                                      _medicationsField(),
                                    ],
                                  ),
                                  isActive: _currentStep >= 0,
                                  state: _currentStep >= 3
                                      ? StepState.complete
                                      : StepState.disabled,
                                )
                              : Step(
                                  title: Text(
                                    'Let\'s get started',
                                    style: Constants.headlineStyle.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  content: Column(
                                    children: [],
                                  ),
                                  isActive: _currentStep >= 0,
                                  state: _currentStep >= 3
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
      ),
    );
  }
}
