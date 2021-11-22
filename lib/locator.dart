import 'package:flutter_weatherapp_provider/data/weather_repository.dart';
import 'package:flutter_weatherapp_provider/viewmodel/weather_viewmodel.dart';
import 'package:get_it/get_it.dart';

import 'data/weather_api_client.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
  locator.registerFactory(() => WeatherViewModel());
}