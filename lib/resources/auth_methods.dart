import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/models/user.dart' as model;
import 'package:instagram_clone_flutter/resources/storage_methods.dart';

// Classe que fornece métodos para autenticação e manipulação de dados do usuário.
class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método assíncrono que obtém os detalhes do usuário atual a partir do Firestore.
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Método assíncrono para registrar um novo usuário no aplicativo.
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Algum erro aconteceu";
    try {
      // Verifica se todos os campos necessários foram preenchidos.
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        // Cria um novo usuário no Firebase Authentication.
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Faz upload da imagem de perfil para o armazenamento e obtém a URL.
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file, false);

        // Cria uma instância da classe 'User'.
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // Adiciona os detalhes do usuário ao Firestore.
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "successo";
      } else {
        res = "Por favor preencha todos os campos";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Método assíncrono para autenticar um usuário existente no aplicativo.
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Algum erro aconteceu";
    try {
      // Verifica se todos os campos necessários foram preenchidos.
      if (email.isNotEmpty || password.isNotEmpty) {
        // Realiza o login do usuário no Firebase Authentication.
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "successo";
      } else {
        res = "Por favor preencha todos os campos";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Método assíncrono para desconectar o usuário autenticado.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
