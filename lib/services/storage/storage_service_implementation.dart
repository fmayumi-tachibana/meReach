import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mereach/business_logic/models/server.dart';
import 'package:mereach/services/storage/storage_service.dart';
import 'package:mereach/utils/constants.dart';

class StorageServiceImpl implements StorageService {
  final _baseUrl = '${Constants.BASE_API_URL}/servers';

  @override
  Future<List<Server>> getDbServerData() async {
    final response = await http.get('$_baseUrl.json');
    Map<String, dynamic> data = json.decode(response.body);
    List<Server> _servers = [];
    if (data != null) {
      data.forEach((serverId, serverData) {
        _servers.add(Server(
          id: serverId,
          name: serverData['name'],
          url: serverData['url'],
        ));
      });
    }
    return Future<List<Server>>.value(_servers);
  }

  @override
  Future<http.Response> addDbServerData(Server server) async {
    final response = await http.post(
      '$_baseUrl.json',
      body: json.encode({
        'name': server.name,
        'url': server.url,
      }),
    );

    return response;
  }

  @override
  Future<http.Response> deleteDbServerData(Server server) async {
    final response = await http.delete('$_baseUrl/${server.id}.json');

    return response;
  }
}
