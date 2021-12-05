import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/services/database_service.dart';
import '/classes/userdata.dart';
import '/classes/trip.dart';
import 'selected_trip_page.dart';
import 'add_new_trip_page.dart';

// this should save to the cloud
// ref lab 5, 6, 7; and exercise 6

class HomepageMyTrips extends StatefulWidget {
  const HomepageMyTrips({Key? key}) : super(key: key);

  @override
  _HomepageMyTripsState createState() => _HomepageMyTripsState();
}

class _HomepageMyTripsState extends State<HomepageMyTrips> {
  DatabaseService dbService = DatabaseService();

  List<Trip> trips = [];

  @override
  Widget build(BuildContext context) {
    // more UI testing
    var currentUser = FirebaseAuth.instance.currentUser;
    UserData user = UserData(uid: '', trips: []);
    if (currentUser != null) {
      dbService.getUserData(uid: currentUser.uid).then((value) {
        user = UserData.fromJson(value);
        trips = user.trips;
      });
    } 

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Trips"),
        automaticallyImplyLeading: false,
      ),

      body: StreamBuilder(
        stream: dbService.getUserTripSnapshot(uid: currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (user.trips.isEmpty) return Text("\n   No Data");
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: (snapshot.data.docs[0])['trips'].length,
            itemBuilder: (BuildContext context, int index){
              final docData = (snapshot.data.docs[0])['trips'];

              return Container(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    docData[index]['title'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    docData[index]['description'],
                    style: const TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    //print(index);
                    // Navigator.pushNamed(context, '/view_trip');
                    Trip _activeTrip = trips[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedTripPage(_activeTrip, index)));
                    
                  },
                ),
              );
            }
         );
       }
     ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //var result = await Navigator.pushNamed(context, '/new_trip');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewTripPage(trips: trips),
                  fullscreenDialog: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
