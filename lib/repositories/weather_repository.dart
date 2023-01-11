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
      final DireactGecoding directGeocoding =
          await weatherApiServices.getDireactGeocoding(city);
      print('directGeocoding: $directGeocoding');

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
