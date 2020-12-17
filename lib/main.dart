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
    fontSize: 27,
  );

  final miniheadlineStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: 21,
    color: Colors.black,
  );

  final subheadlineStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  final drawerItemStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.black,
    letterSpacing: 0.3,
  );

  final buttonStyle = GoogleFonts.lato(
    color: Colors.white,
    letterSpacing: 0.5,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  final normalWhite = GoogleFonts.lato(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: .2,
  );

  final headlineWhite = GoogleFonts.lato(
    color: Colors.white,
    fontSize: 27,
    fontWeight: FontWeight.bold,
  );

  final subHeadlineWhite = GoogleFonts.lato(
    color: Colors.white,
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );

  final subtitleWhite = GoogleFonts.lato(
    color: Colors.white,
    fontSize: 15,
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
          headline5: headlineStyle,
          headline4: miniheadlineStyle,
          headline3: subHeadlineWhite,
          headline2: headlineWhite,
          subtitle1: subheadlineStyle,
          subtitle2: drawerItemStyle,
          bodyText1: normalWhite,
          bodyText2: subtitleWhite,
          button: buttonStyle,
        ),
      ),
      home: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
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
