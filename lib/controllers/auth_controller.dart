import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/views/admin_view/admin_home_view.dart';
import 'package:first_platoon/views/user_view/user_home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  QueryDocumentSnapshot<Map<String, dynamic>>? userSnaposhots;
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  RxBool onLogin = false.obs;
  // user
  final userCodecontroller = TextEditingController();

  // admin

  final adminNameController = TextEditingController();
  final adminEmailController = TextEditingController();
  final adminPasswordController = TextEditingController();

  GetStorage storage = GetStorage();

  Future login(BuildContext context) async {
    onLogin(true);
    try {
      await auth
          .signInWithEmailAndPassword(
              email: adminEmailController.text,
              password: adminPasswordController.text)
          .then((value) {
        onLogin(false);
        adminNameController.clear();
        adminEmailController.clear();
        adminPasswordController.clear();
        appNavReplace(context, const AdminHomeView());
      });
    } on FirebaseAuthException catch (e) {
      onLogin(false);
      return kerrorSnackbar(message: e.toString());
    }
  }

  Future signOut(BuildContext context) async {
    Stream<User?> user = FirebaseAuth.instance.authStateChanges();

    await auth.signOut();
  }

  Future signUp(BuildContext context) async {
    try {
      onLogin(true);
      await auth
          .createUserWithEmailAndPassword(
        email: adminEmailController.text,
        password: adminPasswordController.text,
      )
          .then((UserCredential credential) {
        final uid = credential.user!.uid;
        FirebaseFirestore.instance.collection('admins').doc(uid).set({
          "name": adminNameController.text,
          "email": adminEmailController.text,
          "uid": uid,
        });
        onLogin(false);
        appNavReplace(context, const AdminHomeView());
        adminNameController.clear();
        adminEmailController.clear();
      });
    } on FirebaseAuthException catch (e) {
      onLogin(false);
      return kerrorSnackbar(message: e.toString());
    }
  }

  Future loginAsUser(BuildContext context) async {
    try {
      bool isUserExist = await DB.members
          .where('code', isEqualTo: userCodecontroller.text)
          .get()
          .then<bool>((value) {
        for (var e in value.docs) {
          String id = e.data()['id'];
          String code = e.data()['code'];
          String name = e.data()['name'];
          storage.write("id", id);
          storage.write("code", code);
          storage.write("code", name);
        }
        if (value.docs.isNotEmpty) {
          // value.docs.map((e) {});
          return true;
        } else {
          return false;
        }
      });

      if (isUserExist) {
        return appNavReplace(context, UserHomeView());
      } else {
        return kerrorSnackbar(message: "User Not find Enter Another Code");
      }
    } on Exception catch (e) {
      return kerrorSnackbar(message: e.toString());
    }
  }
}
