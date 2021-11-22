import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_provider/viewmodel/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class SonGuncellemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherViewModel = Provider.of<WeatherViewModel>(context);

    var yeniTarih =_weatherViewModel.getirilenWeather.time.toLocal();

    return Text(
      "son güncelleme" + TimeOfDay.fromDateTime(yeniTarih).format(context),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}
