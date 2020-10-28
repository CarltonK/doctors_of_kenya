import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomPaint(
          painter: BackgroundPainter(),
          child: LoginBody(),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hello',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Sign in to your Account',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    decoration: InputDecoration(
                      //                   border: OutlineInputBorder(),
                      labelText: 'Email ID',
                    ),
                  ),
                ),
                //            const SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    decoration: InputDecoration(
//                  border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: null,
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.lato(),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.orange,
                      padding: EdgeInsets.all(12),
                      height: 50,
                      child: Center(
                        child: Text(
                          'Login',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      onPressed: () {}),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        NavigationHelper(
          leading: "Don't have an account?",
          action: "Register Now",
          onTap: () => print('I want to register an account'),
        ),
      ],
    );
  }
}
