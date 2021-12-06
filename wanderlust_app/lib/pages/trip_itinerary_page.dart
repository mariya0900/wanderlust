import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/pages/add_new_activity_page.dart';
import 'package:wanderlust_app/globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import '/services/database_service.dart';
import '/classes/userdata.dart';

class TripItinerary extends StatefulWidget {
  //final Trip trip;
  //final int tripID;
  //List<Activity> itinerary = [];

  TripItinerary({Key? key}) : super(key: key);

  @override
  State<TripItinerary> createState() => _TripItineraryState();
}

class _TripItineraryState extends State<TripItinerary> {
  DatabaseService dbService = DatabaseService();
  UserData user = UserData(uid: '', trips: []);
  var currentUser = FirebaseAuth.instance.currentUser;
  List<Activity> itinerary = [];

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      dbService.getUserData(uid: currentUser!.uid).then((value) {
        user = UserData.fromJson(value);
        itinerary = user.trips[globals.selectedTripId].itinerary;
      });
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Itinerary'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                DatabaseService dbService = DatabaseService();
                var currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null){
                  dbService.getUserData(uid: currentUser.uid).then((value) {
                    UserData user = UserData.fromJson(value);
                    user.trips[globals.selectedTripId].itinerary.removeAt(selectedIndex);
                    UserData testuser = UserData(uid: currentUser.uid, trips: user.trips);
                    dbService.addUser(user: testuser);
                  });
                }
                setState(() {});
              }),
            IconButton(
              onPressed: (){setState(() {});}, 
              icon: Icon(Icons.refresh)
            ),
          ]),

      //the itinerary (list of activiy objects)
      body: StreamBuilder(
        stream: dbService.getUserTripSnapshot(uid: currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (itinerary.isEmpty) return Text("\n   Load Itinerary or Add Activity");  
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: (snapshot.data.docs[0])['trips'][globals.selectedTripId]['itinerary'].length,
              itemBuilder: (BuildContext context, int index){
                final docData = (snapshot.data.docs[0])['trips'][globals.selectedTripId]['itinerary'];
                print((snapshot.data.docs[0])['trips'][globals.selectedTripId]['itinerary'].length);

                return Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: (index == selectedIndex) ? (Colors.green[300])  : (Colors.transparent)
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Container(
                      padding: EdgeInsets.symmetric(vertical: 7.0),
                      child: Text(
                        docData[index]['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(docData[index]['location'],
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                              docData[index]['additionalInfo'],
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "${docData[index]['date'].day}/${docData[index]['date'].month}/${docData[index]['date'].year}"),
                        Text(
                          "${docData[index]['startTime'].hour}:${docData[index]['startTime'].minute} - ${docData[index]['endTime'].hour}:${docData[index]['endTime'].minute}",
                          style: const TextStyle(color: Colors.white),
                        )
                      ]),
                    
                    onTap: () async{
                      selectedIndex = index;
                      setState(() {});
                    },
                  )

                ));
              }
            );
          }
      ),
          

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddNewActivityPage()));
          if (result == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
