import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  Future<List> login(
    Map<String, dynamic> userBody,
  ) async {
    setLoading(true);
    final response = await http.post(
        Uri.parse("https://api.ha-k.ly/api/v1/client/auth/login"),
        body: json.encode(userBody),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print("RESPONSE STATUSCODE : ${response.statusCode}");
        print("RESPONSE BODEY : ${response.body}");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      setAuthenticated(true);
      setLoading(false);

      return [true, "loged in"];
    } else {
      if (kDebugMode) {
        print("RESPONSE STATUSCODE : ${response.statusCode}");
        print("RESPONSE BODEY : ${response.body}");
      }
      setAuthenticated(false);
      setLoading(false);

      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> register(
    Map<String, dynamic> userBody,
  ) async {
    setLoading(true);

    final response = await http.post(
        Uri.parse("https://api.ha-k.ly/api/v1/client/auth/register"),
        body: json.encode(userBody),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print("RESPONSE STATUSCODE : ${response.statusCode}");
        print("RESPONSE BODEY : ${response.body}");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      setAuthenticated(true);
      setLoading(false);

      return [true, "loged in"];
    } else {
      if (kDebugMode) {
        print("RESPONSE STATUSCODE : ${response.statusCode}");
        print("RESPONSE BODEY : ${response.body}");
      }
      setAuthenticated(false);
      setLoading(false);

      return [false, json.decode(response.body)['message']];
    }
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    return true;
  }
}
