import 'package:flutter/material.dart';

class QualificationSeller extends StatefulWidget {
  static const String route = '/qualification-seller';
  const QualificationSeller({super.key});

  @override
  State<QualificationSeller> createState() => _QualificationSellerState();
}

class _QualificationSellerState extends State<QualificationSeller> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Califica al vendedor'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Cómo calificarías al vendedor?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              onPressed: _rating > 0
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('¡Gracias por calificar con $_rating estrellas!'),
                          backgroundColor: Colors.black,
                        ),
                      );
                    }
                  : null,
              child: const Text('Enviar calificación'),
            ),
          ],
        ),
      ),
    );
  }
}