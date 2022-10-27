import 'package:flutter/material.dart';

class AdminScheduleView extends StatefulWidget {
  const AdminScheduleView({super.key});

  @override
  State<AdminScheduleView> createState() => _AdminScheduleViewState();
}

class _AdminScheduleViewState extends State<AdminScheduleView> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        children: [
          // for (int i = 0; i < 5; i++)
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
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
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: isClicked
                    ? Container(
                        height: size.height * 0.2,
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                        ),
                        child: Column(
                          children: const [
                            Text("Name 1"),
                            Text("Name 2"),
                            Text("Name 3"),
                            Text("Name 4"),
                          ],
                        ),
                      )
                    : null,
              )
            ],
          ),
        ],
      ),
    );
  }
}
