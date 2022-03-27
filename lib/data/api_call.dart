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
      'http://8a35-109-190-253-15.ngrok.io/auth',
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
      UserCollection.mail = data['mail'];
      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

  static getMarkers() async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://8a35-109-190-253-15.ngrok.io/InvitEvents',
      queryParameters: {
        "token":
            //UserCollection.token
            "5c96aaadc86a534f118fb38227e6e6ad210dbc7d057d250e52f1fbec40e1d4ee"
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
      print(data['events']);
      UserCollection.marker = data['events'];

      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

  static getVenir(id) async {
    print('ko');
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().post(
      'http://8a35-109-190-253-15.ngrok.io/Venir/$id',
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

  static getPasVenir(id) async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().post(
      'http://8a35-109-190-253-15.ngrok.io/PasVenir/$id',
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

  static addEvent(titre, date, double lat, double long, lieu, horaire) async {
    print('addEvent');
    date = date.toString().split(" ");
    print(date[0]);
    var response =
        await Dio().post('http://8a35-109-190-253-15.ngrok.io/postEvent',
            queryParameters: {
              "token":
                  //UserCollection.token
                  "5c96aaadc86a534f118fb38227e6e6ad210dbc7d057d250e52f1fbec40e1d4ee"
            },
            data: jsonEncode(
              {
                "lat": lat,
                "long": long,
                "libelle_event": titre,
                "libelle_lieu": lieu,
                "horaire": horaire,
                "date": date[0]
              },
            ));
    if (response.statusCode == 201) {
      print('true');
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
      'http://8a35-109-190-253-15.ngrok.io/ListComments/$id',
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
      print(UserCollection.lat);
      return true;
    } else {
      return false;
    }
  }

  static updateUser(nom, prenom, mail) async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().post(
      'http://8a35-109-190-253-15.ngrok.io/updateUser',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
      queryParameters: {
        "token":
            //UserCollection.token
            "4c252d21a886af0c69ca6180f5dcb7994d297a39d70c8b9940879b3a45b3257a",
        "nom": nom,
        "mail": mail,
        "prenom": prenom
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      print(data);
      return true;
    } else {
      print('erreur');
      return false;
    }
  }

  static myEvents() async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://8a35-109-190-253-15.ngrok.io/AllMyEvents',
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
      var myEvents =
          response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      print(myEvents['events']);
      UserCollection.marker = myEvents['events'];

      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

  static getUser(id) async {
    print(id);
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://8a35-109-190-253-15.ngrok.io/getUser',
      queryParameters: {
        "token":
            //UserCollection.token
            "4c252d21a886af0c69ca6180f5dcb7994d297a39d70c8b9940879b3a45b3257a",
        "id": id,
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

      return data;
    } else if (response.statusCode == 401) {
      return false;
    }
  }
}
