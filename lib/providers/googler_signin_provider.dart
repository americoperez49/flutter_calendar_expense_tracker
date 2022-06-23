import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId:
    //     '855883079806-f605ka3euedgff42kd9tffmk980l73ok.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/calendar',
    ],
  );

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  GoogleSignInProvider() {
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _user = account;
      notifyListeners();
    });
  }

  signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  signOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (error) {
      print(error);
    }
  }
}
