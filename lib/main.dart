import 'package:first_platoon/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FirtsPlatoon());
}

class FirtsPlatoon extends StatelessWidget {
  const FirtsPlatoon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: const AppBarTheme(elevation: 0),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true),
      ),
      home: const SplashView(),
    );
  }
}
