// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:reunionou/data/api_call.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final myControllerMail = TextEditingController();
  final myControllerPassword = TextEditingController();

  initState() {
    // getUsers().then((value) {
    //   print(value);
    // });
    // getAuth('jm@g.com', 'test').then((value) {
    //   print(value);
    // });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerMail.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  bool _isSecret = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: unnecessary_const
              RichText(
                text: TextSpan(
                  text: 'Bienvenue sur\n'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'Reunionou\n'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Identifiant',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Entrez votre mail s\'il vous plait",
                      decoration: InputDecoration(
                        hintText: 'Ex: theo.antolini@mail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      controller: myControllerMail,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: _isSecret,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un mot de passe  s\'il vous plait';
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () => setState(() => _isSecret = !_isSecret),
                          child: Icon(!_isSecret
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      controller: myControllerPassword,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ApiCall.getAuth(myControllerMail.text,
                                  myControllerPassword.text)
                              .then((value) {
                            print('ici');
                            print(value);
                            if (value == true) {
                              ApiCall.check();
                              ApiCall.getMarkers().then((value) {
                                Navigator.pushNamed(context, '/event_map');
                              });
                              ApiCall.getUsers().then((value) {
                                UserCollection.users = value;
                                ApiCall.lastConnection().then((value) {
                                  print(value);
                                });
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text('Connexion'),
                                    duration: Duration(
                                        hours: 0, minutes: 0, seconds: 5),
                                  ),
                                );
                              });
                            } else {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed'),
                                  duration: Duration(
                                      hours: 0, minutes: 0, seconds: 5),
                                ),
                              );
                            }
                          });
                        }
                      },
                      child: Text(
                        'continue'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // RaisedButton(
                    //   color: Theme.of(context).primaryColor,
                    //   elevation: 0,
                    //   padding: EdgeInsets.symmetric(vertical: 15.0),
                    //   onPressed: () => launch('http://google.com'),
                    //   child: Text(
                    //     'Créer un compte'.toUpperCase(),
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
