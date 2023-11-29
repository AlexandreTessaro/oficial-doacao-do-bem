// Importa o pacote Flutter para construção de interfaces gráficas.
import 'package:flutter/material.dart';

// Widget que adiciona uma animação de escala (zoom) a um elemento filho.
class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  // Construtor que exige parâmetros obrigatórios e fornece valores padrão para os opcionais.
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

// Estado do widget LikeAnimation.
class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  // Controlador de animação.
  late AnimationController controller;
  // Animação de escala.
  late Animation<double> scale;

  // Inicialização do estado.
  @override
  void initState() {
    super.initState();
    // Criação do controlador de animação com a duração especificada.
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    // Criação da animação de escala que vai de 1 para 1.2.
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  // Método chamado sempre que o widget é atualizado.
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Verifica se o estado de animação mudou.
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  // Método para iniciar a animação.
  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();  // Inicia a animação de escala (zoom).
      await controller.reverse();  // Reverte a animação para o tamanho original.
      await Future.delayed(
        const Duration(milliseconds: 200),
      );

      // Chama a função de callback ao final da animação, se fornecida.
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  // Método chamado quando o widget é descartado.
  @override
  void dispose() {
    super.dispose();
    controller.dispose(); 
  }

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    // Retorna um widget que aplica a animação de escala ao seu elemento filho.
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
