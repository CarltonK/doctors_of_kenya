import 'package:doctors_of_kenya/constants/constants.dart';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/screens/authentication/authentication.dart';
import 'package:doctors_of_kenya/screens/home/home.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
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
            LoginBody(),
          ],
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
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
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email ID',
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.vpn_key),
                          ),
                        ),
                      ),
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
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.orange,
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).push(
                          SlideLeftTransition(
                            page: HomeScreen(),
                          ),
                        ),
                      ),
                    ],
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
                onTap: () => Provider.of<AuthProvider>(context, listen: false)
                    .anonymousSignIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
