import 'package:mereach/business_logic/models/server.dart';
import 'package:mereach/services/storage/storage_service.dart';
import 'package:mereach/services/web_api/web_api.dart';
import 'package:http/http.dart' as http;
import '../service_locator.dart';
import 'currency_service.dart';

class CurrencyServiceImpl implements CurrencyService {
  WebApi _webApi = serviceLocator<WebApi>();
  StorageService _storageService = serviceLocator<StorageService>();

  @override
  Future<List<Server>> getAllWebServers() async {
    final _servers = await _storageService.getDbServerData();
    List<Server> _result = [];
    for (int i = 0; i < _servers.length; i++) {
      _result.add(await getWebServers(_servers[i]));
    }
    return _result;
  }

  @override
  Future<Server> getWebServers(Server server) async {
    try {
      final http.Response response = await _webApi
          .fetchStatusServer(server.url);
      if (response.statusCode < 200 || response.statusCode < 299) {
        if (response.headers['last-modified'] == null) {
          server.lastUpdate = 'Unknown';
        } else {
          server.lastUpdate = response.headers['last-modified'].toString();
        }
        server.status = 'Online';
      } else {
        server.lastUpdate = 'Unknown';
        server.status = 'Offline';
      }
    } catch (e) {
      server.lastUpdate = 'Unknown';
      server.status = 'Offline';
    }
    return server;
  }

  @override
  Future<http.Response> addServer(Server server) async {
    final _response = await _storageService.addDbServerData(server);

    return _response;
  }

  @override
  Future<http.Response> deleteServer(Server server) async {
    final _response = await _storageService.deleteDbServerData(server);

    return _response;
  }
}
