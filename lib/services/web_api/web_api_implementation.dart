import 'package:http/http.dart' as http;

import 'web_api.dart';

class WebApiImpl implements WebApi {
  final Map<String, String> _headers = {'Accept': 'application/json'};

  @override
  Future<http.Response> fetchStatusServer(String url) async {
    //getting status server from the web
    final http.Response response = await http.get(url, headers: _headers).timeout(Duration(seconds: 10));
    return Future<http.Response>.value(response);
  }
}
