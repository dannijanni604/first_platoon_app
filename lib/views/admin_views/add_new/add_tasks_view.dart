import 'package:flutter/material.dart';

class AddTasksView extends StatelessWidget {
  const AddTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
              const Text("Due Dates"),
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
                        child: Text("Generate Tasks"),
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
      ),
    );
  }
}
