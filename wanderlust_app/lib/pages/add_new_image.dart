import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/pages/trip_gallery_page.dart';
import 'package:wanderlust_app/pages/trip_itinerary_page.dart';
import 'package:camera/camera.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/classes/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wanderlust_app/services/camera_service.dart';
import 'package:wanderlust_app/services/database_service.dart';
import 'package:wanderlust_app/services/storage_service.dart';
import 'package:wanderlust_app/globals.dart' as globals;

var currentUser = FirebaseAuth.instance.currentUser;
UserData user = UserData(uid: "2", trips: []);
DatabaseService dbService = DatabaseService();
StorageService ssService = StorageService();

class AddNewImage extends StatefulWidget {
  final camera;
  late List<String> gallery;

  AddNewImage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  State<AddNewImage> createState() => _AddNewImageState();
}

class _AddNewImageState extends State<AddNewImage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      dbService.getUserData(uid: currentUser!.uid).then((value) {
        user = UserData.fromJson(value);
        //print(user.trips[0].title);
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text("Take Picture")),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var image = await _controller.takePicture();
          print(image.path);
          //widget.gallery.add(image.path);
          for (int i = 0; i < user.trips.length; i++) {
            print(image.path);
            print(user.trips.length);
            print(i);
            ssService.uploadImage(
                filePath: image.path,
                uid: user.uid,
                tripId: globals.selectedTripId);
          }
          Navigator.pop(context, true);
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
