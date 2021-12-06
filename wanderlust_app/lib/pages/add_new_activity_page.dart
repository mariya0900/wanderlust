import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';

import 'package:wanderlust_app/pages/trip_destination_map_page.dart';
import 'package:wanderlust_app/pages/trip_itinerary_page.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import 'package:wanderlust_app/globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import '/services/database_service.dart';
import '/classes/userdata.dart';

class AddNewActivityPage extends StatefulWidget {
  late List<Activity> itinerary;

  AddNewActivityPage({Key? key}) : super(key: key);

  @override
  State<AddNewActivityPage> createState() => _AddNewActivityPageState();
}

class _AddNewActivityPageState extends State<AddNewActivityPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final additionalController = TextEditingController();
  String name = '';
  String location='';
  
  String additionalInfo = '';
  DateTime date = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 00);
  String timeOfActivity = '';
  String description = '';
  String startTimeTextHour = "12:";
  String startTimeTextMinute = "00";
  String startTimeTextEnd = " am";
  String endTimeTextHour = "12:";
  String endTimeTextMinute = "00";
  String endTimeTextEnd = " am";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Activity"), actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                name = nameController.text;
                location = locationController.text;
                additionalInfo = additionalController.text;
                Activity newActivity = Activity(name, date, startTime, endTime, location, additionalInfo);
                newActivity.setLocation(location);
                
                DatabaseService dbService = DatabaseService();
                var currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null){
                  dbService.getUserData(uid: currentUser.uid).then((value) {
                    UserData user = UserData.fromJson(value);
                    user.trips[globals.selectedTripId].itinerary.add(newActivity);
                    UserData testuser = UserData(uid: currentUser.uid, trips: user.trips);
                    dbService.addUser(user: testuser);
                  });
                }
                setState(() {});
                Navigator.pop(context, true);
              }
            },
            icon: Icon(Icons.save),
            tooltip: "Save",
          ),
        ]),
        body:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Activity name"),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                Container(
                    child: Row(
                      children: [
                        Text("Date:                          ",
                            style: TextStyle(fontSize: 16)),
                        Container(
                          child: ElevatedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              child:
                                  Text("${date.day}/${date.month}/${date.year}")),
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
                Container(
                    child: Row(
                      children: [
                        Text("Start Time:                     ",
                            style: TextStyle(fontSize: 16)),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              _selectStartTime(context);
                            },
                            child: Text(startTimeTextHour +
                                startTimeTextMinute +
                                startTimeTextEnd),
                          ),
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
                Container(
                    child: Row(
                      children: [
                        Text(" End Time:                      ",
                            style: TextStyle(fontSize: 16)),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              _selectEndTime(context);
                            },
                            child: Text(endTimeTextHour +
                                endTimeTextMinute +
                                endTimeTextEnd),
                          ),
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
                Container(
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(labelText: "Location"),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
                Container(
                    child: TextField(
                      controller: additionalController,
                      decoration: InputDecoration(labelText: "Additional info"),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
              ],
            ),
          )
        )
      );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != date)
      setState(() {
        date = selected;
      });
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (newTime != null) {
      setState(() {
        startTime = newTime;

        if (startTime.hour == 0) {
          startTimeTextHour = "12:";
          startTimeTextEnd = " am";
        } else if (startTime.hour == 12) {
          startTimeTextHour = "12:";
          startTimeTextEnd = " pm";
        } else if (startTime.hour > 11) {
          startTimeTextHour = "${(startTime.hour - 12)}:";
          startTimeTextEnd = " pm";
        } else {
          startTimeTextHour = "${startTime.hour}:";
          startTimeTextEnd = " am";
        }

        if (startTime.minute < 10) {
          startTimeTextMinute = "0" + "${startTime.minute}";
        } else {
          startTimeTextMinute = "${startTime.minute}";
        }
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (newTime != null) {
      setState(() {
        endTime = newTime;
        if (endTime.hour == 0) {
          endTimeTextHour = "12:";
          endTimeTextEnd = " am";
        } else if (endTime.hour == 12) {
          endTimeTextHour = "12:";
          endTimeTextEnd = " pm";
        } else if (endTime.hour > 11) {
          endTimeTextHour = "${(endTime.hour - 12)}:";
          endTimeTextEnd = " pm";
        } else {
          endTimeTextHour = "${endTime.hour}:";
          endTimeTextEnd = " am";
        }

        if (endTime.minute < 10) {
          endTimeTextMinute = "0" + "${endTime.minute}";
        } else {
          endTimeTextMinute = "${endTime.minute}";
        }
      });
    }
  }
}
