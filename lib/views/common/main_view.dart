import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:offergo/views/common/home_view.dart';
import 'package:offergo/views/product/product_view.dart';
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
  bool typeUser = false;

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
        title: const Text("Home"),
        selectedColor: Colors.blue,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.store),
        title: const Text("Store"),
        selectedColor: Colors.green,
      ),
      if (typeUser)
        SalomonBottomBarItem(
          icon: const Icon(Icons.favorite),
          title: const Text("Wishlist"),
          selectedColor: Colors.pink,
        ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: const Text("Profile"),
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
