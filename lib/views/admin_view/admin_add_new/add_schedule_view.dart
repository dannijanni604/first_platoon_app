import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScheduleView extends StatelessWidget {
  const AddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final ctrl = Get.put(AddCompaignsConteroller());

    final _key = GlobalKey<FormState>();
    // final sctrl = Get.put(ScheduleController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Task"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.scheduleTaskController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Add Task";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text("Date"),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                controller: ctrl.scheduledateController,
                onTap: () async {
                  ctrl.scheduledDateTime = await dateTimeRangePicker(context);
                  ctrl.scheduledateController.text =
                      ctrl.scheduledDateTime.toString();
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Date";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text("Add Members"),
              Obx(() {
                return Wrap(
                  spacing: 2,
                  runSpacing: -3,
                  children: [
                    ...ctrl.scheduleMembers
                        .map(
                          (e) => Chip(
                            onDeleted: () {
                              ctrl.scheduleMembers.remove(e);
                              // ctrl.scheduleMembers.value =
                              //     ctrl.scheduleMembers.toSet().toList();
                            },
                            label: Text(e['name']),
                          ),
                        )
                        .toList(),
                  ],
                );
              }),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "search members here",
                ),
                controller: ctrl.scheduleMemberController,
                onChanged: (v) {
                  ctrl.searchMember(v.toLowerCase());
                },
              ),
              Container(
                height: 200,
                // margin: EdgeInsets.symmetric(vertical: 10),
                // padding: EdgeInsets.all(10),
                child: ctrl.obx(
                  (state) {
                    if (ctrl.members.isNotEmpty) {
                      return Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: -3,
                        children: [
                          ...ctrl.members.map((e) {
                            return Chip(
                              onDeleted: () {
                                ctrl.scheduleMembers.add(e);
                              },
                              deleteIcon: Icon(Icons.add, size: 20),
                              padding: EdgeInsets.all(1),
                              label: Text(
                                e['name'],
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }
                    return const Center(
                      child: Text("No User"),
                    );
                  },
                  onEmpty: const Center(
                    child: Text("Search by typing"),
                  ),
                  onLoading: Center(child: CircularProgressIndicator()),
                ),
              ),
              Obx(() {
                return Center(
                  child: ctrl.indicator.value
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            kAppButton(
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  if (ctrl.scheduleMembers.isNotEmpty) {
                                    ctrl.addSchedule();
                                  } else {
                                    kerrorSnackbar(message: "Add Members List");
                                  }
                                }
                              },
                              label: "Generate Schedule",
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                ))
                          ],
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
