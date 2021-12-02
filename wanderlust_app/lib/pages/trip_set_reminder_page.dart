import 'package:flutter/material.dart';

import 'notification.dart';

class TripSetReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Set Trip Reminder'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: Column(
          children: [
            Container(
                //Picture of activity
                child: ElevatedButton(
              onPressed: () {
                TripNotification(context).showNotification();
              },
              child: Text("Simple Notification"),
            )),
            Row(
              children: [
                Text("Date"
                    //Date picker label
                    ),
                Text("Date"),
                //
              ],
            ),
            Row(
              children: [
                Text("Time"
                    //Time picker label
                    ),
                Text("Time"),
                //
              ],
            ),
          ],
        )));
  }
}
