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
  static String access_token = '';
  static List<dynamic> usersInvite = [];
  static List<dynamic> participants = [];
  static List<dynamic> participantsNon = [];
  static List<dynamic> usersParticipe = [];
  static List<dynamic> users = [];
  static List<dynamic> marker = [];
  static List<Marker> tab_markers = [];
  static List<dynamic> myEvents = [];
  static String nom = '';
  static String prenom = '';
  static String mail = '';
  String id_createur = '';
  String nom_createur = '';
  String prenom_createur = '';
  String mail_createur = '';
  String id_event = '';

  static String id = '';
  String libelleLieu = '';
  String libelle_event = '';
  String horaire = '';
  String date = '';
  static String participe = '';
  static List<dynamic> messages = [];
  static double lat = 0.0;
  static double long = 0.0;

  var selectedEvent;

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

  setStateUsers(index) {
    users[index]['same'] = true;

    notifyListeners();
  }

  setStateMarkers() {
    marker = marker;
    notifyListeners();
  }

  setStateComms() {
    messages = messages;
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
    usersParticipe = [];
    nom = '';
    prenom = '';
    mail = '';
    id = '';
    token = '';
    access_token = '';
    usersInvite = [];
    participants = [];
    users = [];
    marker = [];
    tab_markers = [];
    myEvents = [];
    id_createur = '';
    nom_createur = '';
    prenom_createur = '';
    mail_createur = '';
    id_event = '';
    id = '';
    libelleLieu = '';
    libelle_event = '';
    horaire = '';
    date = '';
    participe = '';
    messages = [];
    participantsNon = [];
    notifyListeners();
  }
}
