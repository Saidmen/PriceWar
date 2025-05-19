import 'package:flutter/material.dart';

class SellerPage extends StatelessWidget {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Vendedor'),
      ),
      body: const Center(
        child: Text('Bienvenido, Vendedor. Aquí puedes gestionar tus productos y ventas.'),
      ),
    );
  }
}
