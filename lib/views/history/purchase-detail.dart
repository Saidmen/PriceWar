import 'package:flutter/material.dart';

class PurchaseDetailView extends StatelessWidget {
  static const String route = '/purchase-detail';
  
  // Recibir el ID de la compra como parámetro
  final int purchaseId;
  
  const PurchaseDetailView({
    super.key, 
    required this.purchaseId,
  });

  @override
  Widget build(BuildContext context) {
    final status = ['En camino', 'Procesando pago', 'Entregado', 'Completado'][purchaseId % 4];
    final price = (purchaseId % 10 + 1) * 25.00;
    final date = DateTime.now().subtract(Duration(days: purchaseId * 3));
    final dateStr = '${date.day}/${date.month}/${date.year}';
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Compra #${1000 + purchaseId}'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compartir detalles de compra'))
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(context, status),
            
            // Información del producto
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen del producto
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Detalles del producto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Producto #${1000 + purchaseId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Vendedor: Usuario${1000 + purchaseId}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Proceso de seguimiento
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seguimiento',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineStep(
                    context, 
                    'Pedido realizado', 
                    'El $dateStr', 
                    true,
                    Icons.shopping_cart_outlined,
                  ),
                  _buildTimelineStep(
                    context, 
                    'Pago procesado', 
                    'El ${date.add(const Duration(days: 1)).day}/${date.month}/${date.year}', 
                    status != 'Procesando pago',
                    Icons.payment,
                  ),
                  _buildTimelineStep(
                    context, 
                    'En camino', 
                    'El ${date.add(const Duration(days: 2)).day}/${date.month}/${date.year}', 
                    status == 'En camino' || status == 'Entregado' || status == 'Completado',
                    Icons.local_shipping,
                  ),
                  _buildTimelineStep(
                    context, 
                    'Entregado', 
                    status == 'Entregado' || status == 'Completado' 
                        ? 'El ${date.add(const Duration(days: 4)).day}/${date.month}/${date.year}'
                        : 'Pendiente', 
                    status == 'Entregado' || status == 'Completado',
                    Icons.check_circle,
                    isLast: status != 'Completado',
                  ),
                  if (status == 'Completado')
                    _buildTimelineStep(
                      context, 
                      'Completado', 
                      'El ${date.add(const Duration(days: 14)).day}/${date.month}/${date.year}', 
                      true,
                      Icons.verified,
                      isLast: true,
                    ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Información de envío
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detalles de envío',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    context,
                    'Dirección:',
                    'Calle Principal #123, Ciudad'
                  ),
                  _buildInfoRow(
                    context,
                    'Método de envío:',
                    'Envío estándar'
                  ),
                  if (status == 'En camino')
                    _buildInfoRow(
                      context,
                      'Número de seguimiento:',
                      'TRACK${1000000 + purchaseId}',
                      isTrackingCode: true,
                    ),
                ],
              ),
            ),
            
            // Información de pago
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detalles de pago',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    context,
                    'Método de pago:',
                    'Tarjeta terminada en 1234'
                  ),
                  _buildInfoRow(
                    context,
                    'Subtotal:',
                    '\$${price.toStringAsFixed(2)}'
                  ),
                  _buildInfoRow(
                    context,
                    'Envío:',
                    '\$5.00'
                  ),
                  _buildInfoRow(
                    context,
                    'Total:',
                    '\$${(price + 5.0).toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            
            // Acciones
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.message_outlined),
                    label: const Text('Contactar al vendedor'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contactando al vendedor...'))
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  if (status == 'Entregado')
                    OutlinedButton.icon(
                      icon: const Icon(Icons.star_border),
                      label: const Text('Valorar producto'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        padding: const EdgeInsets.all(12),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Valorando producto...'))
                        );
                      },
                    ),
                  const SizedBox(height: 12),
                  if (status != 'Completado')
                    OutlinedButton.icon(
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Reportar un problema'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.all(12),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reportando problema...'))
                        );
                      },
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusHeader(BuildContext context, String status) {
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
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: statusColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getStatusIcon(status),
            color: statusColor,
            size: 24,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estado: $status',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _getStatusDescription(status),
                style: TextStyle(
                  color: statusColor.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  String _getStatusDescription(String status) {
    switch (status) {
      case 'En camino':
        return 'Tu pedido está en ruta hacia tu domicilio';
      case 'Entregado':
        return 'Tu pedido ha sido entregado con éxito';
      case 'Procesando pago':
        return 'Estamos verificando tu pago';
      case 'Completado':
        return 'Esta transacción ha sido completada';
      default:
        return '';
    }
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
        return Icons.verified;
    }
  }
  
  Widget _buildTimelineStep(
    BuildContext context, 
    String title, 
    String subtitle, 
    bool isCompleted,
    IconData icon, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey.shade300,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.grey.shade500,
                size: 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: isCompleted 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCompleted 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: isLast ? 0 : 16),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(
    BuildContext context, 
    String label, 
    String value, {
    bool isTrackingCode = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: isTrackingCode
                ? GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Seguimiento: $value'))
                      );
                    },
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: TextStyle(
                      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                      fontSize: isTotal ? 16 : 14,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}