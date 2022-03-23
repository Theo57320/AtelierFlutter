class User {
  final String mail;
  final String id;
  final String nom;
  final String prenom;
  final String sexe;
  final String password;
  final String token;

  const User({
    required this.mail,
    required this.id,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        mail: json['mail'],
        id: json['id'],
        nom: json['nom'],
        prenom: json['prenom'],
        sexe: json['sexe'],
        password: json['password'],
        token: json['token']);
  }
}
