import 'package:http/http.dart' as http;

abstract class WebApi {
  Future<http.Response> fetchStatusServer(String url);
}
