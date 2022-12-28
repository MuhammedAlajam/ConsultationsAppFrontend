import 'dart:convert';

import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:http/http.dart' as http;

import '../screens/loading.dart';

Future<ApiResponse> getConsultations() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse(consultationsUrl),
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
