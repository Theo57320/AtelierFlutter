// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final myControllerMail = TextEditingController();
  final myControllerPassword = TextEditingController();

  getUsers() async {
    Dio dio = Dio(); // first create object of Dio lib
    final response = await dio.get(
        'https://670d-194-214-171-11.ngrok.io/users'); // add path for your get api here.
    if (response.statusCode == 200) {
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

  getAuth(email, password) async {
    Dio dio = Dio(); // first create object of Dio lib
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    var response = await Dio().get(
      'https://feba-194-214-171-11.ngrok.io/auth',
      options: Options(
        headers: <String, String>{'authorization': basicAuth},
      ),
    );
    if (response.statusCode == 200) {
      // If response is success
      var data = response.data; // here data is converted json - Not a String.
      // This is handled by dio package internally so we don't need to handle this manually
      //print(data);

      return true;
    } else if (response.statusCode == 401) {
      return false;
    }
  }

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
                          : "Please enter a valid email",
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
                          return 'Please enter a Password';
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
                          getAuth(myControllerMail.text,
                                  myControllerPassword.text)
                              .then((value) {
                            print(value);
                            if (value == true) {
                              Navigator.pushNamed(context, '/event_map');
                              return ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Connexion')),
                              );
                            } else {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed')),
                              );
                            }
                          });

                          //
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.

                          // getUsers().then((value) {
                          //   if (value[0]) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('Connexion')),
                          //     );

                          //   } else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('failed')),
                          //     );
                          //   }
                          // });
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
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      onPressed: () => launch('http://google.com'),
                      child: Text(
                        'Créer un comte'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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
