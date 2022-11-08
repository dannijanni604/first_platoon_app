import 'dart:developer';

import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/views/admin_view/add_new/add_schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTasksView extends StatelessWidget {
  const AddTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AddCompaignsConteroller());
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
                              // ctrl.taskMembers.value =
                              //     ctrl.taskMembers.toSet().toList();
                            },
                            label: Text('${e['name']}${e['id']}'),
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
                height: 200,
                child: ctrl.obx(
                  (state) {
                    if (ctrl.members.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: ctrl.members.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Chip(
                              onDeleted: () {
                                ctrl.taskMembers.add(ctrl.members[index]);
                              },
                              deleteIcon: Icon(Icons.add, size: 20),
                              padding: EdgeInsets.all(1),
                              label: Text(
                                '${ctrl.members[index]['name']}${ctrl.members[index]['id']}',
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: Text("No User"),
                    );
                  },
                  onEmpty: const Center(
                    child: Text("Search by typing"),
                  ),
                  onLoading: Center(child: Text("")),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    kAppButton(
                      onPressed: () {
                        ctrl.addTask();
                      },
                      label: "Generate Task",
                      padding: EdgeInsets.all(10),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
