import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// método pra enviar imagem pro firebase storage. Vai ser usado tanto pra
  /// enviar fts de perfil quanto posts
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // child = nome de pasta.
    // vai ser usado pra pegar o caminho de uma pasta a ser salva a img.
    // exemplo:
    // childName = profilePics
    // _auth.currentUser!.uid = idDoCara
    // a img vai ser salva em /profilePics/idDoCara.jpeg <= imagem com id no nome
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // upando a img de fato naquele caminho
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;

    // vai retornar o link para aquela imagem salva, para q ela possa ser
    // exibida com NetworkImage.
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
