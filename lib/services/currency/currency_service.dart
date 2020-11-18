import 'package:mereach/business_logic/models/server.dart';
import 'package:http/http.dart' as http;

abstract class CurrencyService {
  Future<List<Server>> getAllWebServers();

  Future<Server> getWebServers(Server server);

  Future<http.Response> addServer(Server server);

  Future<http.Response> deleteServer(Server server);
}
