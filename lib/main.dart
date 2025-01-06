import 'package:altruistech/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'first_welcome_screen.dart';
import 'second_welcome_screen.dart';
import 'third_welcome_screen.dart';
import 'signup_screen.dart';
import 'login_success.dart';
import 'register_profile.dart';
import 'industry/industry_home.dart';
import 'citizen/citizen_home.dart';
import 'government/government_home.dart';
import 'consultant/consultant_home.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase options
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyAj9889kXHbGGF-dVs1dVGiQ5JKzvQ9M5Y",
    authDomain: "altruistech-e766b.firebase.com",
    projectId: "altruistech-e766b",
    storageBucket: "altruistech-e766b.appspot.com",
    messagingSenderId: "1:226264003071:android:8f64daef377009bccd77ca",
    appId: "1:226264003071:android:8f64daef377009bccd77ca",
  );

  // Initializing Firebase
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Altruistexh Innovations',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          surfaceTintColor: Colors.transparent,

        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/monitoring': (context) => const MonitoringScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/lastscreen': (context) => const LastScreen(),
        '/loginsuccess': (context) => const LoginSuccessScreen(),
        '/register': (context) => const RoleSelectionScreen(),
        '/citizenhome': (context) => const CitizenScreen(),
        '/consultanthome': (context) => const ConsultantScreen(),
        '/governmenthome': (context) => const GovernmentScreen(),
        '/industryhome': (context) => const ManufacturingScreen(),
        '/roleselection': (context) => const RoleSelectionScreen(),



      },
      debugShowCheckedModeBanner: false,
    );
  }
}
