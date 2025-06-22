import 'package:flutter/material.dart';
import 'package:offergo/views/product/qualification_seller.dart';

class ProductAcceptOfferView extends StatelessWidget {
  static const String route = '/product-accept-offer';

  const ProductAcceptOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oferta del Producto'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del producto
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(product['image']),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Precio actual: \$${product['price'].toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            if (product['proposedPrice'] != null) ...[
              const SizedBox(height: 8),
              Text(
                'Propuesta: \$${product['proposedPrice'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: const Text(
                      "Rechazar",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Oferta rechazada'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    "Aceptar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, QualificationSeller.route);
                  },
                ),
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}