import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScheduleView extends StatelessWidget {
  const AddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final ctrl = Get.put(AddCompaignsConteroller());
    final sctrl = Get.put(ScheduleController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: ctrl.scheduleformkey,
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
                  DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2201));

                  ctrl.scheduledateController.text =
                      dateTime.toString().substring(0, 11);
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
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                controller: ctrl.scheduleMemberController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Add at least 1 Member";
                  } else {
                    return null;
                  }
                },
                onChanged: (v) {
                  sctrl.findMember(v);
                },
              ),
              Obx(() {
                return Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sctrl.members.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            sctrl.members[index],
                          ),
                        );
                      }),
                );
              }),
              Center(
                child: Column(
                  children: [
                    kAppButton(
                      onPressed: () {
                        ctrl.addSchedule();
                      },
                      label: "Generate Schedule",
                      padding: EdgeInsets.all(10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
