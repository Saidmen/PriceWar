import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  static const String route = '/notifications';

  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Compra completada',
        'message': 'Tu pedido #12345 fue entregado exitosamente.',
        'icon': Icons.shopping_bag_outlined,
        'color': Colors.green,
        'date': 'Hace 2h'
      },
      {
        'title': 'Oferta especial',
        'message': '¡40% en productos seleccionados hoy!',
        'icon': Icons.local_offer_outlined,
        'color': Colors.orange,
        'date': 'Hace 5h'
      },
      {
        'title': 'Cuenta actualizada',
        'message': 'Tu información de perfil ha sido modificada.',
        'icon': Icons.person_outline,
        'color': Colors.blue,
        'date': 'Ayer'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: notifications.isEmpty
          ? const _EmptyNotifications()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _NotificationCard(
                  icon: notif['icon'],
                  color: notif['color'],
                  title: notif['title'],
                  message: notif['message'],
                  date: notif['date'],
                );
              },
            ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String date;

  const _NotificationCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          date,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'Sin notificaciones por ahora',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
