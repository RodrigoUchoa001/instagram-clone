import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// método pra pegar uma imagem da galeria usando o pacote image_picker.
pickImage(ImageSource source) async {
  // Instanciando o pacote image_picker.
  final ImagePicker _imagePicker = ImagePicker();

  // salva a imagem, tenha sido selecionada uma ou não no _file.
  XFile? _file = await _imagePicker.pickImage(source: source);

  // testa se está vazio, será vazio caso o usuário entre na tela de selecionar
  // imagem mas n selecione nenhuma.
  if (_file != null) {
    // caso n seja vazio, retorna imagem.
    return await _file.readAsBytes();
  }
  print('nenhuma imagem selecionada!');
}
