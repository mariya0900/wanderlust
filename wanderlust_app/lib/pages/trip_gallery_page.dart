import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/pages/add_new_activity_page.dart';
import 'package:wanderlust_app/pages/add_new_image.dart';
import 'package:camera/camera.dart';

class TripGallery extends StatefulWidget {
  final Trip trip;
  List<String> gallery = [];
  List<CameraDescription> cameras = [];
  TripGallery(
      {Key? key,
      required this.trip,
      required this.gallery,
      required this.cameras})
      : super(key: key);

  @override
  State<TripGallery> createState() => _TripGalleryState();
}

class _TripGalleryState extends State<TripGallery> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      //if the gallery doesn't work we can do camera instead
      body: //Center(child: Text('change to a grid view')),
          GridView.builder(
              itemCount: widget.gallery.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 1),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (index == selectedIndex)
                          ? (Colors.blue)
                          : (Colors.transparent)),
                  child: GestureDetector(
                    child: Image.file(
                      File(widget.gallery[index]),
                      fit: BoxFit.cover,
                    ),
                    key: Key(widget.gallery[index]),
                    onTap: () {
                      print("Word");
                    },
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewImage(
                      trip: widget.trip,
                      gallery: widget.gallery,
                      cameras: widget.cameras)));
          if (result == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
