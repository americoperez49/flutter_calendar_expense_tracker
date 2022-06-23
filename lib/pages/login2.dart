import 'package:flutter/material.dart';
import 'package:flutter_calendar_expense_tracker/providers/googler_signin_provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

// class Login extends StatefulWidget {
//   final GoogleSignIn googleSignIn;
//   const Login(this.googleSignIn, {Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   Future<void> _handleSignIn() async {
//     try {
//       await widget.googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.red),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             SignInButton(
//               Buttons.GoogleDark,
//               onPressed: () {
//                 _handleSignIn();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Login2 extends StatelessWidget {
  const Login2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleSignInProvider>(
      builder: (context, googleSignInProvider, child) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.red),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SignInButton(
                Buttons.GoogleDark,
                onPressed: () => googleSignInProvider.signIn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
