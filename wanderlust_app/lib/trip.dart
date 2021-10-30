import 'location.dart';

class Trip{

  int _year=DateTime.now().year; //sets current year by default
  int ?month=DateTime.now().month;
  late Duration _duration;
  late Location _location;
  late String ?description='';
  
  
  void setYear(int year){
    _year=year;
  }

  void setMonth(int month){
    month=month;
  }

  void setDuration(Duration duration){
    _duration=duration;
  }

  void setLocation(Location location){
    _location=location;
  }

  void setDescription(String descr){
    description=descr;
  }

  Trip(this._year, this._duration, this._location, [this.month, this.description]);

}