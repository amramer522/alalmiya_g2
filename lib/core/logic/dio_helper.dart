import 'package:dio/dio.dart';

import 'helper_methods.dart';

class DioHelper {
  Dio _dio = Dio(
    BaseOptions(baseUrl: "https://thimar.amr.aait-d.com/api/"),
  );

  Future<CustomResponse> sendData(String endPoint, {Map<String, dynamic>? data}) async {
    print("(POST) https://thimar.amr.aait-d.com/api/$endPoint");
    print("Data: $data");
    try {
      final response = await _dio.post(
        endPoint,
        data: data,
      );
      print(response.data);
      // print(response.statusCode);
      return CustomResponse(isSuccess: true, message: response.data["message"], response: response);
    } on DioException catch (ex) {
      return CustomResponse(message: ex.response?.data["message"], isSuccess: false, response: ex.response);
    }
  }

  Future<CustomResponse> getData(String endPoint, {Map<String, dynamic>? data})async {
    print("(POST) https://thimar.amr.aait-d.com/api/$endPoint");
    print("Data: $data");
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: data,
      );
      print(response.data);
      return CustomResponse(isSuccess: true, message: response.data["message"], response: response);
    } on DioException catch (ex) {
      return CustomResponse(message: ex.response?.data["message"], isSuccess: false, response: ex.response);
    }
  }
}

class CustomResponse {
  late final String message;
  late final bool isSuccess;
  late final Response? response;

  CustomResponse({required this.message, required this.isSuccess, this.response});
}
