import 'package:doctors_of_kenya/helpers/helpers.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ResetPasswordScreen extends StatelessWidget {
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
            ResetPasswordBody(),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordBody extends StatelessWidget {
  // Form
  final _passwordResetFormKey = GlobalKey<FormState>();

  // Validation
  static ValidationHelper _validationHelper = ValidationHelper.empty();

  // Identifiers
  static String? _email;
  static dynamic _resetResult;

  // ******Email Stuff*******
  Widget _emailField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email),
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).unfocus();
          _resetButtonPressed(context);
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

  Future<bool> _resetHandler(BuildContext context) async {
    _resetResult = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).resetPassword(_email!);

    if (_resetResult.runtimeType == String) {
      return false;
    }
    return true;
  }

  _resetButtonPressed(BuildContext context) {
    final FormState form = _passwordResetFormKey.currentState!;
    if (form.validate()) {
      form.save();

      _resetHandler(context).then((value) {
        if (!value) {
          Timer(Duration(milliseconds: 500), () async {
            await showInfoDialog(
              _scaffoldKey.currentContext!,
              _resetResult,
            );
          });
        } else {
          Timer(Duration(milliseconds: 500), () async {
            await showInfoDialog(
              _scaffoldKey.currentContext!,
              "An password reset email has been sent to you at $_email",
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
                    key: _passwordResetFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'It happens',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "We'll send you an email",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 16),
                        _emailField(context),
                        const SizedBox(height: 16),
                        GlobalActionButton(
                          action: 'Send Email',
                          onPressed: () => _resetButtonPressed(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
