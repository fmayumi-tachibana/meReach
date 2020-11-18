import 'package:get_it/get_it.dart';
import 'package:mereach/business_logic/view_models/server_provider.dart';
import 'package:mereach/services/storage/storage_service_implementation.dart';

import 'currency/currency_service.dart';
import 'currency/currency_service_implementation.dart';
import 'storage/storage_service.dart';
import 'web_api/web_api.dart';
import 'web_api/web_api_implementation.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImpl());

  serviceLocator
      .registerLazySingleton<CurrencyService>(() => CurrencyServiceImpl());

  serviceLocator
      .registerLazySingleton<StorageService>(() => StorageServiceImpl());

  serviceLocator.registerFactory<ServerProvider>(() => ServerProvider());
}
