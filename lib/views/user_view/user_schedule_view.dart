import 'dart:developer';
import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserScheduleView extends StatelessWidget {
  const UserScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ScheduleController());
    final id = GetStorage().read("id");
    log(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.kblueColor,
        automaticallyImplyLeading: false,
        title: const Text("Schedule"),
        actions: [
          IconButton(
              onPressed: () {
                GetStorage().erase();
                appNavReplace(context, const AuthOptionsView());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: DB.schedules.where('members.id', arrayContains: id).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            // return Text(snapshot.data!.docs.length.toString());
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  List<dynamic> members =
                      snapshot.data!.docs[index].data()['members'];

                  return appTile(
                    onpress: () {
                      showMembersBottomSheet(
                          context: context,
                          members: members,
                          task: snapshot.data!.docs[index].data()['task']);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(snapshot.data!.docs[index]
                                .data()['date']
                                .toDate()
                                .toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                snapshot.data!.docs[index]
                                    .data()['task']
                                    .toString(),
                                style: Const.labelText()),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
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
