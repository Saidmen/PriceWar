import 'package:flutter/material.dart';

class UpdatePriceView extends StatefulWidget {
  static const String route = '/update-price';
  const UpdatePriceView({super.key});

  @override
  State<UpdatePriceView> createState() => _UpdatePriceViewState();
}

class _UpdatePriceViewState extends State<UpdatePriceView> {
  final double initialPrice = 100.0;
  final double suggestedPrice = 89.99;
  final int quantity = 12;
  late double newPrice;
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newPrice = initialPrice;
    _priceController.text = newPrice.toStringAsFixed(2);
  }

  void _increasePrice() {
    setState(() {
      newPrice += 1;
      _priceController.text = newPrice.toStringAsFixed(2);
    });
  }

  void _decreasePrice() {
    setState(() {
      if (newPrice > 1) {
        newPrice -= 1;
        _priceController.text = newPrice.toStringAsFixed(2);
      }
    });
  }

  void _onPriceChanged(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed > 0) {
      setState(() {
        newPrice = parsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Oferta de Demanda"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/sneakers.jpg'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _priceInfo("Precio inicial", "\$${initialPrice.toStringAsFixed(2)}"),
                _priceInfo("Sugerido", "\$${suggestedPrice.toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.inventory_2_outlined, color: Colors.black54),
                const SizedBox(width: 8),
                Text(
                  "Cantidad: $quantity",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nuevo precio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.black87),
                  onPressed: _decreasePrice,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onChanged: _onPriceChanged,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.black87),
                  onPressed: _increasePrice,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.price_check_outlined),
                label: const Text(
                  "Pujar nuevo precio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Solicitud enviada: \$${newPrice.toStringAsFixed(2)}'),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}