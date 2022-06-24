import 'package:flutter/material.dart';
import 'package:flutter_calendar_expense_tracker/pages/calendar2.dart';
import 'package:flutter_calendar_expense_tracker/pages/login2.dart';
import 'package:flutter_calendar_expense_tracker/providers/google_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign In',
      home: ChangeNotifierProvider(
        create: ((context) => GoogleProvider()),
        child: MaterialApp(
          title: 'Google Sign In',
          home: LoginScreen2(),
        ),
      ),
    );
  }
}

class LoginScreen2 extends StatelessWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  Widget _buildScreen(GoogleProvider googleProvider) {
    if (googleProvider.user != null) {
      return CalendarView2();
    } else {
      return Login2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleProvider>(
      builder: (context, googleProvider, child) {
        return _buildScreen(googleProvider);
      },
    );
  }
}
