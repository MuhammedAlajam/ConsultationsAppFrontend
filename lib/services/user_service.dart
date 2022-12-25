import 'dart:convert';
import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// login
Future<ApiResponse> loginUser(String username, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(userLoginUrl),
      headers: {'Accept': 'application/json'},
      body: {
        'name': username,
        'password': password,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

// register
Future<ApiResponse> registerUser(
    String username,
    String firstName,
    String lastName,
    String country,
    String city,
    String profilePhoto,
    String phoneNumber,
    String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(userRegisterUrl),
      headers: {'Accept': 'application/json'},
      body: {
        'name': username,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'country': country,
        'city': city,
        'profile_photo': profilePhoto,
        'phone_number': phoneNumber,
        'wallet': '0',
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

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

Future<String> getUserDataFromMemory() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('userInfo') ?? '';
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('userInfo');
}
