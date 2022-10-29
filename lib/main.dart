import 'package:first_platoon/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const FirtsPlatoon());
}

class FirtsPlatoon extends StatelessWidget {
  const FirtsPlatoon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "montserrat",
        // accentIconTheme: IconThemeData(size: 30),

        iconTheme: IconThemeData(size: 30),

        scaffoldBackgroundColor: Color(0xFFFCFBF4),
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
