import 'location.dart';

class Activity{
  // date/time, location, name, duration.
  String name, date, duration;
  
  String ?additionalInfo; 
  //Location ?location; DateTime ?dateTime;

  //Activity(this._name, [this.dateTime, this.location, this.additionalInfo]);
  Activity(this.name, this.date, this.duration, [this.additionalInfo]);
}