import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/admin_controller.dart';

class AdminScheduleView extends StatelessWidget {
  AdminScheduleView({super.key});

  final authCtrl = Get.put(AuthController());
  final adminCtrl = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Schedule"),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QrImage(
                          data: adminCtrl.admin.groupId,
                          version: QrVersions.auto,
                          size: 180,
                          gapless: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(adminCtrl.admin.groupId),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: adminCtrl.admin.groupId),
                                );
                                ksucessSnackbar(message: "Group Id Copied");
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.supervised_user_circle),
          ),
          IconButton(
            onPressed: () {
              authCtrl.signOut(context);
              Get.offAll(() => const AuthOptionsView());
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
            .where('doc_id', isEqualTo: adminCtrl.admin.groupId)
            .orderBy('date')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(child: Text("No Schdeule"))
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      return appTile(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                  snapshot.data!.docs[index].data()['schdule'],
                                  style: Const.labelText()),
                            ),
                            Text(
                              dateString(
                                snapshot.data!.docs[index]
                                    .data()['date']
                                    .toDate(),
                                snapshot.data!.docs[index]
                                    .data()['end_date']
                                    .toDate(),
                              ),
                            ),
                            // Text("$initialDate"),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 5),
                            //   child: Text(" - To - ",
                            //       style: Theme.of(context).textTheme.button),
                            // ),
                            // Text("$endDate"),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Are you sure to delete?"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  await DB.schedules
                                                      .doc(snapshot
                                                          .data!.docs[index].id)
                                                      .delete();
                                                  Get.back();
                                                },
                                                child: Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text('Cancel'),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  );
          } else if (snapshot.hasError) {
            printInfo(info: snapshot.error.toString());
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

  String dateString(DateTime st, DateTime en) {
    if (st.month == en.month) {
      return "${DateFormat('MMM d').format(st)}-${DateFormat('d').format(en)}";
    }
    return "${DateFormat('MMM d').format(st)}-${DateFormat('MMM d').format(en)}";
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
