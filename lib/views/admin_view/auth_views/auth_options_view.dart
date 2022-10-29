import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../admin_home_view.dart';
import '../../user_view/user_home_view.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.size.width / 1.05,
              child: ElevatedButton(
                onPressed: () async {
                  await ctrl.login();
                  appNavReplace(context, const AdminHomeView());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  fixedSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Login As Admin",
                  style: Const.labelText(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: Get.size.height / 20),
            Text("- - - - - Or - - - - -"),
            SizedBox(height: Get.size.height / 20),
            SizedBox(
              width: Get.size.width / 1.05,
              child: ElevatedButton(
                onPressed: () {
                  appNavReplace(context, const UserHomeView());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  fixedSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Login As User",
                  style: Const.labelText(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
