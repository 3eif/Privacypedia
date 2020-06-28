import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Website {
  String logo;
  String name;
  String score;
  Color scoreColor;
}

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

class _HomePageState extends State<HomePage> {
  List<dynamic> websites = [];

  Future getData() async {
    //Get the JSON file
    http.Response websitesResponse =
        await http.get("https://privacyspy.org/api/v2/index.json");

    List websitesData = json.decode(websitesResponse.body);

    for (var i = 0; i < websitesData.length; i++) {
      var data = websitesData[i];

      String jsonCrossword = await loadAsset('data/${data['name']}.json');
      print(jsonCrossword);

      var website = Website(); //The logo object
      website.logo = data['icon'].replaceAll('svg', 'png');
      website.name = data['name'];
      website.score = data['score'].toString();

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
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}