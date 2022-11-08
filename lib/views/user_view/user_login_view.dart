import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginView extends StatelessWidget {
  const UserLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final ctrl = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                  ),
                ),
                SizedBox(height: Get.size.height * 0.03),
                Text("Welcome To First Platoon", style: Const.labelText()),
                SizedBox(height: Get.size.height * 0.03),
                const Text("Login By Code That Provide You By Admin"),
                SizedBox(height: Get.size.height * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("Name"),
                      // SizedBox(height: Get.size.height * 0.01),
                      // TextFormField(
                      //   validator: (val) {
                      //     if (val == null || val.isEmpty) {
                      //       return "Enter User Name";
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      SizedBox(height: Get.size.height * 0.03),
                      Text("Enter Code"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.userCodecontroller,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Code To Login";
                          } else {
                            return null;
                          }
                        },
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 20, horizontal: 20),
                      //       child: Text(
                      //         "Go Back",
                      //         style: TextStyle(
                      //           color: Colors.blue,
                      //           decoration: TextDecoration.underline,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: Get.size.height * 0.08),
                      Center(
                        child: kAppButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ctrl.loginAsUser(context);
                            }
                          },
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          label: "Login",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
