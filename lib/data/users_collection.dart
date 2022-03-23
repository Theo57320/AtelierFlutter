import 'dart:math';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reunionou/data/users.dart';
import 'package:reunionou/models/user.dart';
import 'package:reunionou/screens/event_map.dart';

class UserCollection extends ChangeNotifier {
  var listUser = [];
  var title = "Reunionou";
  User? selectedUser;
  bool isSelected(int index) {
    return selectedUser == listUser[index];
  }

  Widget showMapsWhenUserIsSelected() {
    return Consumer<UserCollection>(builder: (context, tasksCollection, child) {
      return (Provider.of<UserCollection>(context).selectedUser != null)
          ? EventMap()
          : Container();
    });
  }

  void logout(User? user) {
    selectedUser = null;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
