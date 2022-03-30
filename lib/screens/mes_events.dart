import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/api_call.dart';
import 'package:reunionou/data/users_collection.dart';

class MesEvents extends StatefulWidget {
  MesEvents({Key? key}) : super(key: key);

  @override
  _ManyMarkersPageState createState() => _ManyMarkersPageState();
}

class _ManyMarkersPageState extends State<MesEvents> {
  @override
  void initState() {
    for (var user in UserCollection.users) {
      user['same'] = false;
    }
    super.initState();
    // print(UserCollection.marker);
  }

  @override
  Widget build(BuildContext context) {
    // print(UserCollection.myEvents.length);

    return Scaffold(
        appBar: AppBar(title: const Text('Mes events'), leading: Container()),
        body: Column(
          children: [
            Expanded(
                child: ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: UserCollection.myEvents.length,
              itemBuilder: (context, index) {
                return Consumer<UserCollection>(
                    builder: (context, userCollection, child) {
                  if (UserCollection.myEvents.length > 1) {
                    var lieu = UserCollection.myEvents[index];

                    var color;

                    return ListTile(
                        title: Text(lieu['libelle_event']),
                        subtitle: Text(lieu['libelle_lieu']),
                        onTap: () => {
                              UserCollection.usersInvite = [],
                              userCollection.selectedEvent = lieu,
                              ApiCall.getUsersInvite(lieu['id']).then((value) {
                                for (var userInvite
                                    in UserCollection.usersInvite) {
                                  for (var user in UserCollection.users) {
                                    if (user['id'] == userInvite['id']) {
                                      user['same'] = true;
                                    }
                                  }
                                }

                                Navigator.pushNamed(context, '/myEvent');
                              }),
                            });
                  } else {
                    var lieu = UserCollection.myEvents[index];

                    var color;

                    return ListTile(
                        title: Text(lieu[index]['libelle_event']),
                        subtitle: Text(lieu[index]['libelle_lieu']),
                        onTap: () => {
                              UserCollection.usersInvite = [],
                              userCollection.selectedEvent = lieu,
                              ApiCall.getUsersInvite(lieu[index]['id'])
                                  .then((value) {
                                for (var userInvite
                                    in UserCollection.usersInvite) {
                                  for (var user in UserCollection.users) {
                                    if (user['id'] == userInvite['id']) {
                                      user['same'] = true;
                                    }
                                  }
                                }

                                Navigator.pushNamed(context, '/myEvent');
                              }),
                            });
                  }
                });
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
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
          ],
        ));
  }
}
