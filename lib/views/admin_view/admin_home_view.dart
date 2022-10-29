import 'dart:developer';

import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/views/admin_view/add_new/add_admin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_hitlist_view.dart';
import 'admin_manage_view.dart';
import 'admin_schedule_view.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  int pageIndex = 0;
  final ctrl = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: const [
          AdminScheduleView(),
          AdminHitlistView(),
          AdminManageView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int newIndex) {
          setState(() {
            pageIndex = newIndex;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_up_rounded), label: "Schedule"),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_up_rounded), label: "Hitlist"),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_up_rounded), label: "Manage"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ctrl.fetchMembers();
          appNavPush(context, const AdminAddNew());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
