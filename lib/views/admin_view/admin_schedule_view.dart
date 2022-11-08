import 'dart:developer';
import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/db.dart';
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
              // authCtrl.signOut(context);
              Future.delayed(Duration(seconds: 1), () {
                appNavReplace(context, AuthOptionsView());
              });
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: StreamBuilder(
        stream: DB.schedules.snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SfCalendar(
              minDate: DateTime.now(),
              // viewHeaderHeight: -5,
              headerHeight: 40,
              onTap: (CalendarTapDetails detail) {
                log(detail.date.toString());
              },
              view: CalendarView.schedule,
              cellBorderColor: Colors.transparent,
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayCount: snapshot.data!.docs.length,
                  agendaItemHeight: 50,
                  monthCellStyle: const MonthCellStyle(),
                  agendaStyle: const AgendaStyle(
                    appointmentTextStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  // showTrailingAndLeadingDates: true,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  showAgenda: true),
              dataSource: MeetingDataSource(_getDataSource(
                snapshot.data!.docs.map((e) => e.data()).toList(),
              )),
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

List<Meeting> _getDataSource(List<Map<String, dynamic>> data) {
  final List<Meeting> meetings = <Meeting>[];

  for (var e in data) {
    meetings.add(
      Meeting(e['task'], DateTime.now(), e['date'].toDate(), Colors.redAccent,
          true),
    );
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
