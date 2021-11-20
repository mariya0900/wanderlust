import 'package:flutter/material.dart';


class TripSetReminder extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Trip Reminder'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),

      body: Center(child: Text('Add Reminder Notification')),
      //body:  SetNotificationWidget(),
    );
  }
}
