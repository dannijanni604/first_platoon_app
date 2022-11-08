import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  FlutterFileView.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const FirtsPlatoon());
}

class FirtsPlatoon extends StatelessWidget {
  const FirtsPlatoon({super.key});

  @override
  Widget build(BuildContext context) {
    // final Color green = Colors.deepOrange;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "montserrat",
        // accentIconTheme: IconThemeData(size: 30),

        iconTheme: IconThemeData(size: 30),

        scaffoldBackgroundColor: Color(0xFFFCFBF4),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.kprimaryColor,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true),
      ),
      home: const SplashView(),
    );
  }
}
