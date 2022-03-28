import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';

class MyEvent extends StatefulWidget {
  MyEvent({Key? key}) : super(key: key);

  @override
  _ManyMarkersPageState createState() => _ManyMarkersPageState();
}

class _ManyMarkersPageState extends State<MyEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mes events'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: UserCollection.myEvents.length,
              itemBuilder: (context, index) {
                return Consumer<UserCollection>(
                    builder: (context, userCollection, child) {
                  var lieu = UserCollection.myEvents[index];
                  var color;

                  return ListTile(
                      tileColor: userCollection.eventSelected(index)
                          ? Colors.lightBlueAccent
                          : color,
                      title: Text(lieu['libelle_event']),
                      subtitle: Text(lieu['libelle_lieu']),
                      onTap: () => Navigator.pushNamed(context, '/myEvent'));
                });
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ],
        ));
  }
}
