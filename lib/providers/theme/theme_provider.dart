import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_ex/providers/providers.dart';

import '../../constants/constants.dart';

part 'theme_state.dart';

class AppThemeProvider with ChangeNotifier {
  AppThemeState _state = AppThemeState.initial();
  AppThemeState get state => _state;

  void update(WeatherProvider wp) {
    if (wp.state.weather.temp > kWarmOrNot) {
      _state = _state.copyWith(appTheme: AppTheme.light);
    } else {
      _state = _state.copyWith(appTheme: AppTheme.dark);
    }
    notifyListeners();
  }
}
