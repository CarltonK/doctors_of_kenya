import 'dart:async';
import 'package:doctors_of_kenya/providers/providers.dart';
import 'package:doctors_of_kenya/screens/screens.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:doctors_of_kenya/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => AuthProvider.instance(),
    ),
    Provider(
      create: (context) => DatabaseProvider(),
    ),
  ];

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: providers,
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  // Initialize firebase outside build to avoid future builder triggers
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctors of Kenya',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
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
            // Pass all uncaught errors to Crashlytics.
            FlutterError.onError =
                FirebaseCrashlytics.instance.recordFlutterError;

            return Consumer<AuthProvider>(
              builder: (context, value, child) {
                if (value.status == Status.Authenticated) return HomeScreen();
                if (value.status == Status.Authenticating)
                  return GlobalLoader();
                return child;
              },
              child: LoginScreen(),
            );
          }
          return GlobalLoader();
        },
      ),
    );
  }
}
