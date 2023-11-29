import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget que representa um cartão de comentário.
class CommentCard extends StatelessWidget {
  final snap;

  // Construtor que exige a informação do comentário.
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          // Avatar do usuário que fez o comentário.
          CircleAvatar(
            backgroundImage: NetworkImage(
              snap.data()['profilePic'],  
            ),
            radius: 18,  
          ),
          // Área expandida para o nome, texto do comentário e data.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nome do comentarista e texto do comentário, estilizados com RichText.
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: snap.data()['name'],  
                          style: const TextStyle(fontWeight: FontWeight.bold,),  
                        ),
                        TextSpan(
                          text: ' ${snap.data()['text']}',  
                        ),
                      ],
                    ),
                  ),
                  // Exibe a data de publicação do comentário, formatada usando o pacote 'intl'.
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap.data()['datePublished'].toDate(),  
                      ),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400,),  
                    ),
                  )
                ],
              ),
            ),
          ),
          // Ícone de coração que indica talvez uma opção de 'curtir' o comentário (não está claro na interface).
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
