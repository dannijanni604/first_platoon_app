import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

appTile({
  Widget? child,
  VoidCallback? onpress,
}) {
  return GestureDetector(
    onTap: onpress,
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      width: Get.size.width * 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        // border: Border.all(color: Colors.black26),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black12,
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //     offset: Offset(0.6, -0.1),
        //   ),
        // ],
      ),
      child: child,
    ),
  );
}
