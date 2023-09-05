import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Future login(Map<String, dynamic> userBody, BuildContext context) async {}

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    return true;
  }
}
