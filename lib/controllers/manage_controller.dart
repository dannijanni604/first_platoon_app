import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ManageController extends GetxController {
  RxBool isDownloading = false.obs;
  String extension = "";

  // bool? filterFileByExtension(String file) {
  //   final splitpath = file.split('.').last;
  //   final ext = splitpath.split('?').first;
  //   if (ext == "png" || ext == "jpg" || ext == 'jpeg') {
  //     log(ext);
  //     isNotfile(true);
  //     return isNotfile.value;
  //   }
  //   return isNotfile.value;
  // }

  Future downloadAndOpenFile({String? url, String? fileName}) async {
    final file = await downloadFile(url, fileName);
    if (file == null) return null;
    log('Path :: ${file.path}');
    OpenFile.open(
      file.path,
    );
  }

  Future<File?> downloadFile(String? url, String? fileName) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File("${appStorage.path}/$fileName");
      final response = await Dio().get(
        url!,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
