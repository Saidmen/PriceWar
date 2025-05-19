import 'package:flutter/material.dart';
import 'package:offergo/views/common/main_view.dart';
import 'package:offergo/views/user/user_view.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainView.route:
        return MaterialPageRoute(builder: (_) => const MainView());

      case UserView.route:
        return MaterialPageRoute(builder: (_) => const UserView());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Página no encontrada')),
            body: const Center(child: Text('Ruta inválida')),
          ),
    );
  }
}
