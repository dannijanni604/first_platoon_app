import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/core/db.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  @override
  void onInit() async {
    await fetchMembers();
    super.onInit();
  }

  RxBool isClicked = false.obs;
  // RxList<String> membersList = RxList<String>([]);
  RxList<String> members = RxList<String>([]);
  RxList<String> membersCopyList = RxList<String>([]);

  Future? findMember(String val) async {
    String txt = val.toLowerCase();
    if (txt.isEmpty) {
      log("Empty Text");
      members(membersCopyList);
      log(members.toString());
    } else {
      log("else");
      log(txt);
      log(members.toString());
      members.value = membersCopyList.where((e) {
        bool? isfind = e != null && e.toLowerCase().contains(txt);
        if (isfind) {
          log("find");
          return true;
        } else {
          log(" not find");

          return false;
        }
      }).toList();
      update();
    }
  }

  Future fetchMembers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> doc = await DB.members.get();
      if (doc.docs.isNotEmpty) {
        doc.docs.forEach((element) {
          members.add(element.data()['member']);
          log(members.toString());
        });
      } else {
        log("Members List is Empty");
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
