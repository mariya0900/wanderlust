import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class ActivityLocation{

  late String location;
  late LatLng coordinates;

  ActivityLocation(this.location){
    setCoordinates(location);
  }

  void setCoordinates(String loc) async {
    
    List<Location> locations = await locationFromAddress(loc);
    var first=locations.first;
                  //print("${first.latitude} : ${first.longitude}");
    coordinates=LatLng(first.latitude, first.longitude);

  }
}