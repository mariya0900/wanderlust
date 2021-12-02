import 'package:flutter/material.dart';
import 'package:wanderlust_app/pages/trip_itinerary_page.dart';
import '/classes/trip.dart';

// The _activeTrip may have to get passed to each of navigator pushes below

class SelectedTripPage extends StatelessWidget {
  final Trip _activeTrip;
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  SelectedTripPage(this._activeTrip, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? header = Colors.green[300];
    Color? options = Colors.green[100];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // if this causes a problem, we can use a back icon and pop context instead
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
                      height: 150,
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.green[200],
                      child: Text.rich(
                        TextSpan(
                          //text: 'Hello', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: '${_activeTrip.title}\n',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: _activeTrip.month,
                                style: TextStyle(fontSize: 16)),
                            TextSpan(
                                text: ' ~ ${_activeTrip.duration}',
                                style: TextStyle(fontSize: 16)),
                            TextSpan(
                                text: '\n${_activeTrip.description}',
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
                          builder: (context) => TripItinerary(trip:_activeTrip, itinerary: _activeTrip.getItinerary(),)));
                  },
                ),
                GestureDetector(
                  child:
                      makeOptionContainer(Colors.green[50], 'Destination Map'),
                  onTap: () {
                    Navigator.pushNamed(context, '/open_map');
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
                  onTap: () {
                    Navigator.pushNamed(context, '/open_gallery');
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedTripPage(_activeTrip)));
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
