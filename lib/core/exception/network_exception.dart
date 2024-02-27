// ignore_for_file: avoid_dynamic_calls

import 'dart:io';
import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return 'Request cancelled';
            case DioErrorType.connectTimeout:
              return 'Connection timed out!';
            case DioErrorType.other:
              return 'Something went wrong here!';
            case DioErrorType.receiveTimeout:
              return 'Request timed out';
            case DioErrorType.response:
              return error.response!.data['message'];

            case DioErrorType.sendTimeout:
              return 'Request timed out';
          }
        } else if (error is SocketException) {
          return 'No internet connection!';
        } else {
          return 'Unexpected error occured';
        }
      } on FormatException {
        return 'Bad response format';
      } catch (_) {
        return 'Unexpected error occured';
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return 'Unexpected error occured';
      } else {
        return 'Unexpected error occured';
      }
    }
  }
}
