import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_ex/providers/providers.dart';
import 'package:weather_app_ex/providers/temp_settings/temp_settings_provider.dart';
import 'package:weather_app_ex/providers/weather/weather_provider.dart';
import 'package:weather_app_ex/repositories/weather_repository.dart';
import 'package:weather_app_ex/services/weather_api_services.dart';

import 'pages/home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: '.env');
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
            weatherApiServices: WeatherApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        StateNotifierProvider<WeatherProvider, WeatherState>(
          create: (context) => WeatherProvider(),
        ),
        StateNotifierProvider<TempSettingsProvider, TempSettingsState>(
          create: (context) => TempSettingsProvider(),
        ),
        StateNotifierProvider<AppThemeProvider, AppThemeState>(
          create: (context) => AppThemeProvider(),
        ),
      ],
      builder: ((context, _) => MaterialApp(
            title: 'Weather app',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(useMaterial3: true),
            theme: context.watch<AppThemeState>().appTheme == AppTheme.light
                ? ThemeData.light()
                : ThemeData.dark(),
            home: HomePage(),
          )),
    );
  }
}
