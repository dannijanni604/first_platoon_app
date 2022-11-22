import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/material.dart';

import '../../../core/functions.dart';

class AdminManageHistoryView extends StatelessWidget {
  const AdminManageHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: DB.tasks
            .where('status', isEqualTo: 'approved')
            .where("doc_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text("No History"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (((context, index) {
                      return appTile(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.docs[index].data()['task'],
                                    style: Const.labelText()),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' Submited by : ${snapshot.data!.docs[index].data()['submitted_by'].toString()}',
                                ),
                                statusChip(
                                  label: snapshot.data!.docs[index]
                                      .data()['status'],
                                  color: snapshot.data!.docs[index]
                                      .data()['status'],
                                ),
                                // Chip(
                                //   backgroundColor: statusColor(
                                //     snapshot.data!.docs[index].data()['status'],
                                //   ),
                                //   label: Text(
                                //     snapshot.data!.docs[index].data()['status'],
                                //   ),
                                // )
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
