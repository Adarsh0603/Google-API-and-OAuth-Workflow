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

  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['https://www.googleapis.com/auth/firebase.readonly']);

  StreamController<GoogleSignInAccount> userStream = StreamController();
  GoogleSignInAccount get currentUser => _currentUser;
  Future<void> signInWithGoogle() async {
    try {
      _currentUser = await googleSignIn.signIn();
      print(_currentUser);
      userStream.add(_currentUser);
      await getData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    googleSignIn.disconnect();
    userStream.add(null);
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
