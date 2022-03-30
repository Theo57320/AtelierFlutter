import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/api_call.dart';
import 'package:reunionou/data/users_collection.dart';

class ParticipantsCommentaires extends StatefulWidget {
  ParticipantsCommentaires({Key? key}) : super(key: key);

  @override
  _ParticipantsCommentairesPageState createState() =>
      _ParticipantsCommentairesPageState();
}

class _ParticipantsCommentairesPageState
    extends State<ParticipantsCommentaires> {
  var hideOrNot;
  var text;
  final myControllerMessage = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserCollection>(builder: (context, userCollection, child) {
      var i;

      if (UserCollection.participantsNon.length > 1) {
        print(UserCollection.participantsNon);
        i = UserCollection.participantsNon[1].length;
        print('je suis ici ');
      } else {
        print('je suis la ');
        print(UserCollection.participantsNon.length);
        i = UserCollection.participantsNon.length;
      }
      var event = userCollection.selectedEvent;
      final _formKey = GlobalKey<FormState>();
      return Scaffold(
          appBar: AppBar(
              title: const Text('Participant(e)s et commentaire(s)'),
              leading: Container()),
          body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                const Text(
                  'Participants (je viens)',
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.0),
                    itemCount: UserCollection.participants.length,
                    itemBuilder: (context, index) {
                      return Consumer<UserCollection>(
                          builder: (context, userCollection, child) {
                        return ListTile(
                          title: Text(
                            UserCollection.participants[index]['nom']
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            UserCollection.participants[index]['prenom']
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
                const Text(
                  'Participants (je viens pas)',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.0),
                    itemCount: i,
                    itemBuilder: (context, index) {
                      return Consumer<UserCollection>(
                          builder: (context, userCollection, child) {
                        if (UserCollection.participantsNon.length > 1) {
                          return ListTile(
                            title: Text(
                              UserCollection.participantsNon[1][index]['nom']
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              UserCollection.participantsNon[1][index]['prenom']
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Text(
                              '',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              '',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        }

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
                const Text('Commentaires'),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.0),
                    itemCount: UserCollection.messages.length,
                    itemBuilder: (context, index) {
                      return Consumer<UserCollection>(
                          builder: (context, userCollection, child) {
                        hideOrNot = null;

                        return ListTile(
                          title: Text(
                            UserCollection.messages[index]['user']['nom']
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            UserCollection.messages[index]['message']
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      });
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Message',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ex: mon message',
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
                        controller: myControllerMessage,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: () {
                          ApiCall.addComment(userCollection.id_event,
                                  myControllerMessage.text)
                              .then((value) {
                            userCollection.setStateComms();
                          });
                        },
                        child: Text(
                          'continue'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/event_map');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Back to the map'),
                                  duration: Duration(
                                      hours: 0, minutes: 0, seconds: 5),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                            ),
                            child: const Text('Back to the map'),
                          ),
                        ],
                      )
                      // body: Text(userCollection.selectedEvent.toString() +
                      //     "\n" +
                      //     UserCollection.users.toString())
                    ]))
              ])));
    });
  }
}
