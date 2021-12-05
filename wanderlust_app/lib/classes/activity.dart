import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong/latlong.dart';

import 'location.dart';

class Activity {
  // date/time, location, name, duration.
  String name;
  String additionalInfo;
  String location;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  
  //Activity(this._name, [this.dateTime, this.location, this.additionalInfo]);
  Activity(this.name, this.date, this.startTime, this.endTime, this.location,
      this.additionalInfo);
  
 

  // Maps Activity to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toString(),
      'startTime':
          startTime.hour.toString() + ':' + startTime.minute.toString(),
      'endTime': endTime.hour.toString() + ':' + endTime.minute.toString(),
      'location': location,
      'additionalInfo': additionalInfo,
    };
  }

  // Maps Json to Activity
  factory Activity.fromJson(Map<String, dynamic> json) {
    Activity activity = Activity(
        json['name'],
        DateTime.parse(json['date']),
        TimeOfDay(
            hour: int.parse(json['startTime'].split(":")[0]),
            minute: int.parse(json['startTime'].split(":")[1])),
        TimeOfDay(
            hour: int.parse(json['endTime'].split(":")[0]),
            minute: int.parse(json['endTime'].split(":")[1])),
        json['location'],
        json['additionalInfo']);
    return activity;
  }
}
