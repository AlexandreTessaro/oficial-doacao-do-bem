import 'package:flutter/material.dart';

// Widget reutilizável para entrada de texto em um formulário.
class TextFieldInput extends StatelessWidget {
  // Controlador para o campo de texto.
  final TextEditingController textEditingController;
  // Indica se o campo é para senha, ocultando os caracteres digitados.
  final bool isPass;
  // Texto de dica exibido no campo.
  final String hintText;
  // Tipo de entrada de texto.
  final TextInputType textInputType;

  // Construtor que exige parâmetros obrigatórios.
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    // Define um estilo de borda para o campo de texto.
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    // Retorna um widget de TextField com as configurações especificadas.
    return TextField(
      // Usa o controlador fornecido para gerenciar o conteúdo do campo.
      controller: textEditingController,
      // Configuração da aparência do campo de texto.
      decoration: InputDecoration(
        hintText: hintText,           
        border: inputBorder,         
        focusedBorder: inputBorder, 
        enabledBorder: inputBorder,
        filled: true,                
        contentPadding: const EdgeInsets.all(8),  // Define o preenchimento interno do campo.
      ),
      keyboardType: textInputType,  
      obscureText: isPass,      
    );
  }
}
