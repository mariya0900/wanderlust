import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;
  String url = '';
  List<String> imageID = [];

  Future<List<String>?> getImageIds(
      {required String uid, required int tripId}) async {
    List<String> id = [];
    ListResult result =
        await storage.ref(uid + '/' + tripId.toString() + '/').listAll();

    result.items.forEach((item) {
      id.add(item.fullPath);
    });
    imageID = id;
    return id;
  }

  Future<String> getUrl({required String fullPath}) async {
    url = await storage.ref(fullPath).getDownloadURL();
    return await storage.ref(fullPath).getDownloadURL();
  }

  Future<void> uploadImage(
      {required String filePath,
      required String uid,
      required int tripId}) async {
    File file = File(filePath);

    try {
      await storage.ref(uid + '/' + tripId.toString() + '/').putFile(file);
      print("Success!");
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
