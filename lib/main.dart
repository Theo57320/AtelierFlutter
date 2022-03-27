import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';
import 'package:reunionou/models/user.dart';
import 'package:reunionou/screens/authentification.dart';

import 'package:http/http.dart' as http;
import 'package:reunionou/screens/mes_events.dart';
import 'package:reunionou/screens/profil.dart';

import 'screens/event_create.dart';
import 'screens/event_map.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserCollection(),
      child: const MyApp(),
    ),
  );
}

// import 'dart:convert';
// import 'package:flutter/material.dart';

// import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<UserCollection>(builder: (context, userCollection, child) {
      return MaterialApp(
        title: userCollection.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/event_map': (context) => EventMap(),
          '/authentification': (context) => AuthScreen(),
          '/event_create': (context) => EventCreate(),
          '/profil': (context) => Profil(),
          //'/mesEvents': (context) => MesEvents(),
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
        initialRoute: '/authentification',
      );
    });
  }
}
