// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  factory DireactGecoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];
    return DireactGecoding(
        name: data['name'],
        lat: data['lat'],
        lon: data['lon'],
        country: data['country']);
  }

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  bool get stringify => true;
}
