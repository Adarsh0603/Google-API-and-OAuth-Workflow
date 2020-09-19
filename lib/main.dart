import 'package:flutter/material.dart';
import 'package:google_sign_in_workflow/data/auth.dart';
import 'package:google_sign_in_workflow/pages/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AppData(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Wrapper(),
      ),
    );
  }
}
