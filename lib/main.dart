import 'package:flutter/material.dart';
import 'package:flutter_calendar_expense_tracker/pages/calendar.dart';
import 'package:flutter_calendar_expense_tracker/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId:
  //     '855883079806-f605ka3euedgff42kd9tffmk980l73ok.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/calendar',
  ],
);

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: LoginScreen(),
    ),
  );
}

//Login Page
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });

      if (_currentUser != null) {
        //update the top bar
        // _handleGetCalenderEvents();
        print(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  Widget _buildScreen() {
    if (_currentUser != null) {
      //create the scaffold that has:
      //user profile in app bar
      //buttons & calendar events for the body
      return CalendarView(
        googleSignIn: _googleSignIn,
        photoURL: _currentUser!.photoUrl,
        userName: _currentUser!.displayName,
      );
    } else {
      //create the scaffold that has:
      //no user profile in app bar
      //login button
      return Login(_googleSignIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildScreen();
  }
}
