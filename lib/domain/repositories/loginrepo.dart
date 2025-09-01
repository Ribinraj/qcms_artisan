import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qcms_artisan/core/urls.dart';
import 'package:qcms_artisan/data/profilemodel.dart';
import 'package:qcms_artisan/data/register_artisan.dart';
import 'package:qcms_artisan/widgets/custom_sharedprefrences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;  

  ApiResponse({
    this.data,
    required this.message,
    required this.error,
    required this.status,
  });
}

class LoginRepo {
  final Dio dio;

  LoginRepo({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.baseUrl,
              //connectTimeout: const Duration(seconds: 30),
              //receiveTimeout: const Duration(seconds: 30),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  ///////////// sendotp/////////////
  Future<ApiResponse<String>> sendotp({required String mobilenumber}) async {
    try {
      log(mobilenumber);

      Response response = await dio.post(
        Endpoints.login,
        data: {"artisanMobile": mobilenumber},
      );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        final artisanId = responseData["data"]["artisanId"].toString();
        // final customerType = responseData["data"]["customerType"].toString();
        return ApiResponse(
          data: artisanId,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  ///////////// registerartisan/////////////
  Future<ApiResponse>registerartisan({required  RegisterArtisanModel artisan}) async {
    try {
   

      Response response = await dio.post(
        Endpoints.registerartisan,
        data: artisan,
      );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
     
        // final customerType = responseData["data"]["customerType"].toString();
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  // ///////////// verifyotp/////////////
  Future<ApiResponse> verifyotp({
    required String otp,
    required String artisanId,
  }) async {
    try {
      Response response = await dio.post(
        Endpoints.verifyotp,
        data: {"artisanId": artisanId, "artisanOtp": otp},
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        preferences.setString('USER_TOKEN', responseData["data"]["token"]);
        log('userToken:${responseData["data"]["token"]}');
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  // //   /////////////resendotp/////////////
  Future<ApiResponse> resendotp({required String artisanId}) async {
    try {
      // final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.resendotp,
        data: {"artisanId": artisanId},
      );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  
  // // ////////////////fetchprofile///////////////////
    Future<ApiResponse<Profilemodel>> fetchprofile() async {
      try {
        final token = await getUserToken();
        log(token);
        Response response = await dio.get(
          Endpoints.fetchprofile,
          options: Options(headers: {'Authorization': token}),
        );
        log("Response received: ${response.statusCode}");
        final responseData = response.data;
        log("Response data: $responseData");
 
        if (!responseData["error"] && responseData["status"] == 200) {
          final user = Profilemodel.fromJson(responseData["data"]);

          return ApiResponse(
            data: user,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData["status"],
          );
        } else {
          return ApiResponse(
            data: null,
            message: responseData['message'] ?? 'Something went wrong',
            error: true,
            status: responseData["status"],
          );
        }
      } on DioException catch (e) {
        debugPrint(e.message);
        log(e.toString());
        return ApiResponse(
          data: null,
          message: 'Network or server error occurred',
          error: true,
          status: 500,
        );
      } catch (e) {
        // Add a general catch block for other exceptions
        log("Unexpected error: $e");
        return ApiResponse(
          data: null,
          message: 'Unexpected error: $e',
          error: true,
          status: 500,
        );
      }
    }

  // //   ///////////////update token/////////////////
  Future<void> updatetoken({required String token}) async {
    try {
      final userToken = await getUserToken();

      Response response = await dio.post(
        Endpoints.settoken,
        options: Options(headers: {'Authorization': userToken}),
        data: { "pushToken": token}
      );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        log("FCM token updated successfully");
      } else {
        log("Failed to update FCM token: ${responseData["message"]}");
      }
    } catch (e) {
      log("Error updating FCM token: $e");
    }
  }
//   /////////////deleteAccount/////////////
  Future<ApiResponse>deleteaccount({required String reason}) async {
    try {
       final token = await getUserToken();
      Response response =
          await dio.post(Endpoints.deleteaccount, 
             options: Options(headers: {'Authorization': token}),data: { "reason":reason});

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  void dispose() {
    dio.close();
  }
}
