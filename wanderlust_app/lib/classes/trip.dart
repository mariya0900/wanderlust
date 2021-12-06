//https://api.flutter.dev/flutter/intl/DateFormat-class.html
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'activity.dart';
import 'package:camera/camera.dart';

// add intl: 0.17.0 to dependencies in the pubspec.yaml
// Edit this when working on Add Trip page

class Trip {
  List<Activity> itinerary = [];
  List<String> gallery = [];
  List<CameraDescription> cameras = [];

  String title = '',
      startDate = '',
      endDate = '',
      duration = '',
      year = '',
      month = '';
  late String? description = '';

  //DateTime.now().year sets current year by default
  //int ?month=DateTime.now().month;

  //late Duration _duration;
  //late Location _location;

  void setYear(DateTime? date) {
    year = DateFormat('y').format(date!);
  }

  void setMonth(DateTime? date) {
    month = DateFormat('MMMM').format(date!);
  }

  void setStartDate(DateTime? date) {
    // MONTH_WEEKDAY_DAY
    startDate = DateFormat('MMMMEEEEd').format(date!);
  }

  void setEndDate(DateTime? date) {
    endDate = DateFormat('MMMMEEEEd').format(date!);
  }

  void setDuration() {
    duration = startDate + ' to ' + endDate;
  }

  void setDescription(String descr) {
    description = descr;
  }

  /**void setLocation(Location location){
    _location=location;
  }*/

  //Trip(this._year, this._duration, this._location, [this.month, this.description]);

  Trip.empty();
  Trip(this.title, this.year, this.duration, this.month, this.description);

  void setItinerary(List<Activity> it) {
    itinerary = it;
  }

  List<Activity> getItinerary() {
    return itinerary;
  }
  

  void setGallery(List<String> gal) {
    gallery = gal;
  }

  List<String> getGallery() {
    return gallery;
  }

  void setCamera(List<CameraDescription> cam) async {
    cameras = await availableCameras();
    cameras = cam;
  }

  List<CameraDescription> getCamera() {
    return cameras;
  }

  // Maps Json to Trip Object
  factory Trip.fromJson(Map<String, dynamic> json) {
    Trip trip = Trip(json['title'], json['year'], json['duration'],
        json['month'], json['description']);

    trip.startDate = json['startDate'];
    trip.endDate = json['endDate'];

    List<Activity> activityList = json['itinerary'].map<Activity>((activity) {
      return Activity.fromJson(activity);
    }).toList();

    trip.itinerary = activityList;
    return trip;
  }

  // Maps Trip Object to Json
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> convertedActivities = [];
    itinerary.forEach((activity) {
      Activity thisActivity = activity as Activity;
      convertedActivities.add(thisActivity.toJson());
    });
    return {
      'title': title,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'duration': duration.toString(),
      'month': month.toString(),
      'description': description,
      'itinerary': convertedActivities,
      'year': year.toString()
    };
  }
}
