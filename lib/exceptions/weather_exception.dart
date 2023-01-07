// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherException implements Exception {
  String message;
  WeatherException([
    this.message = '무언가 잘못 되었습니다',
  ]) {
    message = 'Weather Exception : $message';
  }

  @override
  String toString() {
    return message;
  }
}
