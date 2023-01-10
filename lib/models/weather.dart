// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String main;
  final String description;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final DateTime lastUpdated;
  final double windSpeed;
  Weather({
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.lastUpdated,
    required this.windSpeed,
  });

  @override
  List<Object> get props {
    return [
      main,
      description,
      name,
      icon,
      temp,
      tempMin,
      tempMax,
      country,
      lastUpdated,
      windSpeed,
    ];
  }

  @override
  bool get stringify => true;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];

    return Weather(
      main: weather['main'],
      description: weather['description'],
      icon: weather['icon'],
      temp: main['temp'],
      tempMin: main['temp_min'],
      tempMax: main['temp_max'],
      name: '',
      country: '',
      lastUpdated: DateTime.now(),
      windSpeed: wind['speed'],
    );
  }

  factory Weather.initial() => Weather(
        main: '',
        description: '',
        icon: '',
        temp: 100.0,
        tempMin: 100.0,
        tempMax: 100.0,
        name: '',
        country: '',
        lastUpdated: DateTime(1970),
        windSpeed: 0,
      );

  Weather copyWith({
    String? main,
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lastUpdated,
    double? windSpeed,
  }) {
    return Weather(
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      windSpeed: windSpeed ?? this.windSpeed,
    );
  }
}
