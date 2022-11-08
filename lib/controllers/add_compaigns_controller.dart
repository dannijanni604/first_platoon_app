import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCompaignsConteroller extends GetxController with StateMixin {
  @override
  void onInit() {
    super.onInit();
  }

  RxBool indicator = false.obs;
  RxList<Map<String, dynamic>> members = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> scheduleMembers =
      RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> taskMembers = RxList<Map<String, dynamic>>([]);

// Schedule
  final scheduleTaskController = TextEditingController();
  final scheduledateController = TextEditingController();
  DateTime? scheduledDateTime;
  final scheduleMemberController = TextEditingController();
  final scheduleformkey = GlobalKey<FormState>();
  // get scheduleformkey => _scheduleformkey;

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

  Future addSchedule() async {
    indicator(true);
    try {
      await DB.schedules.doc().set(
        {
          'task': scheduleTaskController.text,
          'date': scheduledDateTime,
          'members': FieldValue.arrayUnion(scheduleMembers),
        },
      );
      ksucessSnackbar(message: "Schedule Added Successfuly");
      scheduleTaskController.clear();
      // scheduledateController = DateTime.now();
      scheduleMemberController.clear();
      scheduleMembers.clear();
    } on Exception catch (e) {
      kerrorSnackbar(message: e.toString());
      indicator(false);
    } finally {
      indicator(false);
    }
  }

  Future addTask() async {
    if (_taskformkey.currentState!.validate()) {
      if (taskMembers.isNotEmpty) {
        indicator(true);
        try {
          await DB.tasks.doc().set(
            {
              'task': taskTaskController.text,
              'due_date': taskdueDateController.text,
              'members': FieldValue.arrayUnion(taskMembers),
            },
          );
          ksucessSnackbar(message: "Task Added Successfully");
          taskTaskController.clear();
          taskdueDateController.clear();
          taskMemberController.clear();
        } on Exception catch (e) {
          kerrorSnackbar(message: e.toString());
          indicator(false);
        } finally {
          indicator(false);
        }
      } else {
        kerrorSnackbar(message: "Enter Task Member List");
      }
    }
  }

  Future addMember() async {
    if (_memberformkey.currentState!.validate()) {
      indicator(true);
      try {
        bool isUserExist = await DB.members
            .where('member', isEqualTo: memberNameController.text.toLowerCase())
            .get()
            .then<bool>((value) {
          if (value.docs.isNotEmpty) {
            return true;
          }
          return false;
        });
        bool isCodeExist = await DB.members
            .where('member', isEqualTo: memberNameController.text.toLowerCase())
            .get()
            .then<bool>((value) {
          if (value.docs.isNotEmpty) {
            return true;
          }
          return false;
        });
        if (isUserExist || isCodeExist) {
          return kerrorSnackbar(message: "User Name Or Password Already Exist");
        } else {
          DB.members.doc().set(
            {
              'name': memberNameController.text.toLowerCase(),
              'name_search_terms': getSearchTerms(memberNameController.text),
              'code': genetrateCodeController.text,
              'created_at': DateTime.now(),
              'id': DB.members.doc().id,
            },
          );
          memberNameController.clear();
          genetrateCodeController.clear();
          ksucessSnackbar(message: "Code Generated Successfuly");
        }
      } on Exception catch (e) {
        indicator(false);
        kerrorSnackbar(message: e.toString());
      } finally {
        indicator(false);
      }
    }
  }

  Timer? timeHandle;
  Future searchMember(String text) async {
    try {
      if (timeHandle != null) {
        timeHandle?.cancel();
      }
      timeHandle = Timer(const Duration(milliseconds: 700), () async {
        members.clear();
        members.clear();
        change(members, status: RxStatus.loading());
        QuerySnapshot<Map<String, dynamic>> doc = await DB.members
            .where('name_search_terms', arrayContains: text)
            .get();
        if (doc.docs.isNotEmpty) {
          for (var element in doc.docs) {
            members.add({
              'name': element.data()['name'],
              'id': element.data()['id'],
            });
          }
        }
        change(members, status: RxStatus.success());
      });
    } catch (e) {
      change(members, status: RxStatus.error(e.toString()));
    }
  }

  List<String> getSearchTerms(String string) {
    List<String> searchList = [];
    String temp = "";
    for (int i = 0; i < string.length; i++) {
      temp = temp + string[i];
      searchList.add(temp.toLowerCase());
    }
    return searchList;
  }
}
