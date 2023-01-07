// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DireactGecoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  DireactGecoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  // factory DireactGecoding.fromJson(List<dynamic> json) {
  //   final Map<String, dynamic> data = json[0];
  //   return DireactGecoding(
  //       name: data['name'],
  //       lat: data['lat'],
  //       lon: data['lon'],
  //       country: data['country']);
  // }

  @override
  List<Object> get props => [name, lat, lon, country];

  // DireactGecoding copyWith({
  //   String? name,
  //   double? lat,
  //   double? lon,
  //   String? country,
  // }) {
  //   return DireactGecoding(
  //     name: name ?? this.name,
  //     lat: lat ?? this.lat,
  //     lon: lon ?? this.lon,
  //     country: country ?? this.country,
  //   );
  // }

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
    };
  }

  factory DireactGecoding.fromMap(Map<String, dynamic> map) {
    return DireactGecoding(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DireactGecoding.fromJson(String source) {
    return DireactGecoding.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
