import 'package:flutter/material.dart';

class TripItinerary extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      //the itinerary (list of activiy objects)
      body: Center(child: Text('change to a list view')),
    );
  }
}