import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reunionou/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser(http.Client client) async {
  var _authUri = 'http://docketu.iutnc.univ-lorraine.fr:62360/auth';
  String basicAuth ='Basic ' + base64Encode(utf8.encode('$email:$password'));
  var response = await Dio().get(
    _authUri,
    options: Options(
      headers: <String, String>{'authorization': basicAuth}
    ),
  );
  print(response.statusCode);
  return compute(parseUser, response.data.toString());
}

List<User> parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
