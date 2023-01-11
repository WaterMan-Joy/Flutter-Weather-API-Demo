import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

part 'temp_settings_state.dart';

class TempSettingsProvider extends StateNotifier<TempSettingsState> {
  TempSettingsProvider() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    state = state.copyWith(
      tempStatus: state.tempStatus == TempStatus.selsius
          ? TempStatus.fahrenheit
          : TempStatus.selsius,
    );
    print('toggle : ${state.tempStatus}');
  }
}
