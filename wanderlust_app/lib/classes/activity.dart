import 'package:flutter/material.dart';

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
}
