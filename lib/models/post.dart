import 'package:cloud_firestore/cloud_firestore.dart';

// Define a estrutura da classe 'Post'.
class Post {
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  // Construtor da classe 'Post' que exige valores para todos os atributos.
  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  // Método estático que converte um DocumentSnapshot em uma instância da classe 'Post'.
  static Post fromSnap(DocumentSnapshot snap) {
    // Obtém os dados do DocumentSnapshot como um mapa de strings e dinâmicos.
    var snapshot = snap.data() as Map<String, dynamic>;

    // Cria e retorna uma instância da classe 'Post' com base nos dados do DocumentSnapshot.
    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
    );
  }

  // Método que converte uma instância da classe 'Post' em um mapa de strings e dinâmicos.
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
      };
}
