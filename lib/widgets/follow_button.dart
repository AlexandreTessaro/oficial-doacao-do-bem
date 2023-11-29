import 'package:flutter/material.dart';

// Widget que representa um botão de seguir ou similar.
class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  // Construtor que exige parâmetros obrigatórios.
  const FollowButton({
    Key? key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    this.function,
  }) : super(key: key);

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    // Retorna um container com um botão de texto customizado.
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,  
        child: Container(
          // Configuração da aparência do botão.
          decoration: BoxDecoration(
            color: backgroundColor,  
            border: Border.all(
              color: borderColor, 
            ),
            borderRadius: BorderRadius.circular(5),  
          ),
          alignment: Alignment.center,  
          width: 250,
          height: 27,  
          child: Text(
            text,
            style: TextStyle(
              color: textColor, 
              fontWeight: FontWeight.bold,  
            ),
          ),
        ),
      ),
    );
  }
}
