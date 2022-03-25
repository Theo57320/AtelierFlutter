import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';

class ApiCall {
  // void getUsers() async {
  //   Dio dio = Dio(); // first create object of Dio lib
  //   final response = await dio.get(
  //       'https://670d-194-214-171-11.ngrok.io/users'); // add path for your get api here.
  //   if (response.statusCode == 200) {
  //     // If response is success
  //     var data = response.data; // here data is converted json - Not a String.

  //     // This is handled by dio package internally so we don't need to handle this manually
  //     print(data);
  //     return data;
  //   } else {
  //     print('error');
  //     throw Exception('Error');
  //   }
  // }
  static getAuth(email, password) async {
    Dio dio = Dio(); // first create object of Dio lib
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    var response = await Dio().get(
      'http://3a95-194-214-171-11.ngrok.io/auth',
      options: Options(
        headers: <String, String>{'authorization': basicAuth},
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      //print(data);
      UserCollection.id = data['id'];
      UserCollection.nom = data['nom'];
      UserCollection.prenom = data['prenom'];
      UserCollection.token = data['token'];
      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

  static getMarkers() async {
    print('ko');
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://3a95-194-214-171-11.ngrok.io/events',
      queryParameters: {
        "token":
            //UserCollection.token
            "4c252d21a886af0c69ca6180f5dcb7994d297a39d70c8b9940879b3a45b3257a"
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      UserCollection.marker = data;
      print(UserCollection.marker);
      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

  static getVenir(id) async {
    print('ko');
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().post(
      'http://3a95-194-214-171-11.ngrok.io/Venir/$id',
      queryParameters: {
        "token":
            //UserCollection.token
            "4c252d21a886af0c69ca6180f5dcb7994d297a39d70c8b9940879b3a45b3257a"
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      print('yo');
      return true;
    } else {
      print('erreur');
      return false;
    }
  }

  static addEvent(titre, date, lat, long, lieu, heure) async {
    print('ko');
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().post(
      'http://3a95-194-214-171-11.ngrok.io//',
      queryParameters: {
        "token":
            //UserCollection.token
            "4c252d21a886af0c69ca6180f5dcb7994d297a39d70c8b9940879b3a45b3257a"
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      print('yo');
      return true;
    } else {
      print('erreur');
      return false;
    }
  }

  static getComment(id) async {
    print('comment');
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://3a95-194-214-171-11.ngrok.io/ListComments/$id',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      UserCollection.messages = data;
      print(data);
      return true;
    } else {
      print('erreur');
      return false;
    }
  }

  static getCoo(adresse) async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://api.positionstack.com/v1/forward',
      queryParameters: {
        "access_key":
            //UserCollection.token
            "01ba22585ec570b67b6ce941657cade1",
        "query": adresse
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      UserCollection.lat = data['data'][0]['latitude'];
      UserCollection.long = data['data'][0]['longitude'];

      return true;
    } else {
      return false;
    }
  }
}
