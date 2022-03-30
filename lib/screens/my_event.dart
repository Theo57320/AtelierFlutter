import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/api_call.dart';
import 'package:reunionou/data/users_collection.dart';

class MyEvent extends StatelessWidget {
  MyEvent({Key? key}) : super(key: key);

//   @override
//   _ManyMarkersPageState createState() => _ManyMarkersPageState();
// }

// class _ManyMarkersPageState extends State<MyEvent> {
  var hideOrNot;
  var text;
//   @override
  @override
  Widget build(BuildContext context) {
    return Consumer<UserCollection>(builder: (context, userCollection, child) {
      var event = userCollection.selectedEvent;

      return Scaffold(
          appBar: AppBar(title: const Text('Mon event'), leading: Container()),
          body: Column(
            children: [
              Text('Détails events: '),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Consumer<UserCollection>(
                        builder: (context, userCollection, child) {
                      var color;

                      if (UserCollection.myEvents.length > 1) {
                        return ListTile(
                          title: Text(event['libelle_lieu'] +
                              "\n" +
                              event['libelle_event'] +
                              "\n" +
                              event['horaire'] +
                              "\n" +
                              event['date']),
                        );
                      } else {
                        return ListTile(
                          title: Text(event[index]['libelle_lieu'] +
                              "\n" +
                              event[index]['libelle_event'] +
                              "\n" +
                              event[index]['horaire'] +
                              "\n" +
                              event[index]['date']),
                        );
                      }
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
              Text('Utilisateur'),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  itemCount: UserCollection.users.length,
                  itemBuilder: (context, index) {
                    return Consumer<UserCollection>(
                        builder: (context, userCollection, child) {
                      var user = UserCollection.users[index];
                      var color;
                      if (UserCollection.myEvents.length > 1) {
                        if (user['same'] == true) {
                          //print(UserCollection.users[index]);
                          hideOrNot = null;
                          text = Text(
                            'Déjà invité'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        } else {
                          hideOrNot = () =>
                              ApiCall.invitation(event['id'], user['id'])
                                  .then((value) => {
                                        userCollection.setStateUsers(index),
                                      });
                          text = Text(
                            'Inviter'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }
                      } else {
                        if (user['same'] == true) {
                          //print(UserCollection.users[index]);
                          hideOrNot = null;
                          text = Text(
                            'Déjà invité'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        } else {
                          print(event[0]['id']);
                          hideOrNot = () =>
                              ApiCall.invitation(event[0]['id'], user['id'])
                                  .then((value) => {
                                        userCollection.setStateUsers(index),
                                      });
                          text = Text(
                            'Inviter'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }
                      }
                      return ListTile(
                        title: Text(user['prenom'] + " " + user['nom']),
                        subtitle: Text(user['mail']),
                        trailing:
                            ElevatedButton(onPressed: hideOrNot, child: text),
                      );
                      // onTap: () => {
                      //       userCollection.selectedEvent = lieu,
                      //       Navigator.pushNamed(context, '/myEvent')
                      //     });
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/event_map');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Retour à la map'),
                      duration: Duration(hours: 0, minutes: 0, seconds: 5),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                ),
                child: const Text('Retour à la map'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mesEvents');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Retour à mes events'),
                      duration: Duration(hours: 0, minutes: 0, seconds: 5),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                ),
                child: const Text('Retour à mes events'),
              ),
            ],
          )
          // body: Text(userCollection.selectedEvent.toString() +
          //     "\n" +
          //     UserCollection.users.toString())
          );
    });
  }
}
