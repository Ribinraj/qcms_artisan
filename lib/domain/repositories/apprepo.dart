import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:qcms_artisan/core/urls.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/data/dashboard_model.dart';
import 'package:qcms_artisan/widgets/custom_sharedprefrences.dart';

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

class Apprepo {
  final Dio dio;

  Apprepo({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.baseUrl,
              // connectTimeout: const Duration(seconds: 30),
              // receiveTimeout: const Duration(seconds: 30),
              headers: {'Content-Type': 'application/json'},
            ),
          );


  ////////////////////fetch dashboard/////////////////////

  Future<ApiResponse<DashboardModel>> fetchdashboard() async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.post(
        Endpoints.fetchDashboard,
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final dasbord = DashboardModel.fromJson(responseData['data']);

        return ApiResponse(
          data: dasbord,
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
    ///////////// Complaint list model/////////////
  Future<ApiResponse<List<ComplaintModel>>> opencomplaintlists() async {
    try {
      final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchopnecomplaints,
     
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> complaintlists = responseData['data'];
        List<ComplaintModel> opencomplaints = complaintlists
            .map((category) => ComplaintModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: opencomplaints,
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
      /////////////solved Complaint list model/////////////
  Future<ApiResponse<List<ComplaintModel>>> solvedcomplaintlists() async {
    try {
      final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchsolvedcomplaints,
     
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> complaintlists = responseData['data'];
        List<ComplaintModel> solvedcomplaints = complaintlists
            .map((category) => ComplaintModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: solvedcomplaints,
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
  //////////////cancel complaint/////////////
  // Future<ApiResponse> cancelcomplaint({required String complaintId}) async {
  //   try {
  //     final token = await getUserToken();
  //     Response response =
  //         await dio.post(Endpoints.cancelcomplaint, data: {"complaintId":complaintId},options:Options(headers: {'Authorization': token}));

  //     final responseData = response.data;
  //     if (!responseData["error"] && responseData["status"] == 200) {
  //       return ApiResponse(
  //         data: null,
  //         message: responseData['message'] ?? 'Success',
  //         error: false,
  //         status: responseData["status"],
  //       );
  //     } else {
  //       return ApiResponse(
  //         data: null,
  //         message: responseData['message'] ?? 'Something went wrong',
  //         error: true,
  //         status: responseData["status"],
  //       );
  //     }
  //   } on DioException catch (e) {
  //     debugPrint(e.message);
  //     log(e.toString());
  //     return ApiResponse(
  //       data: null,
  //       message: 'Network or server error occurred',
  //       error: true,
  //       status: 500,
  //     );
  //   }
  // }
  ////////////////notifications////////////////////
  //   Future<ApiResponse<List<NotificationModel>>> fetchnotifications() async {
  //   try {
  //     final token = await getUserToken();

  //     log(token.toString());
  //     Response response = await dio.get(
  //       Endpoints.notifications,
  //       options: Options(headers: {'Authorization': token}),
  //     );

  //     final responseData = response.data;
  //     log('message:${responseData["status"].toString()}');
  //     if (!responseData["error"] && responseData["status"] == 200) {
  //       log(responseData['status'].toString());
  //       final List<dynamic> notificationlist = responseData['data'];
  //       List<NotificationModel> notification = notificationlist
  //           .map((notification) => NotificationModel.fromJson(notification))
  //           .toList();
  //       return ApiResponse(
  //         data: notification,
  //         message: responseData['message'] ?? 'Success',
  //         error: false,
  //         status: responseData["status"],
  //       );
  //     } else {
  //       return ApiResponse(
  //         data: null,
  //         message: responseData['message'] ?? 'Something went wrong',
  //         error: true,
  //         status: responseData["status"],
  //       );
  //     }
  //   } on DioException catch (e) {
  //     debugPrint(e.message);
  //     log(e.toString());
  //     return ApiResponse(
  //       data: null,
  //       message: 'Network or server error occurred',
  //       error: true,
  //       status: 500,
  //     );
  //   }
  // }

}
