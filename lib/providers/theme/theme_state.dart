// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theme_provider.dart';

enum AppTheme {
  light,
  dark,
}

class AppThemeState extends Equatable {
  final AppTheme appTheme;
  AppThemeState({
    this.appTheme = AppTheme.light,
  });

  factory AppThemeState.initial() {
    return AppThemeState();
  }

  @override
  List<Object> get props => [appTheme];

  @override
  bool get stringify => true;

  AppThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return AppThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
