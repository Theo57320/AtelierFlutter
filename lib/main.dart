import 'package:appliflutter/screens/guest/Auth.dart';
import 'package:appliflutter/screens/guest/Password.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentification',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      // home: PasswordScreen(),
      home: const AuthScreen(),
    );
  }
  

}


