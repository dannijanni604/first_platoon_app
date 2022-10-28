import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMemberView extends StatelessWidget {
  const AddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Member Name"),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text("Generate Code"),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextFormField(),
            SizedBox(
              height: size.height * 0.37,
            ),
            Center(
              child: Column(
                children: [
                  const Material(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black26)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Generate User"),
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
