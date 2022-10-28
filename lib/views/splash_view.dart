import 'package:first_platoon/core/app_navigator.dart';
import 'package:flutter/material.dart';

import 'admin_view/auth_views/auth_options_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 3), () => appNavReplace(context, AuthOptionsView()));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Text(
            "F I R S T \n P L A T O O N",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
