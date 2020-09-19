import 'package:flutter/material.dart';
import 'package:google_sign_in_workflow/data/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('SignedIn'),
          actions: [
            FlatButton(
              child: Text('LogOut'),
              onPressed: () async {
                await appData.signOut();
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: appData.getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Consumer<AppData>(
                    builder: (BuildContext context, appData, _) =>
                        ListView.builder(
                            itemCount: appData.fpList.length,
                            itemBuilder: (ctx, i) => ListTile(
                                  leading:
                                      Image.asset('assets/firebaselogo.png'),
                                  title: Text(appData.fpList[i].displayName),
                                  subtitle: Text(appData.fpList[i].projectId),
                                )),
                  );
          },
        ));
  }
}
