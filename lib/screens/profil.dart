import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';
import 'package:reunionou/data/api_call.dart';
import 'package:url_launcher/url_launcher.dart';

const maxMarkersCount = 5000;

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);
  final latLng = LatLng(51.5, -0.09);

  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState extends State<Profil> {
  final myControllerNom = TextEditingController();
  final myControllerPrenom = TextEditingController();
  final myControllerMail = TextEditingController();
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
    myControllerNom.dispose();
    myControllerPrenom.dispose();
    super.dispose();
  }

  bool _isSecret = true;
  final _formKey = GlobalKey<FormState>();

  bool _canShowButton = false;
  void hideWidget() {
    setState(() {
      _canShowButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserCollection>(builder: (context, userCollection, child) {
      return Scaffold(
          appBar: AppBar(title: Text(userCollection.title)),
          body: Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'Gestion de \n'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                          ),
                          children: [
                            TextSpan(
                              text: 'profil\n'.toUpperCase(),
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
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Nom',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
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
                              controller: myControllerPrenom
                                ..text = UserCollection.prenom,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Prenom',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextFormField(
                                decoration: InputDecoration(
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
                                controller: myControllerNom
                                  ..text = UserCollection.nom),
                            SizedBox(height: 10.0),
                            Text(
                              'Mail',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextFormField(
                                decoration: InputDecoration(
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
                                controller: myControllerMail
                                  ..text = UserCollection.mail),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                              ),
                              onPressed: () {
                                ApiCall.updateUser(
                                        myControllerNom.value.text,
                                        myControllerPrenom.value.text,
                                        myControllerMail.value.text)
                                    .then((value) {
                                  print(value);
                                });
                                //Navigator.pushNamed(context, '/event_map');
                                // if (_formKey.currentState!.validate()) {
                                //   ApiCall.getAuth(myControllerMail.text,
                                //           myControllerPassword.text)
                                //       .then((value) {
                                //     print(value);
                                //     if (value == true) {
                                //
                                //       return ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(content: Text('Connexion')),
                                //       );
                                //     } else {
                                //       return ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(content: Text('Failed')),
                                //       );
                                //     }
                                //   });
                                // }
                              },
                              child: Text(
                                'Modifier'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                              ),
                              onPressed: () {
                                ApiCall.getMarkers().then((value) {
                                  print(value);
                                });
                                Navigator.pushNamed(context, '/event_map');
                                // if (_formKey.currentState!.validate()) {
                                //   ApiCall.getAuth(myControllerMail.text,
                                //           myControllerPassword.text)
                                //       .then((value) {
                                //     print(value);
                                //     if (value == true) {
                                //
                                //       return ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(content: Text('Connexion')),
                                //       );
                                //     } else {
                                //       return ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(content: Text('Failed')),
                                //       );
                                //     }
                                //   });
                                // }
                              },
                              child: Text(
                                'Supprimer le compte'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ])),
            // Expanded(
            //   child: ListView(
            //       scrollDirection: Axis.horizontal, children:const<Widget>[]),
            // ),
          ));
      ;
    });
  }
}
