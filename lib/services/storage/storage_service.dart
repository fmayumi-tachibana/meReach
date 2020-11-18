import 'package:mereach/business_logic/models/server.dart';
import 'package:http/http.dart' as http;

abstract class StorageService {
  Future<List<Server>> getDbServerData();

  Future<http.Response> addDbServerData(Server server);

  Future<http.Response> deleteDbServerData(Server server);
}
