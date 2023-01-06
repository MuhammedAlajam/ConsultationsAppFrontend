import 'dart:convert';
import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:consultations/screens/loading.dart';
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
        'username': username,
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
    String phoneNumber,
    String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(userRegisterUrl),
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

Future<ApiResponse> getUserBookedTimes() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse(userBookedTimes),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.token}',
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

Future<ApiResponse> flipFavorite(String expertId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.put(Uri.parse(flipFavUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user?.token}',
    }, body: {
      'fav_id': expertId
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

Future<ApiResponse> rateExpert(String expertId, String newRate) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.put(
      Uri.parse(rateExpertUrl + expertId),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.token}',
      },
      body: {'new_rate': newRate},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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
