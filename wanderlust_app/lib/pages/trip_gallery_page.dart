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
import 'package:wanderlust_app/globals.dart' as globals;

class TripGallery extends StatefulWidget {
  TripGallery({
    Key? key,
  }) : super(key: key);

  @override
  State<TripGallery> createState() => _TripGalleryState();
}

class _TripGalleryState extends State<TripGallery> {
  DatabaseService dbService = DatabaseService();
  StorageService ssService = StorageService();

  int selectedIndex = 0;
  var currentUser = FirebaseAuth.instance.currentUser;

  // Need to pass this

  List<String> gallery = [];
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      dbService.getUserData(uid: currentUser!.uid).then((value) {
        UserData user = UserData.fromJson(value);
        ssService
            .getImageIds(uid: currentUser!.uid, tripId: globals.selectedTripId)
            .then((pathList) {
          gallery = pathList!;

          setState(() {});
        });
        //print(user.trips[0].title);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      dbService.getUserData(uid: currentUser!.uid).then((value) {
        UserData user = UserData.fromJson(value);
        ssService
            .getImageIds(uid: currentUser!.uid, tripId: globals.selectedTripId)
            .then((pathList) => gallery = pathList!);
        //print(user.trips[0].title);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),

      //if the gallery doesn't work we can do camera instead
      body: //Center(child: Text('change to a grid view')),
          GridView.builder(
              itemCount: gallery.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 1),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (index == selectedIndex)
                          ? (Colors.blue)
                          : (Colors.transparent)),
                  child: GestureDetector(
                    child: FutureBuilder(
                      future: ssService.getUrl(fullPath: gallery[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.network(snapshot.data.toString());
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    onTap: () {
                      print("Word");
                    },
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.pushNamed(context, '/open_camera');
          if (result == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
