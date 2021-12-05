import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust_app/classes/trip.dart';
import '/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/classes/userdata.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

var currentUser = FirebaseAuth.instance.currentUser;


// this will have to connect to the trip database
class AddNewTripPage extends StatefulWidget {
  List<Trip> trips = [];
  AddNewTripPage({Key? key, required this.trips}) : super(key: key);

  @override
  State<AddNewTripPage> createState() => _AddNewTripPageState();
}

class _AddNewTripPageState extends State<AddNewTripPage> {
  //AddNewTripPage({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _tripNameController = TextEditingController();
  TextEditingController _descrController = TextEditingController();
  TextEditingController _dateOneController = TextEditingController();
  TextEditingController _dateTwoController = TextEditingController();
  
  String selectedDate = '';
  List<DateTime> dates = [];
  DateTime end = DateTime.now();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('New Trip'),
        actions: [
          IconButton(
            onPressed: (){
              if (_formKey.currentState!.validate()) {
                setState(() {
                  DatabaseService dbService = DatabaseService();
                  var currentUser = FirebaseAuth.instance.currentUser;
                  UserData user = UserData(uid: '', trips: []);
                  if (currentUser != null) {
                    dbService.getUserData(uid: currentUser.uid).then((value) {
                      user = UserData.fromJson(value);
                      //print(user.uid);
                    });
                  }

                  Trip newTrip = Trip.empty();
                  newTrip.title = _tripNameController.text;
                  newTrip.startDate = _dateOneController.text;
                  newTrip.endDate = _dateTwoController.text;
                  newTrip.setDuration();
                  newTrip.setYear(dates[0]);
                  newTrip.setMonth(dates[0]);
                  newTrip.setDescription(_descrController.text);
                  widget.trips.add(newTrip);

                  //print("Title: ${newTrip.title}\n Start: ${newTrip.startDate}\n End: ${newTrip.endDate}\n Duration: ${newTrip.duration}\nYear: ${newTrip.year}\nMonth: ${newTrip.month}\nDescr: ${newTrip.description}");
                  
                  
                  //dbService.addUser(user: user);
                  if (currentUser != null) {
                    UserData testuser =
                        UserData(uid: currentUser.uid, trips: widget.trips);
                    dbService.addUser(user: testuser);
                  }
                
                });
                Navigator.pop(context, true);
              }
            }, 
            icon: Icon(Icons.save),
            tooltip: "Save",
          ),
        ],
      ),

      body: SingleChildScrollView(child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child: TextField(
                  controller: _tripNameController,
                  decoration: InputDecoration(labelText: "Trip Name"),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),

              Container(
                //width: 250,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: TextField(
                  controller: _dateOneController,
                  decoration:
                      InputDecoration(labelText: "Select Start Date"),
                  showCursor: true,
                  readOnly: true,
                  onTap: () {
                    _showDatePicker(context, _dateOneController, dates);
                  },
                ),
              ),

              Container(
                //width: 250,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: TextField(
                  controller: _dateTwoController,
                  decoration:
                      InputDecoration(labelText: "Select End Date"),
                  showCursor: true,
                  readOnly: true,
                  onTap: () {
                    _showDatePicker(context, _dateTwoController, dates);
                  },
                ),
              ),

              Container(
                child: TextField(
                  controller: _descrController,
                  decoration: InputDecoration(labelText: "Brief Description"),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),

          ],
        ),
      )),
      //https://material.io/components/dialogs/flutter#full-screen-dialog
      
    );
  }

  _showDatePicker(BuildContext context, TextEditingController dateC, List<DateTime> date) {
    final DateTime initialDate = DateTime.now();
    final DateTime firstDate = DateTime(2010);
    final DateTime lastDate = DateTime(2040);
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      dates.add(value!);
      setState(() {
        selectedDate = DateFormat('MMMMEEEEd').format(value);
        dateC.text = selectedDate;
      });
    });
  }

}