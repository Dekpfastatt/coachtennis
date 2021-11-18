import 'package:coachtennis/coach/signup/services/authservice.dart';
import 'package:coachtennis/coach/signup/signupscreen.dart';
import 'package:coachtennis/utilities/coachtennis_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'coach/homescreen/homescreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final myTheme = CoachTennisTheme.darkMode();

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: "APP",
        home: AuthWrapper(),
        theme: myTheme,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    if (user != null) {
      return HomeScreen();
    } else {
      return SignUpScreen(themeVal: myTheme);
    }
  }
}
