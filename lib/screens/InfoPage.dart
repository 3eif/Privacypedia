import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 1,
          backgroundColor: Colors.indigo,
          title: Text(
            "Information",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      './images/app_icon.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Text(
                  'Privacypedia',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.indigo[800],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: new Divider(
                color: Colors.indigo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 10.0, bottom: 1.0),
              child: Card(
                elevation: 15,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'What Is It?\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.5,
                                  color: Colors.indigo[600]),
                            ),
                            TextSpan(
                              text:
                                  'Privacypedia collects and summarizes privacy polcies to help people be mindful of their data.\n\nMade in 36 hours with Dart & Flutter during AtlasHacks 2020',
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.black),
                            ),
                          ],
                        ),
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
                                child: new Text('Source Code',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                onPressed: () => launch(
                                    'https://github.com/Tetracyl/AtlasHacks2020'),
                                color: Colors.indigo[800],
                                elevation: 2,
                              ),
                            ),
                          ),
                          new InkWell(
                            child: SizedBox(
                              width: 150,
                              child: new RaisedButton(
                                child: new Text('AtlasHacks',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                onPressed: () =>
                                    launch('https://www.atlashacks.tech/'),
                                color: Colors.indigo[800],
                                elevation: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Card(
                elevation: 15,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'How does it work?\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.5,
                                  color: Colors.indigo[600]),
                            ),
                            TextSpan(
                              text:
                                  'Privacypedia retrieves data from PrivacySpy\'s public API and displayes it in a modern and intuitive fashion.',
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.black),
                            ),
                          ],
                        ),
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
                                child: new Text('PrivacySpy',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                onPressed: () =>
                                    launch('https://privacyspy.org/'),
                                color: Colors.indigo[800],
                                elevation: 2,
                              ),
                            ),
                          ),
                          new InkWell(
                            child: SizedBox(
                              width: 150,
                              child: new RaisedButton(
                                child: new Text(
                                  'PrivacySpy API',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                onPressed: () => launch(
                                    'https://privacyspy.org/api/v2/index.json'),
                                color: Colors.indigo[800],
                                elevation: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
