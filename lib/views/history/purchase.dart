import 'package:flutter/material.dart';
import 'package:offergo/views/history/purchase-detail.dart';

class PurchasesView extends StatefulWidget {
  static const String route = '/purchases';

  const PurchasesView({super.key});

  @override
  State<PurchasesView> createState() => _PurchasesViewState();
}

class _PurchasesViewState extends State<PurchasesView> {
  // Control del filtro activo
  String _activeFilter = 'Todas';
  
  // Lista de estados posibles para los filtros
  final List<String> _filters = ['Todas', 'En camino', 'Procesando', 'Completadas'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Mis Compras'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Filtros de compras
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(16),
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

          // Lista de compras filtradas
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Simular diferentes estados para mostrar variedad
                final statuses = ['En camino', 'Procesando pago', 'Entregado', 'Completado'];
                final status = statuses[index % statuses.length];
                
                // Filtrar los elementos según el filtro activo
                if (_activeFilter == 'Todas' || 
                    (_activeFilter == 'En camino' && status == 'En camino') ||
                    (_activeFilter == 'Procesando' && status == 'Procesando pago') ||
                    (_activeFilter == 'Completadas' && (status == 'Entregado' || status == 'Completado'))) {
                  return _buildPurchaseItem(context, index, status);
                } else {
                  return const SizedBox.shrink(); // No mostrar este elemento
                }
              },
              childCount: 20, // Más elementos para mostrar la funcionalidad
            ),
          ),
          
          // Mensaje cuando no hay resultados
          SliverToBoxAdapter(
            child: Builder(builder: (context) {
              // Verificar si hay elementos visibles
              bool hasVisibleItems = false;
              for (int i = 0; i < 20; i++) {
                final statuses = ['En camino', 'Procesando pago', 'Entregado', 'Completado'];
                final status = statuses[i % statuses.length];
                if (_activeFilter == 'Todas' || 
                    (_activeFilter == 'En camino' && status == 'En camino') ||
                    (_activeFilter == 'Procesando' && status == 'Procesando pago') ||
                    (_activeFilter == 'Completadas' && (status == 'Entregado' || status == 'Completado'))) {
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
                          Icons.search_off,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay compras con estado "${_activeFilter}"',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
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

  Widget _buildPurchaseItem(BuildContext context, int index, String status) {
    final date = DateTime.now().subtract(Duration(days: index * 3));
    final dateStr = '${date.day}/${date.month}/${date.year}';
    final isRecent = index < 2;

    // Colores según estado
    Color statusColor;
    switch (status) {
      case 'En camino':
        statusColor = Colors.blue;
        break;
      case 'Entregado':
        statusColor = Colors.green;
        break;
      case 'Procesando pago':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.purple;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PurchaseDetailView.route,
            arguments: index,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 30,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Información del producto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Producto #${1000 + index}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isRecent) Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'NUEVO',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Vendedor: Usuario${1000 + index}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${(index + 1) * 25},00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              dateStr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Barra de estado
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(status),
                      color: statusColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'En camino':
        return Icons.local_shipping;
      case 'Entregado':
        return Icons.check_circle;
      case 'Procesando pago':
        return Icons.payments;
      default:
        return Icons.shopping_bag;
    }
  }
}