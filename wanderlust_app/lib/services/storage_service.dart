import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>?> getImageIds(
      {required String uid, required int tripId}) async {
    List<String> id = [];
    ListResult result =
        await storage.ref(uid + '/' + tripId.toString() + '/').listAll();

    result.items.forEach((item) {
      id.add(item.fullPath);
    });
    return id;
  }

  Future<String> getUrl({required String fullPath}) async {
    return await storage.ref(fullPath).getDownloadURL();
  }

  Future<void> uploadImage(
      {required String filePath,
      required String uid,
      required int tripId}) async {
    File file = File(filePath);

    try {
      await storage
          .ref(uid)
          .child(tripId.toString())
          .child(basename(file.path))
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
