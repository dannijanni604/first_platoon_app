import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/controllers/hitlist_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHitlistView extends StatelessWidget {
  const UserHitlistView({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.kblueColor,
          automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(
                text: "Non Submitted Task",
              ),
              Tab(
                text: "Submited Task",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NonSubmittedTaskView(),
            SubmittedTaskView(),
          ],
        ),
      ),
    );
  }
}

class SubmittedTaskView extends StatelessWidget {
  const SubmittedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HitlistController());

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.completedTask
          .orderBy('submited_date', descending: true)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                List<dynamic> decoments =
                    snapshot.data!.docs[index].data()['decoments'];
                return appTile(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data!.docs[index].data()['task']),
                          Text(snapshot.data!.docs[index]
                              .data()['submited_date']
                              .toDate()
                              .toString()),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status :", style: Const.labelText()),
                          Text(
                            '${snapshot.data!.docs[index].data()['status']}',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class NonSubmittedTaskView extends StatelessWidget {
  const NonSubmittedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HitlistController());

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.schedules.snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return appTile(
                  onpress: () {
                    showUserHitlitBottomSheet(
                      context: context,
                      task: snapshot.data!.docs[index].data()['task'],
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text(snapshot.data!.docs[index].data()['task'],
                          style: Const.labelText()),
                    ],
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

showUserHitlitBottomSheet({
  BuildContext? context,
  String? task,
}) {
  final ctrl = Get.put(HitlistController());

  return showModalBottomSheet(
      context: context!,
      builder: (context) {
        return Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Add Decoments For ${task}",
                            style: Const.labelText())),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.cancel_outlined),
                    )
                  ],
                ),
                Container(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              ctrl.picDocuments();
                            },
                            icon: Icon(
                              Icons.image,
                              color: Colors.deepOrange.withOpacity(0.5),
                            ),
                          ),
                        ),
                        ...ctrl.pickedFile.map((i) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            height: 200,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(i.path))),
                            ),
                            child: Text(
                              i.path
                                  .split(
                                    '.',
                                  )
                                  .last,
                              style: const TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                ctrl.isClicked.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : kAppButton(
                        onPressed: () {
                          ctrl.onUserCompleteTask(
                            task: task!,
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        label: "Submit Task"),
              ],
            ),
          );
        });
      });
}
