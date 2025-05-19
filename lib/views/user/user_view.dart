import 'package:flutter/material.dart';
import 'package:offergo/views/common/main_view.dart';

class UserView extends StatelessWidget {
  static const String route = '/user';

  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('User View'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MainView.route);
              },
              child: const Text('Go to Main'),
            ),
          ]
        ),
      ),
    );
  }
}
