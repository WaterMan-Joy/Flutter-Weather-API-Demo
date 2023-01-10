import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'temp_settings_state.dart';

class TempSettingsProvider with ChangeNotifier {
  TempSettingsState _state = TempSettingsState();
  TempSettingsState get state => _state;

  void toggleTempUnit() {
    _state = _state.copyWith(
      tempStatus: _state.tempStatus == TempStatus.selsius
          ? TempStatus.fahrenheit
          : TempStatus.selsius,
    );
    print('toggle : ${_state.tempStatus}');
    notifyListeners();
  }
}
