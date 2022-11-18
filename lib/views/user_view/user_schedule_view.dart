import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
            return snapshot.data!.docs.isEmpty
                ? Center(child: Text("No Schdeule"))
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
