import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/models/metting_model.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserScheduleView extends StatelessWidget {
  const UserScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = GetStorage().read('id');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.kblueColor,
        automaticallyImplyLeading: false,
        title: const Text("Schedule"),
        actions: [
          IconButton(
              onPressed: () {
                GetStorage().erase();
                appNavReplace(context, const AuthOptionsView());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: DB.schedules.where('members', arrayContains: id).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SfCalendar(
              minDate: DateTime.now(),
              onTap: (CalendarTapDetails detail) {},
              view: CalendarView.month,
              cellBorderColor: Colors.transparent,
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
                  showAgenda: true),
              dataSource: MeetingDataSource(getDataSource(
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
