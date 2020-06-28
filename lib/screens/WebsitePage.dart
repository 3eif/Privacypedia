import '../structures/Website.dart';
import 'package:flutter/material.dart';

List<String> rubricDescriptions = [
  'Does the policy allow personally-targeted or behavioral marketing?',
  'Does the policy outline the service\'s general security practices?',
  'Does the service collect personal data from third parties?',
  'Is the policy\'s history made available?',
  'Does the service allow you to permanently delete your personal data?',
  'Does the policy require users to be notified in case of a data breach?',
  'Does the service allow third-party access to private personal data?',
  'Is it clear why the service collects the personal data that it does?',
  'Is it clear why the service collects the personal data that it does?',
  'When does the policy allow law enforcement access to personal data?',
  'Does the service allow the user to control whether personal data is collected or used for non-critical purposes?',
  'Does the policy list the personal data it collects?',
  'Will affected users be notified when the policy is meaningfully changed?',
];

class WebsitePage extends StatelessWidget {
  final Website website;
  WebsitePage(this.website);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(website.name),
        backgroundColor: Colors.purple[900],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/${website.logo}',
              height: 100,
              width: 100,
            ),
            Text(
              'Name: ${website.name}\nScore: ${website.score}\nWebsite: ${website.hostnames}\nDescription: ${website.description}\nPrivacy Policy: ${website.privacyPolicy}\nSummary: $rubricDescriptions${website.rubric}',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
