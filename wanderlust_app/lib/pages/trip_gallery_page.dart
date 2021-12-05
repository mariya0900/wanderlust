import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/pages/add_new_activity_page.dart';
import 'package:wanderlust_app/pages/add_new_image.dart';
import 'package:camera/camera.dart';
import 'package:wanderlust_app/classes/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wanderlust_app/services/database_service.dart';
import 'package:wanderlust_app/services/storage_service.dart';

var currentUser = FirebaseAuth.instance.currentUser;
UserData user = UserData(uid: "", trips: []);
DatabaseService dbService = DatabaseService();
StorageService ssService = StorageService();

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
    if (currentUser != null) {
      print("HELP OH GsssOD");
      dbService.getUserData(uid: currentUser!.uid).then((value) {
        user = UserData.fromJson(value);
        //print(user.trips[0].title);
      });
    }
    int currentTrip = 0;
    for (int i = 0; i < user.trips.length; i++) {
      if (user.trips[i].title == widget.trip.title) {
        currentTrip = i;
        print("Epic: " + widget.trip.title + " $currentTrip");
      }
    }
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
                ssService.getImageIds(uid: user.uid, tripId: currentTrip);
                ssService.getUrl(fullPath: ssService.imageID[index]);
                print("Yoooo: " + ssService.url);
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (index == selectedIndex)
                          ? (Colors.blue)
                          : (Colors.transparent)),
                  child: GestureDetector(
                    child: Image.network(
                      ssService.url,
                      fit: BoxFit.cover,
                    ),
                    key: Key(ssService.url),
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
                      gallery: user.trips[currentTrip].gallery,
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
