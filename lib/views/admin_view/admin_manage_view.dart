import 'package:first_platoon/controllers/manage_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminManageView extends StatelessWidget {
  const AdminManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ManageController());
    return Scaffold(
      appBar: AppBar(title: const Text("Manage")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ctrl.isClicked.value = !ctrl.isClicked.value;
              },
              child: Obx(() {
                return Container(
                  width: Get.size.width * 0.95,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  decoration: BoxDecoration(
                      color:
                          ctrl.isClicked.value ? Colors.black12 : Colors.white,
                      border: Border.all(color: Colors.black45)),
                  child: Text("Jake Completed Task", style: Const.labelText()),
                );
              }),
            ),
            Obx(() {
              return SizedBox(
                child: ctrl.isClicked.value
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: Get.size.width * 0.85,
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black45,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  kAppButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(8.0),
                                    label: "Approve",
                                  ),
                                  kAppButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(8.0),
                                    label: "DisApprove",
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Get.size.width * 0.95,
                            padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black45)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Jake Submitted Doucoment",
                                    maxLines: 2, style: Const.labelText()),
                                kAppButton(
                                  onPressed: () {},
                                  label: "View",
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : null,
              );
            }),
          ],
        ),
      ),
    );
  }
}
