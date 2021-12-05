import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraService {
  List<CameraDescription> _cameras = [];

  List<CameraDescription> get cameras {
    return _cameras;
  }
}
