import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './.env.dart';
import './loginmodel.dart';
import '../service/general.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(User user) async {
    final dio = Dio();
    try {
      final newuser = user;
      print("User Passed Data: ${newuser.email}  ${newuser.password}");
      final response = await dio.post(
        "$APIURL/user/login",
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          'email': user.email,
          'password': user.password,
        },
      );

      print('Response: $response');

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final userId = response.data['user']['id'];
        await saveUserDataToLocalStorage(userId);

        prefs.setBool('showHome', true);
        prefs.setString('jwt_token', '${response.data['token']}');
        print("User Token ${response.data['token']}");

        return {
          'success': true,
          'message': 'Welcome Back !!!',
          'token': response.data['token'],
        };
      }
      if (response.statusCode == 400) {
        print("Invalid response ${response.statusCode}: ${response.data}");
        return {
          'success': false,
          'message': response.data['message'],
        };
      }
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    } catch (e) {
      print("Error occurred: $e");
      return {
        'success': false,
        'message': 'Login Failed. Please try again',
      };
    }
  }
}
