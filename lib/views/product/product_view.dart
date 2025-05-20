import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  static const String route = '/product-detail';

  final String name;
  final double price;
  final String imagePath;

  const ProductDetailView({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Image.asset(imagePath, height: 250, fit: BoxFit.cover),
          const SizedBox(height: 20),
          Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('${price.toStringAsFixed(2)} Bs', style: const TextStyle(fontSize: 18, color: Colors.blue)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Aquí podrías poner una descripción más detallada del producto, características, etc.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
