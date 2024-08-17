
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../.env.dart';

class ApiService {
  static Future<Map<String, dynamic>> getData(String endpoint) async {
    final dio = Dio();
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      final response = await dio.get(
        "$APIURL$endpoint",
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch data',
        };
      }
    } catch (e) {
      print("Error occurred: $e");
      return {
        'success': false,
        'message': 'An error occurred while fetching data',
      };
    }
  }
}