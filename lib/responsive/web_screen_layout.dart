import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';

// Widget para o layout em telas web.
class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

// Estado do widget WebScreenLayout.
class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0; 
  late PageController pageController; 

  @override
  void initState() {
    super.initState();
    pageController = PageController(); 
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose(); 
  }

  // Função chamada quando a página muda.
  void onPageChanged(int page) {
    setState(() {
      _page = page; 
    });
  }

  // Função chamada ao clicar em um ícone de navegação.
  void navigationTapped(int page) {
    pageController.jumpToPage(page); 
    setState(() {
      _page = page; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor, 
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(0),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(1),
          ),
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(2),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(4),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController, 
        onPageChanged: onPageChanged, 
        children: homeScreenItems, 
      ),
    );
  }
}
