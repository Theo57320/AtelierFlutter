import 'dart:ffi';
import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reunionou/data/users.dart';
import 'package:reunionou/models/lieu.dart';
import 'package:reunionou/models/user.dart';
import 'package:reunionou/screens/event_map.dart';

class UserCollection extends ChangeNotifier {
  String title = 'Reunionou';
  static String token = '';
  static List<dynamic> marker = [];
  static List<Marker> tab_markers = [];
  static List<dynamic> myEvents = [];
  static String nom = 'achour';
  static String prenom = 'mouloud';
  static String mail = 'moulou@achour';
  String id_createur = '';
  String nom_createur = '';
  String prenom_createur = '';
  String mail_createur = '';
  String id_event = '';
  static String id = '9d6eb3c3-7bf6-4b7d-aa76-1422b112aa9d';
  String libelleLieu = '';
  String libelle_event = '';
  String horaire = '';
  String date = '';
  static String participe = '';
  static List<dynamic> messages = [];
  static double lat = 0.0;
  static double long = 0.0;

  Lieu? selectedEvent;
  bool eventSelected(int index) {
    return selectedEvent == myEvents[index];
  }

  setLibelleLieu(String libel) {
    libelleLieu = libel;
    notifyListeners();
  }

  setlibelleEvent(String libel) {
    libelle_event = libel;
    notifyListeners();
  }

  setHoraireEvent(String h) {
    horaire = h;
    notifyListeners();
  }

  setCreateur(String id, String nom, String mail, String prenom) {
    id_createur = id;
    prenom_createur = prenom;
    nom_createur = nom;
    mail_createur = mail;
    notifyListeners();
  }

  setDateEvent(String new_date) {
    date = new_date;
    notifyListeners();
  }

  setIdEvent(idEvent) {
    id_event = idEvent;
    notifyListeners();
  }

  setParticipeEvent(bool choix, String new_nom) {
    if (choix == true) {
      participe += '\n' + new_nom + ' participe à l\'évenement.';
      notifyListeners();
    } else {
      participe += '\n' + new_nom + ' ne participe pas à l\'évenement.';
      notifyListeners();
    }
  }

  logout() {
    nom = '';
    prenom = '';
    mail = '';
    id = '';
    notifyListeners();
  }
}
