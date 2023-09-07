import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:marvel_app/models/user_model.dart';
import 'package:marvel_app/services/api.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Api api = Api();
  String? token;
  late bool authenticated;
  bool isLoading = false;
  UserModel? currentUserModel;
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
    final response = await api.post(
        "https://api.ha-k.ly/api/v1/client/auth/login", userBody);
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      setAuthenticated(true);
      setLoading(false);

      return [true, "loged in"];
    } else {
      setAuthenticated(false);
      setLoading(false);

      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> register(
    Map<String, dynamic> userBody,
  ) async {
    setLoading(true);

    final response = await api.post(
        "https://api.ha-k.ly/api/v1/client/auth/register", userBody);

    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var decodedToken = json.decode(response.body)['token'];
      prefs.setString("token", decodedToken);
      setAuthenticated(true);
      setLoading(false);

      return [true, "loged in"];
    } else {
      setAuthenticated(false);
      setLoading(false);

      return [false, json.decode(response.body)['message']];
    }
  }

  getCurrentUser() async {
    setLoading(true);

    final response = await api.get("https://api.ha-k.ly/api/v1/client/auth/me");

    if (response.statusCode == 200) {
      currentUserModel = UserModel.fromJson(json.decode(response.body)['data']);
    } else {}
    setLoading(false);
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    return true;
  }
}
