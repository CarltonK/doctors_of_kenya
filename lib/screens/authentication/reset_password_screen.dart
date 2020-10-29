import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomPaint(
          painter: BackgroundPainter(),
          child: ResetPasswordBody(),
        ),
      ),
    );
  }
}

class ResetPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 100,
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'It happens',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "We'll send you an email",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(6),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Email ID',
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.orange,
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              'Send Email',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
