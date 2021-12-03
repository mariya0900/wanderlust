import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/activity.dart';
import 'package:wanderlust_app/pages/trip_itinerary_page.dart';

class AddNewActivityPage extends StatefulWidget {
  late List<Activity> itinerary;

  AddNewActivityPage({Key? key, required this.itinerary}) : super(key: key);

  @override
  State<AddNewActivityPage> createState() => _AddNewActivityPageState();
}

class _AddNewActivityPageState extends State<AddNewActivityPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final additionalController = TextEditingController();
  String name = '';
  String location = '';
  String additionalInfo = '';
  DateTime date = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay endTime = TimeOfDay(hour: 7, minute: 15);
  String timeOfActivity = '';

  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Activity"), actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  name = nameController.text;
                  location = locationController.text;
                  additionalInfo = additionalController.text;
                  Activity newActivity = Activity(
                      name, date, startTime, endTime, location, additionalInfo);
                  widget.itinerary.add(newActivity);
                });
                Navigator.pop(context, true);
              }
            },
            icon: Icon(Icons.save),
            tooltip: "Save",
          ),
        ]),
        body: Form(
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
                          onPressed: _selectStartTime,
                          child: Text("${startTime.hour}:${startTime.minute}"),
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
                          onPressed: _selectEndTime,
                          child: Text("${endTime.hour}:${endTime.minute}"),
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
        ));
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

  _selectStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (newTime != null) {
      setState(() {
        startTime = newTime;
      });
    }
  }

  _selectEndTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (newTime != null) {
      setState(() {
        endTime = newTime;
      });
    }
  }
}
