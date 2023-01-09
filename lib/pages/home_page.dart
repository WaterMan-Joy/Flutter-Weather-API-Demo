import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_ex/providers/weather/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 테스트 코드
  @override
  void initState() {
    print('home page init state');
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() {
    // 뷰가 순차적으로 로드될 수 있도록
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeather('seoul');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
