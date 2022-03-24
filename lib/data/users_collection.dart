import 'dart:math';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reunionou/data/users.dart';
import 'package:reunionou/models/user.dart';
import 'package:reunionou/screens/event_map.dart';

class UserCollection extends ChangeNotifier {
  var connecte =false ;
  var data_user=[];
  void connecte() {
    connecte = !connecte;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  void logout(User? user) {
    selectedUser = null;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
