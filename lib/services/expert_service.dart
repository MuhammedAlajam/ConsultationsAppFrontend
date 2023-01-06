import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../constant.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import '../screens/loading.dart';

Future<ApiResponse> getExpertProfile(String id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(
      Uri.parse(expertProfile + id),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.token}'
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        apiResponse.error = notFound;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getExperts(String path, String data) async {
  if (data != '') {
    path = path + data;
  }

  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(
      Uri.parse(path),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.token}'
      },
    );

    debugPrint(response.body.toString());

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        apiResponse.error = notFound;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> registerExpert(
    String username,
    String firstName,
    String lastName,
    String country,
    String city,
    String phoneNumber,
    String password,
    String description,
    String hourlyRate,
    String consultationsNames) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(expertRegisterUrl),
      headers: {'Accept': 'application/json'},
      body: {
        'username': username,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'country': country,
        'city': city,
        'phone_number': phoneNumber,
        'wallet': '0',
        'description': description,
        'hourly_rate': hourlyRate,
        'consultationsNames': consultationsNames,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = someThingWentWront;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getAvailabeTimes(String date, String expertId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(
      Uri.parse('$expertAvailableTimes$expertId/$date'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.token}'
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        apiResponse.error = notFound;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> bookTime(String date, String expertId, String hour) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.post(Uri.parse(expertBookTime + expertId), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user?.token}'
    }, body: {
      'date': date,
      'hour': hour,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        apiResponse.error = notFound;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
