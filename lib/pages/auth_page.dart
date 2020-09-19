import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in_workflow/data/appData.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Sign In'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              SignInButton(
                Buttons.GoogleDark,
                text: "Sign in with Google",
                onPressed: () async {
                  await Provider.of<AppData>(context, listen: false)
                      .signInWithGoogle();
                },
              ),
            ],
          ),
        ));
  }
}
