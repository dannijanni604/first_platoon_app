import 'package:flutter/material.dart';

class AddScheduleView extends StatelessWidget {
  const AddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task"),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text("Dates"),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text("Add Members"),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextFormField(),
            SizedBox(
              height: size.height * 0.22,
            ),
            Center(
              child: Column(
                children: [
                  const Material(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black26)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Generate Schedule"),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
