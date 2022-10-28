import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:get/get.dart';

class HitlistController extends GetxController {
  RxBool isClicked = false.obs;
  RxBool isComplete = false.obs;
  RxString decumentPath = '_'.obs;
  Rx<FilePickerResult> pickedFile = Rx<FilePickerResult>(FilePickerResult([]));

  picFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        log(files.toString());
      } else {
        log("User canceled the picker");
      }
    } catch (e) {
      log("Async Rrror");
    }
  }

  picDecoment() async {
    try {
      RxString result = ''.obs;
      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: ['pdf'],
        allowedUtiTypes: ['com.sidlatau.example.pdf'],
        allowedMimeTypes: ['application/*'],
        invalidFileNameSymbols: ['/'],
      );
      result(await FlutterDocumentPicker.openDocument(params: params));
      if (result.value != null || result.value.isNotEmpty) {
        decumentPath(result.value);
        log(decumentPath.toString());
      } else {
        log("decumentPathIsEmpty");
      }
    } catch (e) {
      log("error to pic file");
    }
  }
}
