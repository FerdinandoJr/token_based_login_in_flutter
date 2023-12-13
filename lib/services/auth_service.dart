import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String> login(String username, String password) async {

    await Future.delayed(const Duration(seconds: 2)); // Simula uma chamada de rede

    if (username == 'user' && password == 'pass') {
      const token = 'token_de_acesso_simulado';

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("authToken", token);

      return token;
    }

    throw Exception("USER_NOT_FOUND");
  }
}