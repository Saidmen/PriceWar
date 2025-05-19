import 'package:flutter/material.dart';

class BuyerPage extends StatelessWidget {
  const BuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Comprador'),
      ),
      body: const Center(
        child: Text('Bienvenido, Comprador. Aquí puedes ver y comprar productos.'),
      ),
    );
  }
}