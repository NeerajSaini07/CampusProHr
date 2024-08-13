import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<List<File>?> showFilePicker({bool allowMultiple = true}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      withReadStream: true,
      type: FileType.custom,
      allowCompression: true,
      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
      allowMultiple: allowMultiple);

  if (result != null) {
    List<File>? compressedFiles = [];

    for (int i = 0; i < result.files.length; i++) {
      final bytes = result.files[i].size;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      print('BYTES : $bytes & KB : $kb & MB : $mb');
      if (mb > 1) {
        if (result.files[i].path!.split(".").last == "pdf") {
          compressedFiles.add(File(result.files[i].path!));
        } else {
          final tempDir = await getTemporaryDirectory();
          print(result.files[i].path);
          File file = await File(
                  '${tempDir.path}/${result.files[i].path!.split("file_picker").last.split(".").first}.${result.files[i].path!.split(".").last}')
              .create();
          var img = await testCompressFile(File(result.paths[i]!), file.path)!;
          compressedFiles.add(img);
        }
      } else {
        compressedFiles.add(File(result.files[i].path!));
      }
    }

    List<File> files = result.paths.map((path) {
      return File(path!);
    }).toList();

    // return files;
    return compressedFiles;
  } else {
    print('File Format not Found');
  }
}

Future<File>? testCompressFile(File file, String targetPath) async {
  // Uint8List? result = await FlutterImageCompress.compressWithFile(
  //   file.absolute.path,
  //   minWidth: 2300,
  //   minHeight: 1500,
  //   quality: 94,
  //   rotate: 90,
  // );

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 60,
    // rotate: 180,
  );

  print(file.lengthSync());
  print(result!.lengthSync());

  print("result after compress $result");

  ///
  // File a = File.fromRawPath(result!);
  // print("file after compression $a");
  var b = result.readAsBytesSync().lengthInBytes;

  final kb = b / 1024;
  final mb = kb / 1024;
  print('After compress BYTES : $b & KB : $kb & MB : $mb');

  print(file.lengthSync());
  print(result.lengthSync());
  return result;
}
