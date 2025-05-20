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

  final List<String> _categories = ['Electronics', 'Clothing', 'Food', 'Furniture', 'Other'];

  // Move to viewmodel
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
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
      title: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: const Color(0xFF4F68F7),
      elevation: 0,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
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
          color: Colors.black,
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
          // Section title
          const Text(
            "Product Details",
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 20),
          
          // IMAGE
          GestureDetector(
            onTap: () {}, // Image picker function
            child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200, width: 2),
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.grey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                ),
                child: Icon(Icons.add_photo_alternate_rounded, size: 50, color: Colors.blue.shade400),
              ),
              const SizedBox(height: 12),
              Text(
                'Upload product image',
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                ),
              ),
              Text(
                'Tap to browse',
                style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                ),
              ),
              ],
            ),
            ),
          ),

          const SizedBox(height: 28),

          _buildTextField(
            controller: _nameController,
            label: 'Product Name',
            icon: Icons.shopping_bag_outlined,
            hint: 'Enter product name',
            validator: (v) => v == null || v.isEmpty ? 'Product name required' : null,
          ),
          const SizedBox(height: 18),

          _buildTextField(
            controller: _descriptionController,
            label: 'Description',
            icon: Icons.description_outlined,
            hint: 'Enter product description',
            maxLines: 3,
            validator: (v) => v == null || v.isEmpty ? 'Description required' : null,
          ),
          const SizedBox(height: 18),

          Row(
            children: [
            Expanded(
              child: _buildTextField(
              controller: _priceController,
              label: 'Price',
              icon: Icons.attach_money_rounded,
              hint: 'Enter price',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (double.tryParse(v) == null) return 'Invalid number';
                return null;
              },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
              controller: _stockController,
              label: 'Stock',
              icon: Icons.inventory_2_outlined,
              hint: 'Enter quantity',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (int.tryParse(v) == null) return 'Invalid number';
                return null;
              },
              ),
            ),
            ],
          ),
          const SizedBox(height: 18),

          _buildDropdown(),
          const SizedBox(height: 36),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: const Text('Product saved successfully'),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F68F7),
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.save_outlined),
            label: const Text(
              'SAVE PRODUCT',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            ),
          )
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
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF9FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.category),
        labelText: 'Category',
        filled: true,
        fillColor: const Color(0xFFF9FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: _categories
          .map((category) => DropdownMenuItem(value: category, child: Text(category)))
          .toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }
}
