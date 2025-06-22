import 'package:flutter/material.dart';
import 'package:offergo/views/notification/notifications_view.dart';
import 'package:offergo/views/product/product_offered_view.dart';
import 'package:offergo/views/product/update_price_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
              SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      floating: false,
      expandedHeight: 260, // Reducido desde 300
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
  background: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: SafeArea(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 180, // igual o menor que expandedHeight
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                height: 60, // reduce también este tamaño
                width: 60,
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
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bienvenido, Usuario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, NotificationsView.route);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: Icon(Icons.notifications_none, size: 16, color: Colors.black87),
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            Container(
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 6),
                  prefixIcon: Icon(Icons.search, size: 16, color: Colors.black54),
                  hintText: 'Buscar demandas',
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 12),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black87, fontSize: 12),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
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
                  _buildSectionTitle('Categorías de demandas'),
                  const SizedBox(height: 12),
                  _buildCategories(),
                  const SizedBox(height: 28),
                  _buildPromoBanner(),
                  const SizedBox(height: 28),
                  _buildSectionTitle('Demandas activas', showViewAll: true),
                  _buildDemandsGrid(context),
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
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          if (showViewAll)
            const Text('Ver todas', style: TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ['Tecnología', 'Moda', 'Hogar', 'Oficina', 'Muebles', 'Belleza'];

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
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.category, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              Text(categories[index], style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 160,
        child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            final titles = ['Demanda 1', 'Demanda 2', 'Demanda 3'];
            final images = [
              'assets/sneakers.jpg',
              'assets/sneakers.jpg',
              'assets/sneakers.jpg',
            ];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, UpdatePriceView.route);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                      Row(
                        children: List.generate(3, (dotIndex) {
                          return Container(
                            margin: const EdgeInsets.only(left: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotIndex == index
                                  ? Colors.white
                                  : Colors.grey.shade400,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDemandsGrid(BuildContext context) {
    final List<Map<String, dynamic>> demands = [
      {
        'title': 'Laptop para diseño gráfico',
        'price': 1200.00,
        'image': 'assets/demanda1.jpg',
      },
      {
        'title': 'Silla ergonómica de oficina',
        'price': 250.00,
        'image': 'assets/demanda2.jpg',
      },
      {
        'title': 'Vestido de gala azul',
        'price': 80.00,
        'image': 'assets/demanda3.jpg',
      },
      {
        'title': 'Set de maquillaje profesional',
        'price': 150.00,
        'image': 'assets/demanda4.jpg',
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: demands.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final demand = demands[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductOfferedView.route,
                arguments: {
                  'name': demand['title'],
                  'price': demand['price'],
                  'imagePath': demand['image'],
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      demand['image'],
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      demand['title'],
                      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${demand['price']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}