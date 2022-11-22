import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/admin_view/admin_add_new/add_admin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_hitlist_view.dart';
import 'admin_manage/admin_manage_tabs.dart';
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: const [
            AdminScheduleView(),
            AdminHitlistView(),
            AdminManageTabsView(),
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
                icon: Icon(Icons.arrow_circle_up_rounded), label: "Task"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded), label: "Manage"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          onPressed: () async {
            appNavPush(context, const AdminAddNew());
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
