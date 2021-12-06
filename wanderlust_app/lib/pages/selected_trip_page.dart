import 'package:flutter/material.dart';
import 'package:wanderlust_app/globals.dart';
import 'package:wanderlust_app/pages/trip_destination_map_page.dart';
import 'package:wanderlust_app/pages/trip_gallery_page.dart';
import 'package:wanderlust_app/pages/trip_itinerary_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/services/database_service.dart';
import '/classes/trip.dart';
import 'package:camera/camera.dart';
import '/classes/userdata.dart';

// The _activeTrip may have to get passed to each of navigator pushes below
List<CameraDescription> cameras = [];

class SelectedTripPage extends StatelessWidget {
  final Trip _activeTrip;
  final int _tripID;

  SelectedTripPage(this._activeTrip, this._tripID, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(_tripID);
    Color? header = Colors.green[300];
    Color? options = Colors.green[100];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                DatabaseService dbService = DatabaseService();
                var currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser != null) {
                  dbService.getUserData(uid: currentUser.uid).then((value) {
                    UserData user = UserData.fromJson(value);
                    user.trips.removeAt(selectedTripId);
                    UserData testuser =
                        UserData(uid: currentUser.uid, trips: user.trips);
                    dbService.addUser(user: testuser);
                  });
                }
                Navigator.pop(context, true);
              }),
        ],
        automaticallyImplyLeading: true,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                  //fit: FlexFit.tight,
                  flex: 3,
                  child: Container(
                      height: 175,
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.green[200],
                      child: Text.rich(
                        TextSpan(
                          //text: 'Hello', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${_activeTrip.month} - ${_activeTrip.year}\n',
                                style:
                                    TextStyle(fontSize: 12, letterSpacing: 2)),
                            TextSpan(
                                text: '${_activeTrip.title}\n',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${_activeTrip.duration}',
                                style: TextStyle(fontSize: 14)),
                            TextSpan(
                                text: '\n\n${_activeTrip.description}',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ))),
            ],
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: makeOptionContainer(Colors.green[50], 'Itinerary'),
                  onTap: () {
                    //Navigator.pushNamed(context, '/open_itinerary');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TripItinerary(
                                  trip: _activeTrip,
                                  tripID: _tripID,
                                  itinerary: _activeTrip.getItinerary(),
                                )));
                  },
                ),
                GestureDetector(
                  child:
                      makeOptionContainer(Colors.green[50], 'Destination Map'),
                  onTap: () {
                    //Navigator.pushNamed(context, '/open_map');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TripDestinationMap(
                                  itinerary: _activeTrip.getItinerary(),
                                )));
                  },
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: makeOptionContainer(Colors.green[50], 'Gallery'),
                  onTap: () async {
                    cameras = await availableCameras();
                    _activeTrip.setCamera(cameras);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TripGallery()));
                  },
                ),
                GestureDetector(
                  child: makeOptionContainer(
                      Colors.green[50], 'Set Trip Reminder'),
                  onTap: () {
                    Navigator.pushNamed(context, '/set_reminder');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget makeOptionContainer(Color? bg, String label) {
  return Container(
    width: 150,
    height: 150,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(label),
  );
}
