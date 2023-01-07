// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_ex/constants/constants.dart';
import 'package:weather_app_ex/exceptions/weather_exception.dart';
import 'package:weather_app_ex/models/direact.geocoding.dart';
import 'package:weather_app_ex/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<DireactGecoding> getDireactGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'kApiHost',
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appId': dotenv.env['APPID'],
      },
    );
    try {
      final http.Response response = await await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('요청된 바디에 값이 없습니다 $city');
      }

      final direactGeocoding = DireactGecoding.fromJson(responseBody);
      return direactGeocoding;
    } catch (e) {
      rethrow;
    }
  }
}
