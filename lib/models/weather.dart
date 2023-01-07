// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String name;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String country;
  final DateTime lastUpdated;
  Weather({
    required this.name,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.country,
    required this.lastUpdated,
  });

  @override
  List<Object> get props {
    return [
      name,
      icon,
      temp,
      tempMin,
      tempMax,
      country,
      lastUpdated,
    ];
  }

  @override
  bool get stringify => true;

  Weather copyWith({
    String? name,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? country,
    DateTime? lastUpdated,
  }) {
    return Weather(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon,
      'temp': temp,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'country': country,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      name: map['name'] as String,
      icon: map['icon'] as String,
      temp: map['temp'] as double,
      tempMin: map['tempMin'] as double,
      tempMax: map['tempMax'] as double,
      country: map['country'] as String,
      lastUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'] as int),
    );
  }
  factory Weather.initial() {
    return Weather(
        name: '',
        icon: '',
        temp: 100,
        tempMin: 100,
        tempMax: 100,
        country: '',
        lastUpdated: DateTime(1970));
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);
}
