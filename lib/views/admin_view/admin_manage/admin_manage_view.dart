import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/controllers/manage_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/views/admin_view/admin_manage/admin_document_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminManageTaskView extends StatelessWidget {
  const AdminManageTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ManageController());
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: DB.tasks
            .where('status', isEqualTo: "processing")
            .where('doc_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text("No Task"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (((context, index) {
                      return appTile(
                        onpress: () {
                          showDialogToCompleteTask(
                              context, index, ctrl, snapshot);
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.docs[index].data()['task']),
                                Text(snapshot.data!.docs[index]
                                    .data()['submitted_at']
                                    .toDate()
                                    .toString()
                                    .substring(0, 19)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                    ' Submited by : ${snapshot.data!.docs[index].data()['submitted_by'].toString().toUpperCase().capitalizeFirst} '),
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
        });
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
          padding: EdgeInsets.all(20),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.size.height * 0.02),
              Row(
                children: [
                  Text(
                    "Task :",
                    maxLines: 2,
                    style: Const.labelText(),
                  ),
                  Text(
                    " ${snapshot.data!.docs[index].data()['task']}",
                    maxLines: 2,
                  ),
                ],
              ),
              SizedBox(height: Get.size.height * 0.01),
              Row(
                children: [
                  Text(
                    "Submited By : ",
                    style: Const.labelText(),
                  ),
                  Text(
                      " ${snapshot.data!.docs[index].data()['submitted_by'].toString().toUpperCase().capitalizeFirst}")
                ],
              ),
              SizedBox(height: Get.size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("Documents :",
                        maxLines: 2, style: Const.labelText()),
                  ),
                  kAppButton(
                    onPressed: () {
                      var urls = snapshot.data!.docs[index].data()['documents'];
                      Get.to(
                        () => DocumentView(decoments: urls, ctrl: ctrl),
                      );
                    },
                    label: "View",
                  ),
                ],
              ),
              SizedBox(height: Get.size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  kAppButton(
                      onPressed: () {
                        DB.tasks.doc(snapshot.data!.docs[index].id).update({
                          'status': "approved",
                        });
                        Get.back();
                        ksucessSnackbar(
                          message: "Approved Task",
                        );
                      },
                      label: "Approve",
                      color: Colors.green.shade400),
                  kAppButton(
                      onPressed: () {
                        DB.tasks.doc(snapshot.data!.docs[index].id).update({
                          'status': null,
                        });
                        Get.back();
                        kerrorSnackbar(message: "DisApproved Task");
                      },
                      label: "DisApprove",
                      color: Colors.red.shade400)
                ],
              ),
              SizedBox(height: Get.size.height * 0.08),
              SizedBox(
                width: Get.size.width * 5,
                child: kAppButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    label: "Back",
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          ),
        );
      });
}
