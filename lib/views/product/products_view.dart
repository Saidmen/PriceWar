import 'package:flutter/material.dart';
import 'package:offergo/views/product/product_view.dart';

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
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Products',
          style: TextStyle(
            color: Color(0xFF303030), 
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF303030)),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, const Color(0xFFF5F7FA)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
              ),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) => _buildProductCard(context, products[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailView.route,
              arguments: {
                'name': product['name'],
                'price': product['price'],
                'imagePath': product['image'],
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: product['name'],
                    child: Image.asset(
                      product['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${product['price']} Bs',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF303030),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
