import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  final String errMessage =
      '요청 실패\nstatus code : $statusCode\n이유 : $reasonPhrase';
  return errMessage;
}
