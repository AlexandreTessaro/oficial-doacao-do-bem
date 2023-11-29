import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Função assíncrona que permite selecionar uma imagem da galeria ou tirar uma foto, dependendo da 'source'.
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

// Função que exibe uma barra de snackbar na parte inferior da interface.
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
