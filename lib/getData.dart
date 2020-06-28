import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future getData() async {
  http.Response websitesResponse =
      await http.get("https://privacyspy.org/api/v2/index.json");
  List websitesData = json.decode(websitesResponse.body);
  return websitesData;
}
