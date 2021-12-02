import 'location.dart';

class Activity{
  // date/time, location, name, duration.
  String name, date, duration;
  
  String additionalInfo; 
  String location; 
  //DateTime ?dateTime;

  //Activity(this._name, [this.dateTime, this.location, this.additionalInfo]);
  Activity(this.name, this.date, this.location, this.duration, this.additionalInfo);
}