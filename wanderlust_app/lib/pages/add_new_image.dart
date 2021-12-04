import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/pages/trip_gallery_page.dart';
import 'package:wanderlust_app/pages/trip_itinerary_page.dart';
import 'package:camera/camera.dart';
import 'package:wanderlust_app/classes/trip.dart';

class AddNewImage extends StatefulWidget {
  final Trip trip;
  late List<String> gallery;
  List<CameraDescription> cameras = [];

  AddNewImage(
      {Key? key,
      required this.trip,
      required this.gallery,
      required this.cameras})
      : super(key: key);

  @override
  State<AddNewImage> createState() => _AddNewImageState();
}

class _AddNewImageState extends State<AddNewImage> {
  late CameraController _controller;
  late Future<void> _initializeController;

  @override
  void initState() {
    super.initState();
    _controller =
        CameraController(widget.cameras.first, ResolutionPreset.medium);
    _initializeController = _controller.initialize();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Take Picture")),
      body: FutureBuilder(
        future: _initializeController,
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
          widget.gallery.add(image.path);
          Navigator.pop(context, true);
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
