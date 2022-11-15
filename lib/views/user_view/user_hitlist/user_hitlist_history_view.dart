import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UserHitListHistoryView extends StatelessWidget {
  const UserHitListHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = GetStorage().read('id');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.tasks
          .where('members', arrayContains: id)
          .where('status', isNull: false)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return appTile(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data!.docs[index].data()['task']),
                          Text(DateTime.now().toString().substring(0, 10)),
                          // Text(snapshot.data!.docs[index]
                          //         .data()['submitted_at']
                          //         .toDate()
                          //         .toString() ??
                          //     ""),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     DB.tasks
                          //         .doc(snapshot.data!.docs[index].id)
                          //         .delete();
                          //   },
                          //   icon: Icon(Icons.delete),
                          // ),
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
