import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/controllers/manage_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/views/admin_view/admin_files_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminManageView extends StatelessWidget {
  const AdminManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ManageController());
    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: false, title: const Text("Manage")),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: DB.completedTask
              .where('status', isEqualTo: "processing")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (((context, index) {
                  return appTile(
                    onpress: () {
                      showDialogToCompleteTask(context, index, ctrl, snapshot);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data!.docs[index].data()['task']),
                            Text(snapshot.data!.docs[index]
                                .data()['submited_date']
                                .toDate()
                                .toString()
                                .substring(0, 19)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              ' Submited By ${snapshot.data!.docs[index].data()['submited_by'].toString().toUpperCase().capitalizeFirst}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })),
              );
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
    );
  }
}

Future showDialogToCompleteTask(
  BuildContext context,
  int index,
  ManageController ctrl,
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
) async {
  showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: Get.size.height / 4,
            horizontal: Get.size.width * 0.05,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black45,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      kAppButton(
                          onPressed: () {
                            DB.completedTask
                                .doc(snapshot.data!.docs[index].id)
                                .update({
                              'status': "approved",
                            });
                            ksucessSnackbar(
                              message: "Approved",
                            );
                          },
                          label: "Approve",
                          color: Colors.green.shade400),
                      kAppButton(
                          onPressed: () {
                            DB.completedTask
                                .doc(snapshot.data!.docs[index].id)
                                .update({
                              'status': "disapproved",
                            });
                            kerrorSnackbar(message: "disapproved");
                          },
                          label: "DisApprove",
                          color: Colors.red.shade400),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black45)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${snapshot.data!.docs[index].data()['submited_by'].toString().toUpperCase().capitalizeFirst}"
                        " Submitted Doucoment",
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    kAppButton(
                      onPressed: () {
                        var urls =
                            snapshot.data!.docs[index].data()['decoments'];
                        Get.to(
                          () => DocumentView(decoments: urls, ctrl: ctrl),
                        );
                      },
                      label: "View",
                    ),
                  ],
                ),
              ),
              kAppButton(
                onPressed: () {
                  Get.back();
                },
                label: "Back",
              ),
            ],
          ),
        );
      });
}
