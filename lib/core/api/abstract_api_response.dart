import 'package:dio/dio.dart';

class AbstractApiResponse {
  AbstractApiResponse({this.error, this.message, this.data});

  AbstractApiResponse.fromJson(Map<dynamic, dynamic> json) {
    error = json['error'] ?? false;
    message = json['message'] ?? '';
    data = json['data'] ?? [];
  }

  bool? error;
  String? message;
  List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}

class ApiResponseHelper {
  static AbstractApiResponse handleResponse(Response response) {
    return AbstractApiResponse.fromJson(response.data);
  }
}
