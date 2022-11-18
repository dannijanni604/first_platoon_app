import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/material.dart';

import '../../../core/functions.dart';

class AdminManageHistoryView extends StatelessWidget {
  const AdminManageHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: DB.tasks.where('status', isEqualTo: 'approved').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (((context, index) {
                return appTile(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data!.docs[index].data()['task']),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' Submited By ${snapshot.data!.docs[index].data()['submitted_by'].toString()}',
                          ),
                          Chip(
                            backgroundColor: statusColor(
                              snapshot.data!.docs[index].data()['status'],
                            ),
                            label: Text(
                              snapshot.data!.docs[index].data()['status'],
                            ),
                          )
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
