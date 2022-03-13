import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = 'https://intense-badlands-24863.herokuapp.com/';
  var log = Logger();

  Future<dynamic> get(String url) async {
    url = formatter(url);
    var resp = await http.get(url);

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      log.i(resp.body);
      return json.decode(resp.body);
    }
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.post(url,
        headers: {"Content-type": "application/json"}, body: json.encode(body));

    print(response);
    return response;
  }

  String formatter(url) {
    return baseurl + url;
  }
}
