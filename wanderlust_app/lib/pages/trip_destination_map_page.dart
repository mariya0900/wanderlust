import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:wanderlust_app/classes/activity.dart';

class TripDestinationMap extends StatefulWidget {
  List<Activity> itinerary;
  List<LatLng> locations = [];

  TripDestinationMap({Key? key, required this.itinerary}) : super(key: key);

  @override
  State<TripDestinationMap> createState() => _TripDestinationMapState();
}

class _TripDestinationMapState extends State<TripDestinationMap> {
  @override
  Widget build(BuildContext context) {
    //print(widget.itinerary);
    widget.locations = widget.itinerary
        .map((e) => LatLng(double.parse(e.location.split('/')[1].split(':')[0]),
            double.parse(e.location.split('/')[1].split(':')[1])))
        .toList();

    //mapToCoordinates(widget.itinerary);
    print(widget.locations);
    LatLng center = findCenter(widget.locations);
    return Scaffold(
        appBar: AppBar(
          title: Text("Destination Map"),
        ),
        body: FlutterMap(
            options: MapOptions(
                zoom: 7.0,
                bounds: LatLngBounds(
                    findMin(widget.locations), findMax(widget.locations)),
                center: center),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/maria-anashkina/ckw25vp0bagix15o7e79etyv8/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFyaWEtYW5hc2hraW5hIiwiYSI6ImNrdzI1cWVlaTFzbnIycGxjc2ltdmJpNDUifQ.Vd7p63DG9zLY1WJGCZA8ag",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoibWFyaWEtYW5hc2hraW5hIiwiYSI6ImNrdzI1cWVlaTFzbnIycGxjc2ltdmJpNDUifQ.Vd7p63DG9zLY1WJGCZA8ag',
                    'id': 'mapbox.mapbox-streets-v8'
                  }),
              MarkerLayerOptions(
                  markers: widget.locations
                      .map((e) => Marker(
                          point: e,
                          builder: (BuildContext context) {
                            return IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.location_on),
                              iconSize: 30.0,
                              color: Colors.blueAccent,
                            );
                          }))
                      .toList()),
              PolylineLayerOptions(polylines: [
                Polyline(
                  color: Colors.blueAccent,
                  strokeWidth: 2.0,
                  points: widget.locations.map((e) => (e)).toList(),
                )
              ])
            ]));
  }

  LatLng findCenter(List<LatLng> locations) {
    double lat = 0.0;
    double long = 0.0;
    for (int i = 0; i < locations.length; i++) {
      lat += locations[i].latitude;
      long += locations[i].longitude;
    }
    lat /= locations.length;
    long /= locations.length;
    return LatLng(lat, long);
  }

  LatLng findMin(List<LatLng> locations) {
    double minLat = 90.0;
    double minLong = 80.0;

    for (int i = 0; i < locations.length; i++) {
      if (locations[i].latitude < minLat) {
        minLat = locations[i].latitude;
      }
      if (locations[i].longitude < minLong) {
        minLong = locations[i].longitude;
      }
    }
    return LatLng(minLat, minLong);
  }

  LatLng findMax(List<LatLng> locations) {
    double maxLat = -90.0;
    double maxLong = -180.0;

    for (int i = 0; i < locations.length; i++) {
      if (locations[i].latitude > maxLat) {
        maxLat = locations[i].latitude;
      }
      if (locations[i].longitude > maxLong) {
        maxLong = locations[i].longitude;
      }
    }
    return LatLng(maxLat, maxLong);
  }

  /*void mapToCoordinates(List<Activity> it) async {
      //List<LatLng> coordinates=[];
      for (int i=0;i<it.length;i++){
        String address=it[i].location;
        List<Location> locations = await locationFromAddress(address);
        var first=locations.first;
        widget.locations.add(LatLng(first.latitude, first.longitude));
      }
    //print(widget.locations);
    //return coordinates;
    } */

}
