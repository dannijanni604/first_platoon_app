import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/models/metting_model.dart';
import 'package:first_platoon/views/auth_views/admin_signup_view.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AdminScheduleView extends StatelessWidget {
  const AdminScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    // final ctrl = Get.put(ScheduleController());
    final authCtrl = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Schedule"),
        actions: [
          IconButton(
            onPressed: () {
              authCtrl.signOut(context);
              appNavReplace(context, const AuthOptionsView());
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: StreamBuilder(
        stream: DB.schedules
            .where('auth_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SfCalendar(
              minDate: DateTime.now(),
              // viewHeaderHeight: -5,
              headerHeight: 40,
              onTap: (CalendarTapDetails detail) {},
              view: CalendarView.schedule,
              cellBorderColor: Colors.transparent,
              scheduleViewSettings: const ScheduleViewSettings(
                appointmentItemHeight: 60,
              ),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayCount: 3,
                agendaItemHeight: 50,
                monthCellStyle: MonthCellStyle(),
                agendaStyle: AgendaStyle(
                  appointmentTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
              ),
              dataSource: MeetingDataSource(
                getDataSource(
                  snapshot.data!.docs.map((e) => e.data()).toList(),
                ),
              ),
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
      ),
    );
  }
}
