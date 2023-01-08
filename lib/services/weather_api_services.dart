// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_ex/constants/constants.dart';
import 'package:weather_app_ex/exceptions/weather_exception.dart';
import 'package:weather_app_ex/models/direact.geocoding.dart';
import 'package:weather_app_ex/models/weather.dart';
import 'package:weather_app_ex/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<DireactGecoding> getDireactGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );
    try {
      final http.Response response = await httpClient.get(uri);

      // status code 가 200 이 아니라면
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      // response.body 저장
      final responseBody = json.decode(response.body);

      // responseBody 가 Empty 라면
      if (responseBody.isEmpty) {
        throw WeatherException('요청된 바디에 값이 없습니다 $city');
      }

      final direactGeocoding = DireactGecoding.fromJson(responseBody);
      return direactGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DireactGecoding direactGecoding) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${direactGecoding.lat}',
        'lon': '${direactGecoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );
    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
