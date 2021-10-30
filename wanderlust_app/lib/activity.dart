import 'location.dart';

class Activity{
  final String _name;
  DateTime ?dateTime;
  Location ?location;
  String ?additionalInfo;

  Activity(this._name, [this.dateTime, this.location, this.additionalInfo]);
}