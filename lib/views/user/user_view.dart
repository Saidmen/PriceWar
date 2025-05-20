import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  static const String route = '/user';

  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, size: 50, color: Colors.blue),
            ),
            const SizedBox(height: 12),
            const Text(
              'Joel Miller',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'joelmiller@example.com',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),
            const Divider(),

            // Opciones de perfil
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Ir a configuración
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Ir al historial
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
