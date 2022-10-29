import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';

class UserScheduleView extends StatelessWidget {
  const UserScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < 5; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.97,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text("Nov  25-29"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Example Duty",
                          style: Const.labelText(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
