import 'package:flutter/material.dart';
import 'package:flutter_calendar_expense_tracker/pages/calendar.dart';
import 'package:flutter_calendar_expense_tracker/pages/calendar2.dart';
import 'package:flutter_calendar_expense_tracker/pages/login.dart';
import 'package:flutter_calendar_expense_tracker/pages/login2.dart';
import 'package:flutter_calendar_expense_tracker/providers/googler_signin_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   title: 'Google Sign In',
    //   home: LoginScreen(),
    // );
    // return MultiProvider(
    //   providers: [
    //     StreamProvider<GoogleSignInAccount?>.value(
    //       value: _googleSignIn.onCurrentUserChanged,
    //       initialData: null,
    //     )
    //   ],
    //   child: const MaterialApp(
    //     title: 'Google Sign In',
    //     home: LoginScreen2(),
    //   ),
    // );
    return MaterialApp(
      title: 'Google Sign In',
      home: ChangeNotifierProvider(
        create: ((context) => GoogleSignInProvider()),
        child: MaterialApp(
          title: 'Google Sign In',
          home: LoginScreen2(),
        ),
      ),
    );
  }
}

//Login Page
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   GoogleSignInAccount? _currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });

//       if (_currentUser != null) {
//         //update the top bar
//         // _handleGetCalenderEvents();
//         print(_currentUser);
//       }
//     });
//     _googleSignIn.signInSilently();
//   }

//   Widget _buildScreen() {
//     if (_currentUser != null) {
//       //create the scaffold that has:
//       //user profile in app bar
//       //buttons & calendar events for the body
//       return CalendarView(
//         googleSignIn: _googleSignIn,
//         photoURL: _currentUser!.photoUrl,
//         userName: _currentUser!.displayName,
//       );
//     } else {
//       //create the scaffold that has:
//       //no user profile in app bar
//       //login button
//       return Login(_googleSignIn);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildScreen();
//   }
// }

class LoginScreen2 extends StatelessWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  Widget _buildScreen(GoogleSignInProvider googleSignInProvider) {
    if (googleSignInProvider.user != null) {
      //create the scaffold that has:
      //user profile in app bar
      //buttons & calendar events for the body
      // return CalendarView(
      //   googleSignIn: _googleSignIn,
      //   photoURL: _currentUser!.photoUrl,
      //   userName: _currentUser!.displayName,
      // );
      return CalendarView2();
    } else {
      //create the scaffold that has:
      //no user profile in app bar
      //login button
      // return Login(_googleSignIn);
      return Login2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleSignInProvider>(
      builder: (context, googleSignInProvider, child) {
        return _buildScreen(googleSignInProvider);
      },
    );
  }
}
