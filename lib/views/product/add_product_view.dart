import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  static const String route = '/product';

  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Food',
    'Furniture',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Añadir Demanda',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.black, // AppBar negro
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Detalle del Producto",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Image uploader
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Añade una imagen',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'Toca para explorar',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Product name
                _buildTextField(
                  controller: _nameController,
                  label: 'Nombre del Producto',
                  icon: Icons.shopping_bag_outlined,
                  hint: 'Ingresa el nombre del producto',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Nombre del producto requerido' : null,
                ),
                const SizedBox(height: 18),

                // Description
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Descripción',
                  icon: Icons.description_outlined,
                  hint: 'Ingresa la descripción del producto',
                  maxLines: 3,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Descripción requerida' : null,
                ),
                const SizedBox(height: 18),

                // Price and Stock
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _priceController,
                        label: 'Precio',
                        icon: Icons.attach_money_rounded,
                        hint: 'Ingresa el precio',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Requerido';
                          if (double.tryParse(v) == null) return 'Número inválido';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _stockController,
                        label: 'Cantidad',
                        icon: Icons.inventory_2_outlined,
                        hint: 'Ingresa la cantidad',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Requerido';
                          if (int.tryParse(v) == null) return 'Número inválido';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Dropdown
                _buildDropdown(),
                const SizedBox(height: 36),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Producto guardado con éxito'),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.save_outlined),
                    label: const Text(
                      'GUARDAR DEMANDA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black87),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.category, color: Colors.black87),
        labelText: 'Category',
        labelStyle: const TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      items: _categories
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category, style: const TextStyle(color: Colors.black)),
              ))
          .toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator: (value) =>
          value == null ? 'Please select a category' : null,
    );
  }
}