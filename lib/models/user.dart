import 'package:cloud_firestore/cloud_firestore.dart';

// Define a estrutura da classe 'User'.
class User {
  // Atributos do usuário.
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  // Construtor da classe 'User' que exige valores para todos os atributos.
  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  // Método estático que converte um DocumentSnapshot em uma instância da classe 'User'.
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    // Cria e retorna uma instância da classe 'User' com base nos dados do DocumentSnapshot.
    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  // Método que converte uma instância da classe 'User' em um mapa de strings e dinâmicos.
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
