import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/views/user_views/submit_view.dart';
import 'package:flutter/material.dart';

class UserHitlistView extends StatefulWidget {
  const UserHitlistView({super.key});

  @override
  State<UserHitlistView> createState() => _UserHitlistViewState();
}

class _UserHitlistViewState extends State<UserHitlistView> {
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
                        height: size.height * 0.05,
                        width: size.width * 0.95,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.025,
                              width: size.width * 0.08,
                              decoration: BoxDecoration(border: Border.all()),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            const Text("Complete")
                          ],
                        ))
                    : null,
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appNavPush(context, const SubmitView());
        },
        child: const Text("Submit"),
      ),
    );
  }
}
