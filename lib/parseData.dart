import 'Website.dart';

Website parseData(Map data, final moreData, int i) {
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

  return website;
}
