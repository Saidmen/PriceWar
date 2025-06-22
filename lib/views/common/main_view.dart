import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:offergo/views/common/home_view.dart';
import 'package:offergo/views/product/add_product_view.dart';
import 'package:offergo/views/product/products_view.dart';
import 'package:offergo/views/user/user_view.dart';

class MainView extends StatefulWidget {
  static const String route = '/main';

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  bool typeUser = true;

  @override
  Widget build(BuildContext context) {
    // Construye la lista de páginas según typeUser
    final List<Widget> pages = [
      const HomeView(),
      const ProductView(),
      if (typeUser) const ProductsView(),
      const UserView(),
    ];

    // Construye la barra inferior según typeUser
    final List<SalomonBottomBarItem> items = [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: const Text("Inicio"),
        selectedColor: const Color.fromARGB(255, 145, 146, 146),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.add_circle),
        title: const Text("Añadir Demanda"),
        selectedColor: Colors.green,
      ),
      if (typeUser)
        SalomonBottomBarItem(
          icon: const Icon(Icons.whatshot_rounded),
          title: const Text("Tus Demandas"),
          selectedColor: Colors.pink,
        ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: const Text("Perfil"),
        selectedColor: Colors.orange,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: items,
      ),
    );
  }
}
