import 'package:flutter/material.dart';
import 'package:offergo/views/product/product_acept_offer.dart';

class ProductsView extends StatelessWidget {
  static const String route = '/products';

  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Wireless Headphones',
        'price': 59.99,
        'image': 'assets/headphones.jpg',
      },
      {
        'name': 'Smartwatch Series 6',
        'price': 129.99,
        'image': 'assets/smartwatch.jpg',
      },
      {
        'name': 'Running Shoes',
        'price': 89.50,
        'image': 'assets/shoes.jpg',
      },
      {
        'name': 'Bluetooth Speaker',
        'price': 39.99,
        'image': 'assets/speaker.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: false,
            expandedHeight: 180,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tus demandas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Puedes agregar aquí un botón de notificaciones si lo deseas
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 6),
                          prefixIcon: Icon(Icons.search, size: 18, color: Colors.black54),
                          hintText: 'Buscar demandas',
                          hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProductAcceptOfferView.route,
                        arguments: product,
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.asset(
                              product['image'],
                              height: 110,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product['name'],
                              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product['price']}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}