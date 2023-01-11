// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:weather_app_ex/providers/providers.dart';

import '../../constants/constants.dart';

part 'theme_state.dart';

class AppThemeProvider {
  final WeatherProvider wp;
  AppThemeProvider({
    required this.wp,
  });

  AppThemeState get state {
    if (wp.state.weather.temp > kWarmOrNot) {
      print(wp.state.weather.lastUpdated.hour);
      return AppThemeState();
    } else {
      print(wp.state.weather.lastUpdated.hour);
      return AppThemeState(appTheme: AppTheme.dark);
    }

    // if (wp.state.weather.lastUpdated.hour < 13) {
    //   print(wp.state.weather.lastUpdated.hour);
    //   return AppThemeState();
    // } else {
    //   print(wp.state.weather.lastUpdated.hour);
    //   return AppThemeState(appTheme: AppTheme.dark);
    // }
  }
}
