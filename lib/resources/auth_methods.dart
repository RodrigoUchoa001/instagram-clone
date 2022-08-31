import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///Classe que contém métodos usados para fazer autenticação no aplicativo.
class AuthMethods {
  ///Instância do FirebaseAuth para usar nos metodos de autenticação.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///Instância do FirebaseFireStore para usar metodos do banco de dados.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///método para criar conta.
  Future<String> signUpUser({
    // Paramêtros q precisa pra criar conta
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    //vai guardar um string com o resultado da operação.
    String res = 'Deu algum erro';
    try {
      //Se nenhum campo está vazio:
      if (noneSignUpFildEmpty(email, username, password, bio, file)) {
        // registra o usuário
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // adiciona os dados restantes no banco de dados
        // uid para relacionar a criação do usuario feita lá em cima com os
        // dados a serem inseridos no bd.
        final userUid = cred.user!.uid;
        debugPrint(userUid);
        await _firestore.collection('users').doc(userUid).set({
          // passando cada um dos dados para o bd, na coleção 'users',
          // no 'doc' userid
          'username': username,
          'uid': userUid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });

        // Se chegou aqui deu tudo certo.
        res = 'sucesso';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// Testa se nenhum dos campos passados por parâmetro é vazio.
  bool noneSignUpFildEmpty(String email, String username, String password,
      String bio, Uint8List file) {
    if (email.isNotEmpty ||
        password.isNotEmpty ||
        username.isNotEmpty ||
        file != null) {
      return true;
    }
    return false;
  }
}
