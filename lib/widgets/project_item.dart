import 'package:flutter/material.dart';
import 'package:google_sign_in_workflow/models/firebase_project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectItem extends StatelessWidget {
  final FirebaseProject fp;

  ProjectItem(this.fp);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () async {
            var url =
                'https://console.firebase.google.com/project/${fp.projectId}/overview';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          title: Text(
            fp.displayName,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            fp.projectId,
            style: TextStyle(color: Colors.grey[400]),
          ),
        ),
        Divider(height: 0),
      ],
    );
  }
}
