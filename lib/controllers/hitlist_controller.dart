import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class HitlistController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool isClicked = false.obs;
  RxBool isComplete = false.obs;
  RxString decumentPath = '_'.obs;
  RxList<File> pickedFile = RxList<File>([]);
  RxList<String> pickedFileUrls = RxList<String>([]);
  Rx<List<String>> pickedFileExtension = Rx<List<String>>([]);
  final firebaseStorage = FirebaseStorage.instance;

  Future picDocuments() async {
    try {
      await Permission.photos.request();

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        pickedFile(result.files.map((e) {
          // openFile(e);
          return File(e.path!);
        }).toList());
      } else {
        log("User canceled the picker");
      }
    } catch (e) {
      kerrorSnackbar(message: e.toString());
    }
  }

  Future uplodDecoments() async {
    int _name = DateTime.now().microsecondsSinceEpoch;
    try {
      for (var e in pickedFile) {
        Reference ref = firebaseStorage
            .ref()
            .child('documents/$_name.${e.path.split('.').last}');
        UploadTask uploadTask = ref.putFile(File(e.path));
        var onComplete = await uploadTask.whenComplete(() => null);
        pickedFileUrls.add(await onComplete.ref.getDownloadURL());
      }
    } catch (e) {
      kerrorSnackbar(message: e.toString());
    }
  }

  // Future<File> changePath(PlatformFile file) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final newFile = File('${directory.path}/${file.name}');
  //   return File(file.path!).copy(newFile.path);
  // }

  Future onUserCompleteTask({
    String? task,
  }) async {
    isClicked(true);

    try {
      if (pickedFile.isNotEmpty) {
        final name = GetStorage().read('name');
        await uplodDecoments();
        await DB.completedTask.doc().set({
          "decoments": FieldValue.arrayUnion(pickedFileUrls),
          "submited_by": name,
          "submited_date": DateTime.now(),
          "task": task,
          'status': "processing",
        });
        pickedFile.clear();
        isClicked(false);
        Get.back();
        ksucessSnackbar(message: "Task Submited SuccesFully");
      } else {
        isClicked(false);
        kerrorSnackbar(message: "Select Files To Submit Task");
      }
    } catch (e) {
      isClicked(false);
      kerrorSnackbar(message: e.toString());
    } finally {
      isClicked(false);
    }
  }

  hitListJobs() async {
    QuerySnapshot<Map<String, dynamic>> docs = await DB.schedules
        .where('members.member', isEqualTo: "sir azeem")
        .get();
    for (var e in docs.docs) {
      log("message");
      log(e.data().length.toString());
      log(e.data()['date']);
    }
  }

  // void openFile(PlatformFile? file) {
  //   OpenFile.open(
  //     file!.path,
  //   );
  // }
}
