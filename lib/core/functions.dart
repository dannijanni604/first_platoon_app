import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DateTime? currentBackPressTime;
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    ksucessSnackbar(message: "Press Again To Exit App");
    return Future.value(false);
  }
  return Future.value(true);
}

showMembersBottomSheet({BuildContext? context, List? members, String? task}) {
  showModalBottomSheet(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context!,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(task ?? "", style: Const.labelText(color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.cancel_outlined))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              height: 200,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...members!.map(
                      (e) => PopupMenuItem<String>(
                          child: Container(
                            width: Get.size.width,
                            child: Text(e['name']),
                          ),
                          value: '1'),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      });
  // showMenu<String>(
  //   shape: RoundedRectangleBorder(
  //     side: BorderSide(color: Colors.black),
  //     borderRadius: BorderRadius.circular(10),
  //   ),
  //   context: context!,
  //   position: RelativeRect.fromDirectional(
  //     textDirection: TextDirection.ltr,
  //     start: 0,
  //     top: (Get.size.height),
  //     end: 0,
  //     bottom: 10,
  //   ),
  //   items: [],
  //   elevation: 8.0,
  // );
}
