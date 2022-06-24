import 'package:flutter/material.dart';
import 'package:flutter_calendar_expense_tracker/providers/google_provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class Login2 extends StatelessWidget {
  const Login2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleProvider>(
      builder: (context, GoogleProvider, child) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.red),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SignInButton(
                Buttons.GoogleDark,
                onPressed: () => GoogleProvider.signIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
