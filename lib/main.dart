import 'package:doctors_of_kenya/screens/authentication/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:doctors_of_kenya/constants/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Initialize firebase outside build to avoid future builder triggers
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
