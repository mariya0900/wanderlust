import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/pages/add_new_activity_page.dart';

class TripItinerary extends StatefulWidget {
  final Trip trip;
  List<Activity> itinerary=[Activity("someActivity", "28 July", "Toronto, Canada", "1 week", "CN tower, Ripleys blablabla")];

  TripItinerary({Key? key, required this.trip, required this.itinerary})
      : super(key: key);

  @override
  State<TripItinerary> createState() => _TripItineraryState();
}

class _TripItineraryState extends State<TripItinerary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      //the itinerary (list of activiy objects)
      body: //Center(child: Text('change to a list view')),
          ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: widget.itinerary.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Container(
                      padding: EdgeInsets.symmetric(vertical: 7.0),
                      child: Text(
                        widget.itinerary[index].name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(widget.itinerary[index].location,
                              style: const TextStyle(fontSize: 12, color: Colors.black)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(widget.itinerary[index].additionalInfo,
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.itinerary[index].date),
                        Text(widget.itinerary[index].duration, style: const TextStyle(color: Colors.grey),)
                      ]),
                  ),
                );
              }),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var result=await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddNewActivityPage(itinerary: widget.itinerary)));
          if (result==true){
            setState(() {
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
