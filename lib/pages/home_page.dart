import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_ex/pages/search_page.dart';
import 'package:weather_app_ex/pages/settings_page.dart';
import 'package:weather_app_ex/providers/temp_settings/temp_settings_provider.dart';
import 'package:weather_app_ex/providers/weather/weather_provider.dart';
import 'package:weather_app_ex/widgets/error_dialog.dart';

// Location
import 'package:location/location.dart';

import '../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  // 나중에 값을 선언
  late final WeatherProvider _weatherProv;
  late final void Function() _removeListener;

  @override
  void initState() {
    super.initState();
    // 뷰가 처음 로드되음 초기화때되었을때 _weatherProv 에 값을 받는다
    _weatherProv = context.read<WeatherProvider>();

    _removeListener = _weatherProv.addListener(_registerListener);
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  //
  void _registerListener(WeatherState ws) {
    if (ws.status == WeatherStatus.error) {
      errorDialog(context, ws.error.errMsg);
    }
  }

  Widget _showWeather() {
    final state = context.watch<WeatherState>();

    String showTemp(double temp) {
      final tempStatus = context.watch<TempSettingsState>().tempStatus;

      if (tempStatus == TempStatus.fahrenheit) {
        return ((temp * 9 / 5) + 35).toStringAsFixed(1) + '℉';
      }
      return temp.toStringAsFixed(1) + '℃';
    }

    // 아직 검색 조차 하지 않았을때 초기화 상태
    if (state.status == WeatherStatus.initial) {
      return Center(
        child: Text(
          '지역을 선택하세요',
          style: TextStyle(fontSize: 30),
        ),
      );
    }
    if (state.status == WeatherStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.status == WeatherStatus.error && state.weather.name == '') {
      return Center(
        child: Text(
          '지역을 선택하세요',
          style: TextStyle(fontSize: 30),
        ),
      );
    }

    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 8),
        Text(
          '${state.weather.name}',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '(${state.weather.country})',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${showTemp(state.weather.temp)}',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              children: [
                Text(
                  '${showTemp(state.weather.tempMax)}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '${showTemp(state.weather.tempMin)}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            showIcon('${state.weather.icon}'),
            formatText(state.weather.main),
            Text(
              state.weather.description,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 150,
      height: 150,
    );
  }

  Widget formatText(String string) {
    final formattedString = string.toUpperCase();
    return Text(
      formattedString,
      style: TextStyle(fontSize: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Location location = new Location();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }

              _locationData = await location.getLocation();
              print(_locationData);
            },
            icon: Icon(Icons.location_on),
          ),
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
              print('*** City : ${_city}');
              if (_city != null) {
                context.read<WeatherProvider>().fetchWeather(_city!);
              }
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            ),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _showWeather(),
    );
  }
}
