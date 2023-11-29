import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout.dart';
import 'package:instagram_clone_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

// Função principal que inicializa o aplicativo Flutter.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase. As configurações são diferentes se o app estiver rodando na web ou não.
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCdv5ViRhM3_TOV3CD8jhJjVxrD9E8PBWE",
        appId: "1:1012241170230:web:7bad4f57712ab2dc76fd97",
        messagingSenderId: "1012241170230",
        projectId: "teste-doacaodobem",
        storageBucket: 'teste-doacaodobem.appspot.com'
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Inicia a execução do aplicativo.
  runApp(const MyApp());
}

// Classe principal do aplicativo que estende StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Método que constrói a interface do aplicativo.
  @override
  Widget build(BuildContext context) {
    // Utiliza MultiProvider para fornecer o estado do usuário através do UserProvider.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      // Configuração geral do MaterialApp.
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doação do Bem',
        // Configura o tema escuro do aplicativo.
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // Utiliza um StreamBuilder para reagir às mudanças no estado de autenticação do Firebase.
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Verifica se a conexão está ativa.
            if (snapshot.connectionState == ConnectionState.active) {
              // Se houver dados de autenticação, exibe um layout responsivo.
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              }
              // Se houver um erro, exibe uma mensagem de erro no centro da tela.
              else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            // Se estiver esperando, exibe um indicador de carregamento no centro da tela.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Se nenhuma condição for atendida, exibe a tela de login.
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
