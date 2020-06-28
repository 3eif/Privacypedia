import 'dart:convert';
import 'dart:async';
import 'Website.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

class _HomePageState extends State<HomePage> {
  List<dynamic> websites = [];

  Future getData() async {
    http.Response websitesResponse =
        await http.get("https://privacyspy.org/api/v2/index.json");
    List websitesData = json.decode(websitesResponse.body);

    for (var i = 0; i < websitesData.length; i++) {
      var data = websitesData[i];
      if (data['slug'] == 'youtube') continue;
      String websiteDetailsJSON = await loadAsset('data/${data['slug']}.json');
      final moreData = json.decode(websiteDetailsJSON);

      var website = Website();
      website.logo = data['icon'].replaceAll('svg', 'png');
      website.name = data['name'];
      website.score = data['score'].toString();
      website.description = moreData['description'];
      website.privacyPolicy =
          moreData['sources'][0] == null ? 'None' : moreData['sources'][0];

      List<String> rubrics = [
        'behavioralMarketing',
        'security',
        'thirdPartyCollection',
        'history',
        'dataDeletion',
        'dataBreaches',
        'thirdPartyAccess',
        'dataCollectionReasoning',
        'lawEnforcement',
        'nonCriticalPusposes',
        'listCollected',
        'revisionNotify'
      ];
      website.rubric = [];
      for (var n = 0; n < rubrics.length; n++) {
        website.rubric.add(!moreData['rubric'].containsKey(rubrics[n])
            ? 'None'
            : moreData['rubric'][rubrics[n]]['value']);
      }

      print(website.rubric);

      setState(() {
        websites.add(website);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TOS Summary"),
        backgroundColor: Colors.purple[900],
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          itemCount: websites == null ? 0 : websites.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              leading: Image.asset(
                'images/${websites[index].logo}',
                height: 100,
                width: 100,
              ),
              title: Text(websites[index].name),
              subtitle: Text('${websites[index].score}/10'),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => WebsitePage(websites[index]),
                  ),
                );
              },
              trailing: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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
