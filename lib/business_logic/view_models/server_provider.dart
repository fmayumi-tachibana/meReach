import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mereach/business_logic/models/server.dart';
import 'package:mereach/exceptions/http_exception.dart';
import 'package:mereach/services/currency/currency_service.dart';
import 'package:mereach/services/service_locator.dart';

class ServerProvider extends ChangeNotifier {
  final CurrencyService _currencyService = serviceLocator<CurrencyService>();

  List<Server> _servers = [];

  List<Server> get servers => [..._servers];

  Future<void> loadData() async {
    _servers = await _currencyService.getAllWebServers();
    notifyListeners();
    return Future.value();
  }

  Future<void> addServer(Server server) async {
    final response = await _currencyService.addServer(server);
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      _servers.insert(
          0,
          Server(
            id: json.decode(response.body)['name'],
            name: server.name,
            url: server.url,
          ));
      notifyListeners();
      _servers[0] = await _currencyService.getWebServers(_servers[0]);
      print(_servers[0].status);
      notifyListeners();
      return Future.value();
    } else {
      throw HttpException('There was an error adding the server');
    }
  }

  Future<void> deleteServer(Server server) async {
    final response = await _currencyService.deleteServer(server);
    if (response.statusCode >= 200 || response.statusCode <= 299) {
      _servers.remove(server);
      notifyListeners();
      return Future.value();
    } else {
      throw HttpException('There was an error adding the server');
    }
  }
}
