import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Welcome to OfferGo!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is the Home tab.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Acción de prueba
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Botón presionado')),
                );
              },
              child: const Text('Probar acción'),
            ),
          ],
        ),
      ),
    );
  }
}
