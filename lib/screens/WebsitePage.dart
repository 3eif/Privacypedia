import '../structures/Website.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 1,
          backgroundColor: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
                  child: Image.asset(
                    'images/${website.logo}',
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        website.name,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${website.score}/10',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 30,
                          color: website.scoreColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 25.0, right: 25.0, bottom: 10.0),
              child: new Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 1.0),
              child: Text.rich(
                TextSpan(
                  text: '${website.description}',
                  style: TextStyle(fontSize: 17.5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new InkWell(
                    child: SizedBox(
                      width: 150,
                      child: new RaisedButton(
                        child:
                            new Text('Website', style: TextStyle(fontSize: 15)),
                        onPressed: () => launch(website.hostnames),
                        color: Colors.black,
                        elevation: 2,
                      ),
                    ),
                  ),
                  new InkWell(
                    child: SizedBox(
                      width: 150,
                      child: new RaisedButton(
                        child: new Text('Privacy Policy',
                            style: TextStyle(fontSize: 15)),
                        onPressed: () => launch(website.privacyPolicy),
                        color: Colors.black,
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 1.0, left: 25.0, right: 25.0, bottom: 5.0),
              child: new Divider(
                color: Colors.black,
              ),
            ),
            Flexible(
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 25.0),
                  itemCount: website.rubric.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              text: '${rubricDescriptions[index]}\n',
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${website.rubric[index]}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
