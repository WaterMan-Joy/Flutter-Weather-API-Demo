// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:weather_app_ex/providers/providers.dart';

import '../../constants/constants.dart';

part 'theme_state.dart';

class AppThemeProvider extends StateNotifier<AppThemeState> with LocatorMixin {
  AppThemeProvider() : super(AppThemeState.initial());

  @override
  void update(Locator watch) {
    final wp = watch<WeatherState>().weather;
    if (wp.temp > kWarmOrNot) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }
    super.update(watch);
  }
}
