import 'package:first_platoon/controllers/hitlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitView extends StatelessWidget {
  const SubmitView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    final ctrl = Get.find<HitlistController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("SUBMIT"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                ctrl.picFile();
              },
              child: Container(
                height: size.height * 0.25,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Material(
              shape:
                  RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Add Doucoment"),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
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
    );
  }
}