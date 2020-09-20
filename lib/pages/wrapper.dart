import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_workflow/data/appData.dart';
import 'package:google_sign_in_workflow/pages/auth_page.dart';
import 'package:google_sign_in_workflow/pages/home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    final appData = Provider.of<AppData>(context, listen: false);
    appData.autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    return StreamBuilder(
        stream: appData.googleSignIn.onCurrentUserChanged,
        builder: (context, snapshot) {
          return appData.currentUser == null ? AuthPage() : HomePage();
        });
  }
}
