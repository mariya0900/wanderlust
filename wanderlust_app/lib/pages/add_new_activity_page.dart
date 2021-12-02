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
  GlobalKey <FormState>_formKey=GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final locationController = TextEditingController();
  final durationController = TextEditingController();
  final additionalController = TextEditingController();
  String name='';
  String date='';
  String location='';
  String duration='';
  String additionalInfo='';
  
  String description='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Activity"), actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()){
                setState(() {
                  name=nameController.text;
                  date=dateController.text;
                  location=locationController.text;
                  duration=durationController.text;
                  additionalInfo=additionalController.text;
                  Activity newActivity=Activity(name, date, location, duration, additionalInfo);
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
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(labelText: "Date"),
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
                    controller: durationController,
                    decoration: InputDecoration(labelText: "Duration"),
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
}
