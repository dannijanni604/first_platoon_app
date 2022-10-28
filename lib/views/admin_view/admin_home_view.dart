import 'package:first_platoon/core/app_navigator.dart';
import 'package:flutter/material.dart';

import 'add_new/add_admin_view.dart';
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
        onPressed: () {
          appNavPush(context, const AdminAddNew());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
