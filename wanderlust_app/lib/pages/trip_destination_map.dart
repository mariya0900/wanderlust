import 'package:flutter/material.dart';

class TripDestinationMap extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Destination Map'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      // map of the trip location (maybe using a google maps api)
      body: Center(child: Text('the map')),
    );
  }
}