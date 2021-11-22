import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_provider/data/weather_repository.dart';
import 'package:flutter_weatherapp_provider/models/weather.dart';
import 'package:http/http.dart';

import '../locator.dart';

enum WeatherState{InitialWeatherState, WeatherLoadingState, WeatherLoadedState, WeatherErrorState}

class WeatherViewModel with ChangeNotifier{
  WeatherState _state;
  WeatherRepository _repository=locator<WeatherRepository>();
  Weather _getirilenWeather;

  WeatherViewModel(){
    _getirilenWeather = Weather();
    _state = WeatherState.InitialWeatherState;

  }

  Weather get getirilenWeather => _getirilenWeather;

  WeatherState get state => _state;

  set state(WeatherState value) {
    _state = value;
    notifyListeners();
  }

  Future<Weather> havadurumuGetir(String sehirAdi) async{
    try{
      state=WeatherState.WeatherLoadingState;
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state=WeatherState.WeatherLoadedState;
      //hata olabilir
      return _getirilenWeather;
    }catch(e){
      state=WeatherState.WeatherErrorState;
    }
  }
  Future<Weather> havadurumuGuncelle(String sehirAdi) async{
    try{
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state=WeatherState.WeatherLoadedState;
      //hata olabilir
      return _getirilenWeather;
    }catch(e){
    }
  }
  String havaDurumuKisaltmasi(){
    return _getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
  }
}