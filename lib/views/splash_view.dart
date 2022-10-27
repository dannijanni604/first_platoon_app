import 'package:first_platoon/core/app_navigator.dart';
import 'package:flutter/material.dart';

import 'auth_views/auth_options_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          appNavReplace(context, const AuthOptionsView());
        },
        child: const Center(
          child: Text("F I R S T \nP L A T O O N"),
        ),
      ),
    );
  }
}
