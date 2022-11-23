import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTasksView extends StatelessWidget {
  AddTasksView({super.key});

  final ctrl = Get.put(AddCompaignsConteroller());
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: ctrl.taskformkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Task"),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                controller: ctrl.taskTaskController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Task Name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text("Due Date"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.taskdueDateController,
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2201));

                  ctrl.taskdueDateController.text =
                      dateTime.toString().substring(0, 11);
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Due Date";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              const Text("Add Members"),
              SizedBox(
                height: size.height * 0.01,
              ),
              Obx(() {
                return Wrap(
                  spacing: 2,
                  runSpacing: -3,
                  children: [
                    ...ctrl.taskMembers
                        .map(
                          (e) => Chip(
                            onDeleted: () {
                              ctrl.taskMembers.remove(e);
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
                controller: ctrl.taskMemberController,
                onChanged: (v) {
                  ctrl.searchMember(v.toLowerCase());
                },
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 200,
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
                                bool already = ctrl.taskMembers
                                    .any((m) => m['id'] == e['id']);
                                if (!already) {
                                  ctrl.taskMembers.add(e);
                                }
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
                  onLoading: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Center(
                child: Obx(() {
                  return ctrl.indicator.value
                      ? CircularProgressIndicator()
                      : Column(
                          children: [
                            kAppButton(
                              onPressed: () {
                                ctrl.addTask();
                              },
                              label: "Generate Task",
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            SizedBox(height: size.height * 0.04),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                ))
                          ],
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
