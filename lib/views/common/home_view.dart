import 'package:flutter/material.dart';
import 'package:offergo/views/notificacion/notifications_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FD),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: false,
            expandedHeight: 230,
            backgroundColor: const Color(0xFF4F68F7),
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Good day for shopping',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, NotificationsView.route);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.notifications_none, color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Taimoor Sikander',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search in Store',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Popular Categories'),
                  const SizedBox(height: 12),
                  _buildCategories(),

                  const SizedBox(height: 28),
                  _buildPromoBanner(),

                  const SizedBox(height: 28),
                  _buildSectionTitle('Popular Products', showViewAll: true),
                  const SizedBox(height: 16),
                  _buildProductsGrid(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: showViewAll ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (showViewAll)
            Text('View all', style: TextStyle(color: Colors.blue.shade600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ['Shoes', 'Electro.', 'Clothes', 'Animals', 'Furniture', 'Beauty'];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          return Column(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE0E7FF),
                child: const Icon(Icons.category, color: Color(0xFF4F68F7)),
              ),
              const SizedBox(height: 6),
              Text(categories[index], style: const TextStyle(fontSize: 12)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/sneakers.jpg'), // <- asegúrate de tenerla
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomLeft,
          child: const Text(
            'SPORTS SALE\nCYBER MONDAY -50%',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_bag, size: 48, color: Colors.blue),
                SizedBox(height: 8),
                Text('Producto', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('\$79.99', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}
