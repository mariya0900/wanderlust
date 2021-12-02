//https://api.flutter.dev/flutter/intl/DateFormat-class.html
import 'package:intl/intl.dart';
import 'location.dart';
import 'activity.dart';

// add intl: 0.17.0 to dependencies in the pubspec.yaml 
// Edit this when working on Add Trip page

class Trip{

  List<Activity> itinerary = [];

  String title = '', startDate = '', endDate = '', duration = '', year = '', month = ''; 
  late String ?description = '';

  //DateTime.now().year sets current year by default
  //int ?month=DateTime.now().month;
  
  //late Duration _duration;
  //late Location _location;
  
  void setYear(DateTime? date){
    year = DateFormat('y').format(date!);
  }

  void setMonth(DateTime? date){
    month = DateFormat('MMMM').format(date!);
  }

  void setStartDate(DateTime? date){
    // MONTH_WEEKDAY_DAY
    startDate = DateFormat('MMMMEEEEd').format(date!);
  }
  
  void setEndDate(DateTime? date){
    endDate = DateFormat('MMMMEEEEd').format(date!);
  }

  void setDuration(){
    duration = startDate + ' to ' + endDate;
  }

  void setDescription(String descr){
    description = descr;
  }

  /**void setLocation(Location location){
    _location=location;
  }*/

  //Trip(this._year, this._duration, this._location, [this.month, this.description]);

  Trip(this.title, this.year, this.duration, this.month, this.description);

  void setItinerary(List<Activity> it){
    itinerary=it;
  }
  List<Activity> getItinerary(){
    return itinerary;
  }

}