import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_workflow/models/firebase_project.dart';
import 'package:http/http.dart' as http;

class AppData with ChangeNotifier {
  List<FirebaseProject> _firebaseProjectsList = [];
  List<FirebaseProject> get fpList => _firebaseProjectsList;

  GoogleSignInAccount _currentUser;
  GoogleSignInAccount get currentUser => _currentUser;

  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['https://www.googleapis.com/auth/firebase.readonly']);

  Stream<GoogleSignInAccount> get user => googleSignIn.onCurrentUserChanged;

  void autoLogin() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
      notifyListeners();
    });
    googleSignIn.signInSilently();
  }

  Future<void> signInWithGoogle() async {
    try {
      _currentUser = await googleSignIn.signIn();
      await getData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    googleSignIn.disconnect();
    _currentUser = null;

    _firebaseProjectsList = [];
    notifyListeners();
  }

  Future<void> getData() async {
    const url = 'https://firebase.googleapis.com/v1beta1/projects';
    var response = await http.get(url, headers: await _currentUser.authHeaders);

    List<FirebaseProject> projectList = [];
    var responseData = jsonDecode(response.body)['results'] as List;
    responseData.forEach((e) {
      projectList.add(FirebaseProject(e['projectId'], e['displayName']));
    });

    _firebaseProjectsList = projectList;
    notifyListeners();
  }
}
