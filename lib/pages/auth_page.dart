import 'package:flutter/material.dart';
import 'package:google_sign_in_workflow/data/appData.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListTile(
        title: Text("Sign in With Google"),
        onTap: () async {
          await Provider.of<AppData>(context, listen: false).signInWithGoogle();
          print('Sign in Successful');
        },
      ),
    ));
  }
}
