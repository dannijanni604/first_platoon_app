import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  static CollectionReference<Map<String, dynamic>> schedules =
      FirebaseFirestore.instance.collection("schedules");
  static CollectionReference<Map<String, dynamic>> tasks =
      FirebaseFirestore.instance.collection("tasks");
  static CollectionReference<Map<String, dynamic>> members =
      FirebaseFirestore.instance.collection("members");
  static CollectionReference<Map<String, dynamic>> completedTask =
      FirebaseFirestore.instance.collection("completedTask");
}
