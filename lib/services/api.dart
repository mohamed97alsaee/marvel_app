import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Response> post(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.post(Uri.parse(url), body: json.encode(body), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString("token")}"
    });

    if (kDebugMode) {
      print("RESPONSE STATUSCODE : ${response.statusCode}");
      print("RESPONSE BODEY : ${response.body}");
    }

    return response;
  }

  Future<Response> get(
    String url,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString("token")}"
    });

    if (kDebugMode) {
      print("RESPONSE STATUSCODE : ${response.statusCode}");
      print("RESPONSE BODEY : ${response.body}");
    }

    return response;
  }
}

Future<Response> put(String url, Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response =
      await http.put(Uri.parse(url), body: json.encode(body), headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    "Authorization": "Bearer ${prefs.getString("token")}"
  });

  if (kDebugMode) {
    print("RESPONSE STATUSCODE : ${response.statusCode}");
    print("RESPONSE BODEY : ${response.body}");
  }

  return response;
}

Future<Response> delete(String url, Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response =
      await http.delete(Uri.parse(url), body: json.encode(body), headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    "Authorization": "Bearer ${prefs.getString("token")}"
  });

  if (kDebugMode) {
    print("RESPONSE STATUSCODE : ${response.statusCode}");
    print("RESPONSE BODEY : ${response.body}");
  }

  return response;
}
