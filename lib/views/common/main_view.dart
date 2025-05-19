import 'package:flutter/material.dart';
import 'package:offergo/views/user/user_view.dart';

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
                Navigator.pushNamed(context, UserView.route);
              },
              child: const Text('Go to User'),
            ),
          ],
        ),
      ),
    );
  }
}
