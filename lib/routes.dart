import 'package:flutter/material.dart';
import 'package:offergo/views/common/main_view.dart';
import 'package:offergo/views/history/purchase-detail.dart';
import 'package:offergo/views/history/purchase.dart';
import 'package:offergo/views/history/sales.dart';
import 'package:offergo/views/notification/notifications_view.dart';
import 'package:offergo/views/product/product_offered_view.dart';
import 'package:offergo/views/product/product_view.dart';
import 'package:offergo/views/user/user_view.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainView.route:
        return MaterialPageRoute(builder: (_) => const MainView());

      case UserView.route:
        return MaterialPageRoute(builder: (_) => const UserView());

      case PurchasesView.route:
        return MaterialPageRoute(builder: (_) => const PurchasesView());

      case SalesView.route:
        return MaterialPageRoute(builder: (_) => const SalesView());

      case PurchaseDetailView.route:
        if (settings.arguments is int) {
          return MaterialPageRoute(
            builder:
                (_) =>
                    PurchaseDetailView(purchaseId: settings.arguments as int),
          );
        }
        return MaterialPageRoute(builder: (_) => const PurchasesView());

      case NotificationsView.route:
        return MaterialPageRoute(builder: (_) => const NotificationsView());

      case ProductDetailView.route:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductDetailView(
            name: args['name'],
            price: args['price'],
            imagePath: args['imagePath'],
          ),
        );

      case ProductOfferedView.route:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductOfferedView(
            name: args['name'],
            price: args['price'],
            imagePath: args['imagePath'],
          ),
        );

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
