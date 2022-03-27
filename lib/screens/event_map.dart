import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';
import 'package:reunionou/data/api_call.dart';

const maxMarkersCount = 5000;

class EventMap extends StatefulWidget {
  EventMap({Key? key}) : super(key: key);
  final latLng = LatLng(51.5, -0.09);

  @override
  _ManyMarkersPageState createState() => _ManyMarkersPageState();
}

class _ManyMarkersPageState extends State<EventMap> {
  List<Marker> allMarkers = [];
  List<ListTile> allMessages = [];
  String libelle = '';

  generateComments() {
    Future.microtask(() {
      for (var element in UserCollection.messages) {
        allMessages.add(
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
          ),
        );
      }
    });
  }

  var buttons = true;
  @override
  void initState() {
    super.initState();
    generateComments();
    WidgetsBinding.instance?.addPostFrameCallback((_) => Future.microtask(() {
          for (var element in UserCollection.marker) {
            allMarkers.add(
              Marker(
                  point: LatLng(double.parse(element['lat']),
                      double.parse(element['long'])),
                  builder: (BuildContext ctx) {
                    return Consumer<UserCollection>(
                      builder: (context, userCollection, child) {
                        return GestureDetector(
                          onTap: () {
                            hideWidget();
                            userCollection
                                .setLibelleLieu(element['libelle_lieu']);
                            userCollection
                                .setlibelleEvent(element['libelle_event']);
                            userCollection.setHoraireEvent(element['horaire']);
                            userCollection.setDateEvent(element['date']);
                            userCollection.setIdEvent(element['id']);
                            ApiCall.getComment(userCollection.id_event)
                                .then((value) {
                              print(value);
                            });
                            print(element['createur_id']);
                            if (element['createur_id'] == UserCollection.id) {
                              buttons = false;
                            } else {
                              buttons = true;
                            }
                            ApiCall.getUser(element['createur_id'])
                                .then((value) {
                              userCollection.setCreateur(value['id'],
                                  value['nom'], value['mail'], value['prenom']);
                            });
                          },
                          child: Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 12.0,
                          ),
                        );
                      },
                    );
                  }),
            );
            print(allMarkers);
          }
          setState(() {});
        }));
  }

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
        appBar: AppBar(title: Text(userCollection.title), leading: Container()),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              Expanded(
                  child: Container(
                      width: double.infinity,
                      height: 300,
                      child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(50.5, -0.09),
                            zoom: 5.0,
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayerOptions(
                              markers: allMarkers,
                            )
                          ]))),
              Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Column(children: <Widget>[
                    !_canShowButton
                        ? const SizedBox.shrink()
                        : Text(
                            "libelle_lieu :" +
                                userCollection.libelleLieu +
                                "\n" +
                                "libelle_event :" +
                                userCollection.libelle_event +
                                "\n" +
                                "horaire :" +
                                userCollection.horaire +
                                "\n" +
                                "date :" +
                                userCollection.date +
                                "\n" +
                                "Créateur(prenom) :" +
                                userCollection.prenom_createur +
                                "\n" +
                                "Créateur(nom) :" +
                                userCollection.nom_createur +
                                "\n" +
                                "Créateur(mail) :" +
                                userCollection.mail_createur,
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                    !_canShowButton
                        ? const SizedBox.shrink()
                        : !buttons
                            ? const SizedBox.shrink()
                            : ElevatedButton(
                                onPressed: () {
                                  ApiCall.getVenir(userCollection.id_event);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                                child: const Text('Je viens'),
                              ),
                    !_canShowButton
                        ? const SizedBox.shrink()
                        : !buttons
                            ? const SizedBox.shrink()
                            : ElevatedButton(
                                onPressed: () {
                                  ApiCall.getVenir(UserCollection.id)
                                      .then((value) {
                                    print(value);
                                  });
                                  ApiCall.getPasVenir(userCollection.id_event);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Text('désolé'),
                              ),
                  ])),
              Container(
                  child: ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/event_create');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                      ),
                      child: const Text('Créer'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profil');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                      ),
                      child: const Text('Profil'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userCollection.logout();
                        Navigator.pushNamed(context, '/authentification');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Deconnexion'),
                            duration:
                                Duration(hours: 0, minutes: 0, seconds: 5),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                      ),
                      child: const Text('Deconnexion'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ApiCall.myEvents();
                        Navigator.pushNamed(context, '/mesEvents');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                      ),
                      child: const Text('Mes events'),
                    ),
                  ]))
            ])),
      );
      ;
    });
  }
}
