import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/response/response.dart' as response;
import '../util/app_exception.dart';

abstract class NetworkService {
  String get baseUrl;

  String get apiKey;

  Map<String, Object> get headers;

  void updateHeaders(Map<String, dynamic> data);

  Future<Either<AppException, response.Response>> get(String endPoint,
      {Map<String, dynamic>? queryParams, Options? options});

  Future<Either<AppException, response.Response>> post(String endPoint,
      {Map<String, dynamic>? data, Options? options});

  Future<Either<AppException, response.Response>> postFile(String endPoint,
      {required Map<String, dynamic> data,
      required String filePath,
      Options? options});
}

// ignore: constant_identifier_names
enum NetworkEnv { BASEURL, APIKEY, SIGNALR, SIGNALRKEY }
