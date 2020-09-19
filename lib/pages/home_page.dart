import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_workflow/data/appData.dart';
import 'package:google_sign_in_workflow/widgets/project_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Firebase Helper'),
          actions: [
            FlatButton(
              child: Text('LOGOUT', style: TextStyle(color: Colors.white)),
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
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  )
                : Consumer<AppData>(
                    child: Center(
                        child: Text(
                            'You have no firebase projects\nlinked with this account.')),
                    builder: (BuildContext context, appData, ch) =>
                        appData.fpList.length == 0
                            ? ch
                            : ListView.builder(
                                itemCount: appData.fpList.length,
                                itemBuilder: (ctx, i) =>
                                    ProjectItem(appData.fpList[i])),
                  );
          },
        ));
  }
}
