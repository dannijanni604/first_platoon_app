import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScheduleView extends StatelessWidget {
  const AdminScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ScheduleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
      ),
      body: StreamBuilder(
        stream: DB.members.snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Timestamp date = snapshot.data!.docs[index].data()['date'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ctrl.isClicked.value = !ctrl.isClicked.value;
                        },
                        child: Obx(() {
                          return Container(
                            width: Get.size.width * 0.95,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              color: ctrl.isClicked.value
                                  ? Colors.black12
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(date
                                        .toDate()
                                        .toString()
                                        .substring(0, 10)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        snapshot.data!.docs[index]
                                            .data()['member'],
                                        style: Const.labelText()),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return SizedBox(
                          child: ctrl.isClicked.value
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  height: Get.size.height * 0.2,
                                  width: Get.size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text("Name of duty person "),
                                      Text("Detail of duty person "),
                                      Text("Date and time of example duty"),
                                      Text("Salery detail of duty  person"),
                                    ],
                                  ),
                                )
                              : null,
                        );
                      })
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
