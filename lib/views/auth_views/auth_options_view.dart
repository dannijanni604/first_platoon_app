import 'package:first_platoon/core/app_navigator.dart';
import 'package:flutter/material.dart';
import '../admin_views/admin_home_view.dart';
import '../user_views/user_home_view.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  appNavReplace(context, const AdminHomeView());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(05))),
                child: const Text("Admin"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  appNavReplace(context, const UserHomeView());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(05))),
                child: const Text("User"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
