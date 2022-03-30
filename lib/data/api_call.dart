import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';

class ApiCall {
  static getUsers() async {
    Dio dio = Dio(); // first create object of Dio lib
    final response = await dio.get(
      'http://149.91.80.75:19180/users',
      queryParameters: {"token": UserCollection.token},
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    ); // add path for your get api here.
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('test');
      // If response is success
      var data = response.data; // here data is converted json - Not a String.

      // This is handled by dio package internally so we don't need to handle this manually
      print(data);
      return data;
    } else {
      print('error');
      throw Exception('Error');
    }
  }

  static addComment(id, message) async {
    Dio dio = Dio(); // first create object of Dio lib
    final response = await dio.post(
      'http://149.91.80.75:19180/AddComment/$id',
      queryParameters: {"token": UserCollection.token, "comment": message},
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    ); // add path for your get api here.

    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      return true;
    } else {
      print('error');
      throw Exception('Error');
    }
  }

  static getUsersInvite(id) async {
    //print(id);
    Dio dio = Dio(); // first create object of Dio lib
    final response = await dio.get(
      'http://149.91.80.75:19180/getUsersInvite/$id',
      queryParameters: {"token": UserCollection.token},
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    ); // add path for your get api here.

    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      UserCollection.usersInvite = data['users'];
      return true;
    } else {
      print('error');
      throw Exception('Error');
    }
  }

  static getAuth(email, password) async {
    Dio dio = Dio(); // first create object of Dio lib
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    print(email);
    print(password);
    var response = await Dio().get(
      'http://149.91.80.75:19480/auth',
      options: Options(
        headers: <String, String>{'authorization': basicAuth},
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      //print(data);
      UserCollection.token = data['token'];
      UserCollection.access_token = data['access_token'];
      // print(UserCollection.access_token);
      // UserCollection.id = data['id'];
      // UserCollection.nom = data['nom'];
      // UserCollection.prenom = data['prenom'];
      // UserCollection.token = data['token'];
      // UserCollection.mail = data['mail'];

      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

  static check() async {
    Dio dio = Dio(); // first create object of Dio lib
    print(UserCollection.access_token);
    var response = await Dio().get(
      'http://149.91.80.75:19480/check',
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ' + UserCollection.access_token
        },
      ),
    );

    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      //UserCollection.id = data['id'];
      UserCollection.nom = data['nom'];
      UserCollection.prenom = data['prenom'];
      // UserCollection.token = data['token'];
      UserCollection.mail = data['mail'];
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getMarkers() async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://149.91.80.75:19180/InvitEvents',
      queryParameters: {"token": UserCollection.token},
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
      //print(data);
      if (data['events'] != null) {
        UserCollection.marker = data['events'];
      }

      return true;
    } else {
      return false;
    }
  }

  static getVenir(id) async {
    print('ko');
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().post(
      'http://149.91.80.75:19180/Venir/$id',
      queryParameters: {"token": UserCollection.token},
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
      'http://149.91.80.75:19180/PasVenir/$id',
      queryParameters: {"token": UserCollection.token},
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
    var response = await Dio().post('http://149.91.80.75:19180/postEvent',
        queryParameters: {"token": UserCollection.token},
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
      'http://149.91.80.75:19180/ListComments/$id',
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
        "access_key": "01ba22585ec570b67b6ce941657cade1",
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
      'http://149.91.80.75:19180/updateUser',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
      queryParameters: {
        "token": UserCollection.token,
        "nom": nom,
        "mail": mail,
        "prenom": prenom
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      print(data);
      return true;
    } else {
      //print('erreur');
      return false;
    }
  }

  static participePas(id) async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://149.91.80.75:19180/NeparticipePas/$id',
      queryParameters: {"token": UserCollection.token},
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var participePas =
          response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually

      return participePas;
    } else {
      return false;
    }
  }

  static myEvents() async {
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://149.91.80.75:19180/myEvents',
      queryParameters: {"token": UserCollection.token},
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
      var return_value;
      if (myEvents['count'] == 0) {
        return_value = false;
      } else {
        return_value = myEvents['events'];
      }
      return return_value;
    } else {
      return false;
    }
  }

  static lastConnection() async {
    Dio dio = Dio(); // first create object of Dio lib
    print(UserCollection.token);
    var response = await Dio().post(
      'http://149.91.80.75:19180/lastConnection/',
      queryParameters: {"token": UserCollection.token},
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If response is success
      var myEvent =
          response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      //print(myEvent['users']);
      return true;
    } else {
      return false;
    }
  }

  static myEvent(id) async {
    Dio dio = Dio(); // first create object of Dio lib
    print(id);
    var response = await Dio().get(
      'http://149.91.80.75:19180/event/$id',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var myEvent =
          response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      //print(myEvent['users']);
      return myEvent['users'];
    } else {
      return false;
    }
  }

  static getUser(id) async {
    //print(id);
    Dio dio = Dio(); // first create object of Dio lib
    var response = await Dio().get(
      'http://149.91.80.75:19180/getUser',
      queryParameters: {
        "token": UserCollection.token,
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

  static invitation(id_event, id_user) async {
    Dio dio = Dio(); // first create object of Dio lib
    print(UserCollection.token);
    final response = await dio.post(
      'http://149.91.80.75:19180/invitation/$id_event',
      queryParameters: {"token": UserCollection.token, "id_user": id_user},
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    ); // add path for your get api here.
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('test');
      // If response is success
      var data = response.data; // here data is converted json - Not a String.

      // This is handled by dio package internally so we don't need to handle this manually
      print(data);
      return data;
    } else {
      print('error');
      throw Exception('Error');
    }
  }
}
