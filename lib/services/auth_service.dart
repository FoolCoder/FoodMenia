import 'package:flutter_practice_app/modals/user.dart';
import 'package:flutter_practice_app/services/http_services.dart';

class AuthService {
  static final AuthService _singelton = AuthService._internal();
  final _httpService = HTTPService();
  User? user;
  factory AuthService() {
    return _singelton;
  }
  AuthService._internal();
  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService
          .post('auth/login', {"username": username, 'password': password});
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response?.data);
        HTTPService().setup(token: user?.token);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
