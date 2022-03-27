// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:reunionou/data/api_call.dart';

class EventCreate extends StatefulWidget {
  const EventCreate({Key? key}) : super(key: key);

  @override
  _EventCreateState createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final myControllerTitreEvent = TextEditingController();
  final myControllerDescription = TextEditingController();
  final myControllerDate = TextEditingController();
  final myControllerHeure = TextEditingController();
  final myControllerLieu = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerDescription.dispose();
    myControllerHeure.dispose();
    myControllerDate.dispose();
    myControllerTitreEvent.dispose();
    myControllerLieu.dispose();
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
                  text: 'Création d\'un événement\n'.toUpperCase(),
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
                      'Titre',
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
                          : "Please enter a valid titre",
                      decoration: InputDecoration(
                        hintText: 'Ex: Anniversaire',
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
                      controller: myControllerTitreEvent,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Description';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
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
                      controller: myControllerDescription,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CalendarDatePicker(
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2030, 12, 12),
                      initialDate: selectedDate,
                      onDateChanged: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a time';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Heure',
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
                      controller: myControllerHeure,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an adresse';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Lieu',
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
                      controller: myControllerLieu,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      onPressed: () {
                        ApiCall.getCoo(myControllerLieu).then((value) {
                          if (value == true) {
                            ApiCall.addEvent(
                                    myControllerTitreEvent.value.text,
                                    selectedDate,
                                    UserCollection.lat,
                                    UserCollection.long,
                                    myControllerLieu.value.text,
                                    myControllerHeure.value.text)
                                .then((value) {
                              print(value);
                              if (value == true) {
                                Navigator.pushNamed(context, '/event_map');
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text('Created: Success')),
                                );
                              } else {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Created: Error try again and verify your values')),
                                );
                              }
                            });
                          } else {
                            print('erreur adresse invalide');
                          }
                          ;
                        });
                        ;
                      },
                      child: Text(
                        'creer'.toUpperCase(),
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/event_map'),
                      //http://api.positionstack.com/v1/forward?access_key=01ba22585ec570b67b6ce941657cade1&query=1600 Pennsylvania Ave NW, Washington DC
                      child: Text(
                        'annuler'.toUpperCase(),
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
