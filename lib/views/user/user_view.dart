import 'package:flutter/material.dart';
import 'package:offergo/views/history/purchase.dart';
import 'package:offergo/views/history/sales.dart';

class UserView extends StatelessWidget {
  static const String route = '/user';

  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with profile header
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black, // AppBar negro
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 99, 98, 98), // Fondo negro
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Joel Miller',
                        style: TextStyle(
                          fontSize: 22, 
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'joelmiller@example.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // User Stats Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn(context, '42', 'Compras'),
                  _buildVerticalDivider(),
                  _buildStatColumn(context, '28', 'Ventas'),
                  _buildVerticalDivider(),
                  _buildStatColumn(context, '4.8', 'Rating'),
                ],
              ),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Acciones rápidas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickAction(
                        context, 
                        Icons.shopping_bag_outlined, 
                        'Mis compras',
                        () {
                          Navigator.pushNamed(context, PurchasesView.route);
                        },
                      ),
                      _buildQuickAction(
                        context, 
                        Icons.sell_outlined, 
                        'Mis ventas',
                        () {
                          Navigator.pushNamed(context, SalesView.route);
                        },
                      ),
                      _buildQuickAction(
                        context, 
                        Icons.favorite_border, 
                        'Favoritos',
                        () {/* Navegar a favoritos */},
                      ),
                      _buildQuickAction(
                        context, 
                        Icons.message_outlined, 
                        'Mensajes',
                        () {/* Navegar a mensajes */},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Account Settings
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Cuenta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildListTile(
                    context,
                    Icons.person_outline,
                    'Editar perfil',
                    onTap: () {/* Navegar a editar perfil */},
                  ),
                  _buildListTile(
                    context,
                    Icons.location_on_outlined,
                    'Mis direcciones',
                    onTap: () {/* Navegar a direcciones */},
                  ),
                  _buildListTile(
                    context,
                    Icons.payment_outlined,
                    'Métodos de pago',
                    onTap: () {/* Navegar a métodos de pago */},
                  ),
                  _buildListTile(
                    context,
                    Icons.verified_user_outlined,
                    'Verificación de cuenta',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Verificado',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {/* Navegar a verificación */},
                  ),
                ],
              ),
            ),
          ),

          // App Settings
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Ajustes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _buildListTile(
                    context,
                    Icons.settings_outlined,
                    'Configuración',
                    onTap: () {/* Navegar a configuración */},
                  ),
                  _buildListTile(
                    context,
                    Icons.notifications_none_outlined,
                    'Notificaciones',
                    onTap: () {/* Navegar a notificaciones */},
                  ),
                  _buildListTile(
                    context,
                    Icons.history,
                    'Historial',
                    onTap: () {/* Navegar a historial */},
                  ),
                  _buildListTile(
                    context,
                    Icons.help_outline,
                    'Ayuda y soporte',
                    onTap: () {/* Navegar a ayuda */},
                  ),
                  _buildListTile(
                    context,
                    Icons.logout,
                    'Cerrar sesión',
                    textColor: Colors.red,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sesión cerrada')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Version info
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'OfferGo v1.0.0',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.black.withOpacity(0.3),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, 
    IconData icon, 
    String label, 
    VoidCallback onTap
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(31, 10, 1, 1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    IconData icon,
    String title, {
    Widget? trailing,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ?? const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}