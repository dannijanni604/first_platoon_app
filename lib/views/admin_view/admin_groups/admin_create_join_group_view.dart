// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:first_platoon/controllers/add_compaigns_controller.dart';
// import 'package:first_platoon/core/components/app_button.dart';
// import 'package:first_platoon/core/db.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminCreateOrJoinGroupView extends StatefulWidget {
//   AdminCreateOrJoinGroupView({super.key, required this.type});
//   final String type;

//   @override
//   State<AdminCreateOrJoinGroupView> createState() =>
//       _AdminCreateOrJoinGroupViewState();
// }

// class _AdminCreateOrJoinGroupViewState
//     extends State<AdminCreateOrJoinGroupView> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   final ctrl = Get.put(AddCompaignsConteroller());

//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Platoon Groups"),
//         ),
//         body: ctrl.obx(
//           (state) => SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: Get.size.height * 0.05),
//                   const Text(
//                       "After join the group you will be able to see all the task and schdule of this groups members"),
//                   SizedBox(height: Get.size.height * 0.02),
//                   widget.type == 'create'
//                       ? const Text("Enter Group Name")
//                       : const Text("Select Group"),
//                   SizedBox(height: Get.size.height * 0.02),
//                   widget.type == 'create'
//                       ? Form(
//                           key: formKey,
//                           child: TextFormField(
//                             controller: ctrl.groupNameController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Enter Group Name";
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                         )
//                       : Container(
//                           width: 300,
//                           height: 200,
//                           child: Wrap(
//                             children: [
//                               ...ctrl.groupsnapshots!.docs.map((e) {
//                                 List<String> ids = List.from(e['group_members'])
//                                     .cast<String>();
//                                 return Column(
//                                   children: [
//                                     ...ids.map((e) => Text(e)),
//                                     Chip(
//                                         avatar: CircleAvatar(
//                                           child: Text(e['group_name']
//                                               .toString()
//                                               .substring(0, 1)),
//                                         ),
//                                         deleteIcon: Icon(Icons.add, size: 25),
//                                         onDeleted: () {
//                                           DB.groups.doc(e.id).update({
//                                             'group_member':
//                                                 FieldValue.arrayUnion([
//                                               FirebaseAuth
//                                                   .instance.currentUser!.uid
//                                             ])
//                                           });
//                                         },
//                                         label: Text(e.id)),
//                                   ],
//                                 );
//                               })
//                             ],
//                           ),
//                         ),
//                   SizedBox(height: Get.size.height * 0.1),
//                   Obx(() {
//                     return ctrl.indicator()
//                         ? const Center(
//                             child: CircularProgressIndicator(),
//                           )
//                         : kAppButton(
//                             label: widget.type == 'create' ? "Create" : "Join",
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 ctrl.onCreateOrJoinGrops(type: widget.type);
//                               }
//                             },
//                           );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
