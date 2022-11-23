import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/controllers/admin_controller.dart';
import 'package:first_platoon/controllers/hitlist_controller.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHitlistView extends StatelessWidget {
  AdminHitlistView({super.key});

  final adminCtrl = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HitlistController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Task"),
      ),
      body: StreamBuilder(
        stream: DB.tasks
            .where('doc_id', isEqualTo: adminCtrl.admin.groupId)
            .where('status', isNull: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text("No Task"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      List<String> members = List.from(
                              snapshot.data!.docs[index].data()['members'])
                          .cast<String>();
                      String task = snapshot.data!.docs[index].data()['task'];

                      return appTile(
                        onpress: () {
                          showMembersBottomSheet(
                            context: context,
                            members: members,
                            task: task,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(task, style: Const.labelText()),
                            ),
                            Text(snapshot.data!.docs[index]
                                .data()['due_date']
                                .toString()
                                .substring(0, 11)),
                          ],
                        ),
                      );
                    });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
