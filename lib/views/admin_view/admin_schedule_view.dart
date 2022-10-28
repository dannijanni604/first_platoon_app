import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScheduleView extends StatelessWidget {
  const AdminScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ScheduleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
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
                    width: Get.size.width * 0.95,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color:
                          ctrl.isClicked.value ? Colors.black12 : Colors.white,
                      border: Border.all(color: Colors.black),
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
                            Text("Example Duty", style: Const.label()),
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
                      ? Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          height: Get.size.height * 0.2,
                          width: Get.size.width * 0.85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Name of duty person "),
                              Text("Detail of duty person "),
                              Text("Date and time of example duty"),
                              Text("Salery detail of duty  person"),
                            ],
                          ),
                        )
                      : null,
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
