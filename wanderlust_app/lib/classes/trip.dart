import 'location.dart';
import 'activity.dart';

// Edit this when working on Add Trip page

class Trip{

  List<Activity> itinerary = [];

  String title = '';
  int _year=DateTime.now().year; //sets current year by default
  int ?month=DateTime.now().month;
  String duration;
  //late Duration _duration;
  //late Location _location;
  late String ?description = '';
  
  
  void setYear(int year){
    _year=year;
  }

  void setMonth(int month){
    month=month;
  }

  void setDuration(String duration){
    duration=duration;
  }

  /**void setLocation(Location location){
    _location=location;
  }*/

  void setDescription(String descr){
    description=descr;
  }

  //Trip(this._year, this._duration, this._location, [this.month, this.description]);
  Trip(this.title, this._year, this.duration, [this.month, this.description]);

}