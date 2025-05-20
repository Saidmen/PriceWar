import 'package:flutter/material.dart';

class SalesView extends StatefulWidget {
  static const String route = '/sales';

  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  // Control del filtro activo
  String _activeFilter = 'Todas';
  
  // Lista de estados posibles para los filtros
  final List<String> _filters = ['Todas', 'Activas', 'Reservadas', 'Vendidas', 'Pausadas'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Mis Ventas'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Crear nueva venta'))
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Resumen de ventas
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumen de ventas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummaryItem(
                        'Ganancia total',
                        '\$1,250.00',
                        Icons.monetization_on_outlined,
                      ),
                      _buildSummaryItem(
                        'Ventas completadas',
                        '28',
                        Icons.shopping_bag_outlined,
                      ),
                      _buildSummaryItem(
                        'Rating promedio',
                        '4.8',
                        Icons.star_outline,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Filtros de ventas
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildFilterChip(
                      context, 
                      _filters[index], 
                      _activeFilter == _filters[index]
                    ),
                  );
                },
              ),
            ),
          ),

          // Lista de ventas filtradas
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Simular diferentes estados para mostrar variedad
                final statuses = ['Activa', 'Reservada', 'Vendida', 'Pausada'];
                final status = statuses[index % statuses.length];
                
                // Filtrar los elementos según el filtro activo
                if (_activeFilter == 'Todas' || 
                    (_activeFilter == 'Activas' && status == 'Activa') ||
                    (_activeFilter == 'Reservadas' && status == 'Reservada') ||
                    (_activeFilter == 'Vendidas' && status == 'Vendida') ||
                    (_activeFilter == 'Pausadas' && status == 'Pausada')) {
                  return _buildSaleItem(context, index, status);
                } else {
                  return const SizedBox.shrink(); // No mostrar este elemento
                }
              },
              childCount: 20, // Simular 20 ventas
            ),
          ),
          
          // Mensaje cuando no hay resultados
          SliverToBoxAdapter(
            child: Builder(builder: (context) {
              // Verificar si hay elementos visibles
              bool hasVisibleItems = false;
              for (int i = 0; i < 20; i++) {
                final statuses = ['Activa', 'Reservada', 'Vendida', 'Pausada'];
                final status = statuses[i % statuses.length];
                if (_activeFilter == 'Todas' || 
                    (_activeFilter == 'Activas' && status == 'Activa') ||
                    (_activeFilter == 'Reservadas' && status == 'Reservada') ||
                    (_activeFilter == 'Vendidas' && status == 'Vendida') ||
                    (_activeFilter == 'Pausadas' && status == 'Pausada')) {
                  hasVisibleItems = true;
                  break;
                }
              }
              
              if (!hasVisibleItems) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tienes ventas con estado "${_activeFilter.toLowerCase()}"',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        if (_activeFilter == 'Todas')
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Crear nueva venta'))
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Crear nueva venta'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Crear nueva venta'))
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _activeFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).primaryColor 
              : Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSaleItem(BuildContext context, int index, String status) {
    // Generar datos de ejemplo basados en el índice
    final name = 'Producto #${1000 + index}';
    final price = (index + 1) * 25.00;
    final date = DateTime.now().subtract(Duration(days: index * 2));
    final dateStr = '${date.day}/${date.month}/${date.year}';
    final views = (index + 1) * 5;
    final likes = index % 5;
    final hasBuyerInfo = status == 'Reservada' || status == 'Vendida';
    final buyerName = hasBuyerInfo ? 'Usuario${1000 + index}' : null;
    
    // Determinar color según estado
    Color statusColor;
    switch (status) {
      case 'Activa':
        statusColor = Colors.green;
        break;
      case 'Reservada':
        statusColor = Colors.blue;
        break;
      case 'Vendida':
        statusColor = Colors.purple;
        break;
      case 'Pausada':
      default:
        statusColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navegar al detalle de la venta o producto
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ver detalle de $name'))
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con estado
            Container(
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(status),
                        size: 16,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Publicado el $dateStr',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen del producto
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 30,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Información del producto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        // Estadísticas o información del comprador
                        if (hasBuyerInfo)
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Comprador: $buyerName',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Icon(
                                Icons.visibility_outlined,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$views vistas',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$likes',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Acciones según estado
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (status == 'Activa')
                    _buildActionButton(
                      'Pausar',
                      Icons.pause_outlined,
                      Colors.orange,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Venta pausada'))
                        );
                      },
                    ),
                  if (status == 'Activa' || status == 'Pausada')
                    _buildActionButton(
                      'Editar',
                      Icons.edit_outlined,
                      Theme.of(context).primaryColor,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Editar venta'))
                        );
                      },
                    ),
                  if (status == 'Pausada')
                    _buildActionButton(
                      'Activar',
                      Icons.play_arrow_outlined,
                      Colors.green,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Venta activada'))
                        );
                      },
                    ),
                  if (status == 'Reservada')
                    _buildActionButton(
                      'Confirmar',
                      Icons.check_outlined,
                      Colors.green,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Venta confirmada'))
                        );
                      },
                    ),
                  if (status == 'Vendida')
                    _buildActionButton(
                      'Detalles',
                      Icons.receipt_long_outlined,
                      Theme.of(context).primaryColor,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ver detalles de venta'))
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 16,
          color: color,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
          ),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          backgroundColor: color.withOpacity(0.1),
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Activa':
        return Icons.check_circle_outline;
      case 'Reservada':
        return Icons.timer_outlined;
      case 'Vendida':
        return Icons.sell_outlined;
      case 'Pausada':
      default:
        return Icons.pause_circle_outline;
    }
  }
}