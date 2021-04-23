import 'dart:io';

String createDownloadDirectory(Directory appDir) {
  String newPath = "";
  List<String> paths = appDir.path.split("/");
  for (int x = 1; x < paths.length; x++) {
    String folder = paths[x];
    if (folder != "Android") {
      newPath += "/" + folder;
    } else {
      break;
    }
  }

  newPath += "/INR-mi-Ayarla";
  return newPath;
}
