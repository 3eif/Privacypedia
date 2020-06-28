import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/loadAsset.dart';
import '../structures/Website.dart';
import '../services/getData.dart';
import '../services/parseData.dart';
import 'WebsitePage.dart';
import 'InfoPage.dart';

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
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 5,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => InfoPage(),
                    ),
                  );
                },
              ),
            ),
          ],
          title: Text(
            "Privacypedia",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
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
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Card(
                elevation: 3,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.only(left: 2.0, top: 5.0, bottom: 5.0),
                  leading: Image.asset(
                    'images/${websites[index].logo}',
                    height: 110,
                    width: 110,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 7.5, left: 2.0),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
