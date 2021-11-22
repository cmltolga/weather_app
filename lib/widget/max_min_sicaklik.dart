import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_provider/models/weather.dart';

class MaxveMinSicaklikWidget extends StatelessWidget {

  ConsolidatedWeather bugununDegerleri;

  MaxveMinSicaklikWidget(this.bugununDegerleri);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("maksimum: "+bugununDegerleri.maxTemp.floor().toString()+"°C",style: TextStyle(fontSize: 20),),
        Text("minimum: "+bugununDegerleri.minTemp.floor().toString()+"°C",style: TextStyle(fontSize: 20),),
      ],
    );
  }
}
