import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCompaignsConteroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxBool indicator = false.obs;

// Schedule
  final scheduleTaskController = TextEditingController();
  final scheduledateController = TextEditingController();
  final scheduleMemberController = TextEditingController();
  final _scheduleformkey = GlobalKey<FormState>();
  get scheduleformkey => _scheduleformkey;

  // Task
  final taskTaskController = TextEditingController();
  final taskdueDateController = TextEditingController();
  final taskMemberController = TextEditingController();
  final _taskformkey = GlobalKey<FormState>();
  get taskformkey => _taskformkey;

  // Add Member

  final memberNameController = TextEditingController();
  final genetrateCodeController = TextEditingController();
  final _memberformkey = GlobalKey<FormState>();
  get memberformkey => _memberformkey;

  addSchedule() {
    if (_memberformkey.currentState!.validate()) {
      indicator(true);
      try {
        DB.schedules.doc().set(
          {
            'task': scheduleTaskController.text,
            'date': scheduledateController.text,
            'members': scheduleMemberController.text,
          },
        );
      } on Exception catch (e) {
        kerrorSnackbar(message: e.toString());
        indicator(false);
      } finally {
        indicator(false);
        scheduleTaskController.clear();
        scheduledateController.clear();
        scheduleMemberController.clear();
      }
    }
  }

  addTask() {
    if (_taskformkey.currentState!.validate()) {
      indicator(true);
      try {
        DB.tasks.doc().set(
          {
            'task': taskTaskController.text,
            'due_date': taskdueDateController.text,
            'members': taskMemberController.text,
          },
        );
        ksucessSnackbar(message: "Task Added Successfully");
      } on Exception catch (e) {
        kerrorSnackbar(message: e.toString());
        indicator(false);
      } finally {
        indicator(false);
        taskTaskController.clear();
        taskdueDateController.clear();
        taskMemberController.clear();
      }
    }
  }

  addMember() async {
    if (_memberformkey.currentState!.validate()) {
      indicator(true);
      try {
        await DB.members.doc().set(
          {
            'member': memberNameController.text,
            'code': genetrateCodeController.text,
            'date': DateTime.now(),
          },
        );
        ksucessSnackbar(message: "Code Generated Successfuly");
      } on Exception catch (e) {
        indicator(false);
        kerrorSnackbar(message: e.toString());
      } finally {
        memberNameController.clear();
        genetrateCodeController.clear();
        indicator(false);
      }
    }
  }
}
