import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = 'https://intense-badlands-24863.herokuapp.com/';
  var log = Logger();

  Future<dynamic> get(String url) async {
    url = formatter(url);

    var resp = await http.get(url);
    log.i(resp.body);
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.post(url,
        headers: {"Content-type": "application/json"}, body: json.encode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    }

    log.d(response.body);
    log.d(response.statusCode);
  }

  String formatter(url) {
    return baseurl + url;
  }
}
