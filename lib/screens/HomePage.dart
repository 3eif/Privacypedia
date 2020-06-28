import 'dart:convert';
import 'dart:async';
import '../structures/Website.dart';
import 'WebsitePage.dart';
import '../services/loadAsset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/getData.dart';
import '../services/parseData.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 1,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10.0),
            child: Text(
              "TOS Summary",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.black,
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          itemCount: websites == null ? 0 : websites.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
              leading: Image.asset(
                'images/${websites[index].logo}',
                height: 110,
                width: 110,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 7.5, left: 5.0),
                child: Text(
                  websites[index].name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              subtitle: Align(
                alignment: Alignment.bottomLeft,
                child: Chip(
                  label: new Text(
                    '${websites[index].score}/10',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: websites[index].scoreColor,
                ),
              ),
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
