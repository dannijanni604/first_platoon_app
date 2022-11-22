import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminScheduleView extends StatelessWidget {
  const AdminScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Schedule"),
        actions: [
          TextButton(
            onPressed: () async {
              // to put auth id
              DB.groups.doc().set({
                "admin_ids": FieldValue.arrayUnion(
                  [FirebaseAuth.instance.currentUser!.uid],
                ),
              });

              // to get group id where admin exist
              QuerySnapshot<Map<String, dynamic>> doc = await DB.groups
                  .where("admin_ids",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .get();
              doc.docs.map((e) {
                GetStorage().write('group_id', e.id);
              });

              // now when the admin create schdule and task

              // check AddCompaignsConteroller.addTask/addSchdule
            },
            child: Text(
              "Join Group",
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              authCtrl.signOut(context);
              appNavReplace(context, const AuthOptionsView());
            },
            icon: const Icon(
              Icons.logout_outlined,
              size: 25,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DB.schedules
            .where('doc_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(child: Text("No Schdeule"))
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      String initialDate = snapshot.data!.docs[index]
                          .data()['date']
                          .toString()
                          .substring(0, 10);

                      String endDate = snapshot.data!.docs[index]
                          .data()['date']
                          .toString()
                          .substring(26, 36);
                      return appTile(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                  snapshot.data!.docs[index].data()['schdule'],
                                  style: Const.labelText()),
                            ),
                            Text("$initialDate"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(" - To - ",
                                  style: Theme.of(context).textTheme.button),
                            ),
                            Text("$endDate"),
                          ],
                        ),
                      );
                    }));
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

// SfCalendar(
//   minDate: DateTime.now(),
//   // viewHeaderHeight: -5,
//   headerHeight: 40,
//   onTap: (CalendarTapDetails detail) {},
//   view: CalendarView.schedule,
//   cellBorderColor: Colors.transparent,
//   scheduleViewSettings: const ScheduleViewSettings(
//     appointmentItemHeight: 60,
//   ),
//   monthViewSettings: const MonthViewSettings(
//     appointmentDisplayCount: 3,
//     agendaItemHeight: 50,
//     monthCellStyle: MonthCellStyle(),
//     agendaStyle: AgendaStyle(
//       appointmentTextStyle: TextStyle(
//         color: Colors.black,
//       ),
//     ),
//     appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
//     showAgenda: true,
//   ),
//   dataSource: MeetingDataSource(
//     getDataSource(
//       snapshot.data!.docs.map((e) => e.data()).toList(),
//     ),
//   ),
// );
