import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<void> saveUserDataToLocalStorage(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
  await prefs.setBool('isLoggedIn', true);
}

Future<Map<String, dynamic>> getUserDataFromLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');
  final isLoggedIn = prefs.getBool('isLoggedIn') ??
      false; // Default value is false if not found
  return {'userId': userId, 'isLoggedIn': isLoggedIn};
}

Future<Map<String, dynamic>?> getUser() async {
  try {
    // Get instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the token from SharedPreferences
    final String? token = prefs.getString('jwt_token');

    // Check if token exists
    if (token == null || token.isEmpty) {
      print('No token found in SharedPreferences');
      return null;
    }

    // Decode the token
    if (JwtDecoder.isExpired(token)) {
      print('Token has expired');
      return null;
    }

    // Get the decoded payload
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Assuming the user information is stored in the 'user' claim
    // Adjust this based on your actual token structure
    print("Then decorded Token : ${decodedToken['doctor']}");
    return decodedToken['doctor'];
    // if (decodedToken.containsKey('user')) {
    // } else {
    //   print('User information not found in token');
    //   return null;
    // }
  } catch (e) {
    print('Error decoding token: $e');
    return null;
  }
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
  await prefs.setBool('isLoggedIn', false);
  await prefs.setBool('showHome', false);
  // await prefs.setBool('isRegisted', false);

  print("User Logged Out");
}
