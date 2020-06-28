import 'dart:convert';
import 'dart:async';
import 'Website.dart';
import 'WebsitePage.dart';
import 'loadAsset.dart';
import 'package:flutter/material.dart';
import 'getData.dart';
import 'parseData.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> websites = [];

  Future setData() async {
    dynamic websitesData = await getData();

    for (var i = 0; i < websitesData.length; i++) {
      var data = websitesData[i];
      if (data['slug'] == 'youtube') continue;
      String websiteDetailsJSON = await loadAsset('data/${data['slug']}.json');
      final moreData = json.decode(websiteDetailsJSON);

      Website websiteToAdd = parseData(data, moreData, i);

      setState(() {
        websites.add(websiteToAdd);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setData();
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
