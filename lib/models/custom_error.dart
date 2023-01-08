// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errMsg;
  CustomError({
    this.errMsg = '',
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [errMsg];

  String toString() => 'CustomError : $errMsg';
}
