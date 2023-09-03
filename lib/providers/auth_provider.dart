import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  late bool authenticated;
  bool isLoading = false;

  setLoading(bool val) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = val;
      notifyListeners();
    });
  }

  setAuthenticated(bool val) {
    Timer(const Duration(milliseconds: 50), () {
      authenticated = val;
      notifyListeners();
    });
  }

  initAuthProvider() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString("token");

    if (token != null) {
      setAuthenticated(true);
    } else {
      setAuthenticated(false);
    }
  }

  Future<bool> login(Map userBody) async {
    setLoading(true);
    if (kDebugMode) {
      print(userBody);
    }
    final response = await http.post(
        Uri.parse("http://172.20.10.9:8000/api/auth/login"),
        headers: {"Accept": "application/json"},
        body: json.encode(userBody));
    //{"email": userBody["email"], "password": userBody["password"]}
    if (response.statusCode == 200) {
      var decodedToken = json.decode(response.body)['access_token'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("token", decodedToken);

      if (kDebugMode) {
        print("LOGED IN");
        print("SATUS CODE${response.statusCode}");

        print("BODY${response.body}");
      }
    } else {
      if (kDebugMode) {
        print("LOGED IN FAILED");
        print("SATUS CODE${response.statusCode}");

        print("BODY${response.body}");
      }
    }

    setLoading(false);

    return true;
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    return true;
  }
}
