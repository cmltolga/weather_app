import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_provider/viewmodel/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class HavaDurumuResimWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherViewModel = Provider.of<WeatherViewModel>(context);
    var havaDurumuKisaltmasi = _weatherViewModel.getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
    return Column(
      children: [
        Text(
          _weatherViewModel.getirilenWeather.consolidatedWeather[0].theTemp.floor().toString()+"°C",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Image.network(
          "https://www.metaweather.com/static/img/weather/png/"+havaDurumuKisaltmasi+".png",
          width: 150,
          height: 150,
        ),
      ],
    );
  }
}
