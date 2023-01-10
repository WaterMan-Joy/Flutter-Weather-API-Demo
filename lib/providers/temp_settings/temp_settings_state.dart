// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'temp_settings_provider.dart';

enum TempStatus {
  selsius,
  fahrenheit,
}

class TempSettingsState extends Equatable {
  final TempStatus tempStatus;
  TempSettingsState({
    this.tempStatus = TempStatus.selsius,
  });

  factory TempSettingsState.initial() {
    return TempSettingsState();
  }

  @override
  List<Object> get props => [tempStatus];

  @override
  bool get stringify => true;

  TempSettingsState copyWith({
    TempStatus? tempStatus,
  }) {
    return TempSettingsState(
      tempStatus: tempStatus ?? this.tempStatus,
    );
  }
}
