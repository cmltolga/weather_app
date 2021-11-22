import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_provider/viewmodel/mytheme_view_model.dart';
import 'package:flutter_weatherapp_provider/viewmodel/weather_viewmodel.dart';
import 'package:flutter_weatherapp_provider/widget/gecisli_arkaplan_renk.dart';
import 'package:flutter_weatherapp_provider/widget/sehir_sec.dart';
import 'package:provider/provider.dart';
import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "";
  WeatherViewModel _weatherViewModel;

  @override
  Widget build(BuildContext context) {
    _weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                kullanicininSectigiSehir =
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => SehirSecWidget()));
                debugPrint("seçilen şehir: " + kullanicininSectigiSehir);
                _weatherViewModel.havadurumuGetir(kullanicininSectigiSehir);
              }),
        ],
      ),
      body: Center(
        child: (_weatherViewModel.state == WeatherState.WeatherLoadedState)
            ? HavaDurumuGeldi()
            : (_weatherViewModel.state == WeatherState.WeatherLoadingState)
                ? havaDurumuGetiriliyor()
                : (_weatherViewModel.state == WeatherState.WeatherErrorState)
                    ? havaDurumuGetirHata()
                    : Text("şehir seçin"),
      ),
    );
  }

  havaDurumuGetiriliyor() {
    return CircularProgressIndicator();
  }

  havaDurumuGetirHata() {
    return Text("hava durumu getirilirken hata oluştu");
  }
}

class HavaDurumuGeldi extends StatefulWidget {
  @override
  _HavaDurumuGeldiState createState() => _HavaDurumuGeldiState();
}

class _HavaDurumuGeldiState extends State<HavaDurumuGeldi> {

  WeatherViewModel _weatherViewModel;
  MyThemeViewModel _myThemeViewModel;
  Completer<void> _refreshIndicator = Completer<void>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshIndicator=Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var kisaltma = Provider.of<WeatherViewModel>(context,listen: false).havaDurumuKisaltmasi();
      Provider.of<MyThemeViewModel>(context,listen: false).temaDegistir(kisaltma);
    });
  }


  @override
  Widget build(BuildContext context) {
    _refreshIndicator.complete();
    _refreshIndicator=Completer<void>();
    _weatherViewModel=Provider.of<WeatherViewModel>(context,listen: false);
    _myThemeViewModel=Provider.of<MyThemeViewModel>(context);
    String kullanicininSectigiSehir = _weatherViewModel.getirilenWeather.title;
    return GecisliRenkContainer(
      renk: Provider.of<MyThemeViewModel>(context).myTheme.renk,
      child: RefreshIndicator(
        onRefresh: (){
          _weatherViewModel.havadurumuGuncelle(kullanicininSectigiSehir);
          return _refreshIndicator.future;
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: LocationWidget(
                    secilenSehir: kullanicininSectigiSehir,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: SonGuncellemeWidget()),//parametsiz kullanım
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: HavaDurumuResimWidget()),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: MaxveMinSicaklikWidget(_weatherViewModel.getirilenWeather.consolidatedWeather[0])),//getirilen hava durumunu parametre olarak gönderiyoruz
            ),
          ],
        ),
      ),
    );
  }
}

