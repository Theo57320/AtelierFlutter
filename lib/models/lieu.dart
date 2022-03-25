class Lieu {
  final String lat;
  final String id;
  final String long;
  final String libelle_event;
  final String libelle_lieu;
  final String horaire;
  final String date;
  final String createur_id;

  const Lieu({
    required this.lat,
    required this.id,
    required this.long,
    required this.libelle_event,
    required this.libelle_lieu,
    required this.horaire,
    required this.date,
    required this.createur_id,
  });

  factory Lieu.fromJson(Map<String, dynamic> json) {
    return Lieu(
        lat: json['lat'],
        id: json['id'],
        long: json['long'],
        libelle_event: json['libelle_event'],
        libelle_lieu: json['libelle_lieu'],
        horaire: json['horaire'],
        date: json['date'],
        createur_id: json['createur_id']);
  }
}
