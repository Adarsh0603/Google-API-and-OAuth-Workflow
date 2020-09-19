import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
    var appData = Provider.of<AppData>(context, listen: false);
    if (appData.currentUser != null) {
      appData.googleSignIn.signInSilently();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Provider.of<AppData>(context, listen: false).userStream.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data == null ? AuthPage() : HomePage();
        },
      ),
    );
  }
}
