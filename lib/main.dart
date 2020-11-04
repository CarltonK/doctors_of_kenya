import 'package:doctors_of_kenya/screens/authentication/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Initialize firebase outside build to avoid future builder triggers
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final headlineStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: 30,
  );

  final miniheadlineStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  final subheadlineStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  final buttonStyle = GoogleFonts.lato(
    color: Colors.white,
    letterSpacing: 0.5,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  final boldWhite = GoogleFonts.lato(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctors of Kenya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orange[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline4: miniheadlineStyle,
          headline5: headlineStyle,
          subtitle1: subheadlineStyle,
          button: buttonStyle,
          bodyText1: boldWhite,
        ),
      ),
      home: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Text('Error -> ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: SpinKitWave(
              color: Theme.of(context).accentColor,
              size: 100,
            ),
          );
        },
      ),
    );
  }
}
