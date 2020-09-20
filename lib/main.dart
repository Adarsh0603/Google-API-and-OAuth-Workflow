import 'package:flutter/material.dart';
import 'package:google_sign_in_workflow/data/appData.dart';
import 'package:google_sign_in_workflow/pages/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AppData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoogleSignInWorkFlow',
        home: Wrapper(),
      ),
    );
  }
}
