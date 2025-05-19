import 'package:flutter/material.dart';
import 'package:offergo/views/common/main_view.dart';

import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OfferGo',

      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: MainView.route,
    );
  }
}
