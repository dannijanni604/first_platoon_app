import 'package:first_platoon/controllers/hitlist_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/views/user_view/submit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHitlistView extends StatelessWidget {
  const UserHitlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final ctrl = Get.put(HitlistController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hit List"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        children: [
          // for (int i = 0; i < 5; i++)
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  ctrl.isClicked.value = !ctrl.isClicked.value;
                },
                child: Obx(() {
                  return Container(
                    height: size.height * 0.1,
                    width: size.width * 0.97,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          ctrl.isClicked.value ? Colors.black12 : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text("Nov  25-29"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Example Duty",
                              style: Const.labelText(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return SizedBox(
                  child: ctrl.isClicked.value
                      ? GestureDetector(
                          onTap: () {
                            ctrl.isComplete.value = !ctrl.isComplete.value;
                            ksucessSnackbar(message: "Completed Successfully");
                          },
                          child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.95,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.025,
                                    width: size.width * 0.050,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: ctrl.isComplete.value
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  const Text("Complete")
                                ],
                              )),
                        )
                      : null,
                );
              })
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Submit"),
        onPressed: () {
          appNavPush(context, const SubmitView());
        },
      ),
    );
  }
}
