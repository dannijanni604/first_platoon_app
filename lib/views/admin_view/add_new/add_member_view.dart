import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMemberView extends StatelessWidget {
  const AddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final ctrl = Get.put(AddCompaignsConteroller());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: ctrl.memberformkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Member Name"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.memberNameController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Member Name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              const Text("Generate Code"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.genetrateCodeController,
                validator: (val) {
                  return Const.validateCode(val!);
                },
              ),
              SizedBox(height: size.height * 0.37),
              Obx(() {
                return Center(
                  child: ctrl.indicator.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            kAppButton(
                              onPressed: () {
                                ctrl.addMember();
                              },
                              label: "Generate User",
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
