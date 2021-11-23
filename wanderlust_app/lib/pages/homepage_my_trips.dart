import 'package:flutter/material.dart';
import '../trip.dart';
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
  // use a CollectionReference to a trips database

  // for UI testing purposes
  //Trip test1 = Trip('Test Trip One', 2022, Duration(days: 7), 10, 'just a test 1');

  Trip test1 = Trip('Test Trip One', 2022, 'One Week', 10, 'just a test 1');
  Trip test2 = Trip('Test Trip Two', 2022, 'Three Days', 5, 'just a test 2');
  List<Trip> trips = [];

  @override
  Widget build(BuildContext context) {
    // more UI testing
    if (trips.isEmpty) {
      trips.add(test1);
      trips.add(test2);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Trips"),
        automaticallyImplyLeading: false,
      ),

      // replace with StreamBuilderWidget if trip data on cloud
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: trips.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(
                  trips[index].title,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  "${trips[index].description}",
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () {
                  print(index);
                  // Navigator.pushNamed(context, '/view_trip');
                  Trip _activeTrip = trips[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectedTripPage(_activeTrip)));
                },
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //var result = await Navigator.pushNamed(context, '/new_trip');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewTripPage(),
                  fullscreenDialog: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
