import 'package:flutter/material.dart';

import '../structures/Website.dart';

Website parseData(Map data, final moreData, int i) {
  var website = Website();
  website.logo = data['icon'].replaceAll('svg', 'png');
  website.name = data['name'];
  website.score = data['score'].toString();
  website.description = moreData['description'];
  website.hostnames = 'https://${moreData['hostnames'][0]}';
  website.privacyPolicy =
      moreData['sources'][0] == null ? 'N/A' : moreData['sources'][0];

  if (double.parse(website.score) >= 7.5)
    website.scoreColor = Colors.green;
  else if (double.parse(website.score) >= 3.5)
    website.scoreColor = Colors.orange;
  else
    website.scoreColor = Colors.red;

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
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  for (var n = 0; n < rubrics.length; n++) {
    website.rubric.add(!moreData['rubric'].containsKey(rubrics[n])
        ? 'None'
        : capitalize(
            moreData['rubric'][rubrics[n]]['value'].replaceAll('-', ' ')));
  }

  return website;
}
