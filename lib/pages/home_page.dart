import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_workflow/data/appData.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Firebase Projects'),
          actions: [
            FlatButton(
              child: Text('logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await appData.signOut();
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Container(
                      width: 36,
                      height: 36,
                      child: GoogleUserCircleAvatar(
                          identity: appData.currentUser)),
                ],
              ),
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
                                  onTap: () async {
                                    var url =
                                        'https://console.firebase.google.com/project/${appData.fpList[i].projectId}/';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
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
