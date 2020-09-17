import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  GoogleSignInAccount _currentUser;

  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['https://www.googleapis.com/auth/firebase.readonly']);

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print(e);
    }

//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//
//      _currentUser=account;
//
//    });
//
//    _googleSignIn.signInSilently();
  }
}
