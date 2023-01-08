// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app_ex/exceptions/weather_exception.dart';
import 'package:weather_app_ex/models/custom_error.dart';
import 'package:weather_app_ex/models/direact.geocoding.dart';
import 'package:weather_app_ex/models/weather.dart';
import 'package:weather_app_ex/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });
  Future<Weather> fetchWeather(String city) async {
    try {
      final DireactGecoding direactGecoding =
          await weatherApiServices.getDireactGeocoding(city);
      print('***direact geoconding : $direactGecoding');

      final Weather tempWeather =
          await weatherApiServices.getWeather(direactGecoding);
      print('***temp weather : $tempWeather');

      final Weather weather = tempWeather.copyWith(
          name: direactGecoding.name, country: direactGecoding.country);
      print('*** weater : $weather');
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}