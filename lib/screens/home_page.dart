import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';
import 'package:reunionou/screens/event_map.dart';

import 'authentification.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
        initialRoute: '/authentification',
      );
    });
  }
}
