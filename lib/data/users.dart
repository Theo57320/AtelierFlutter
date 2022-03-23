import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reunionou/models/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUser(http.Client client) async {
  var _authUri = 'http://docketu.iutnc.univ-lorraine.fr:62360/users';

  var response = await Dio().get(
    _authUri,
    options: Options(
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer 2a17020d2ec1739c843daa114ce928accc74f86192b3d604560026a2a6d62c37',
      },
    ),
  );
  print(response.statusCode);
  return compute(parseUser, response.data.toString());
}

List<User> parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
