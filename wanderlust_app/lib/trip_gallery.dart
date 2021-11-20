import 'package:flutter/material.dart';

class TripGallery extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      //if the gallery doesn't work we can do camera instead
      body: Center(child: Text('change to a grid view')),
    );
  }
}