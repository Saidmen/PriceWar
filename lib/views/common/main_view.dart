import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  static const String route = '/main';

  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Main View'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
              child: const Text('Go to User'),
            ),
          ],
        ),
      ),
    );
  }
}
