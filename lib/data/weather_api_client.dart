import 'dart:convert';
import 'package:flutter_weatherapp_provider/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient{

  static const baseUrl = "https://www.metaweather.com";
  final http.Client httpClient = http.Client();

  Future<int> getLocationID(String sehirAdi) async{
    final sehirUrl = baseUrl+"/api/location/search/?query="+sehirAdi;
    final gelenCevap = await httpClient.get(sehirUrl);

    if(gelenCevap.statusCode !=200){
      throw Exception("veri getirilemedi");
    }

    final gelenCevapJSON = (jsonDecode(gelenCevap.body)) as List;
    return gelenCevapJSON[0]["woeid"];
  }

  Future<Weather> getWeather(int sehirID) async{
    final havaDurumUrl = baseUrl+"/api/location/$sehirID";
    final havaDurumuGelenCevap = await httpClient.get(havaDurumUrl);
    if(havaDurumuGelenCevap.statusCode != 200){
      throw Exception("hava durumu getirilemedi");
    }
    final havaDurumuCevapJSON = jsonDecode(havaDurumuGelenCevap.body);
    return Weather.fromJson(havaDurumuCevapJSON);
  }
}