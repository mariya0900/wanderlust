import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanderlust_app/classes/trip.dart';

class UserData {
  final String uid;
  final List<Trip> trips;

  UserData({required this.uid, required this.trips});

  // Maps Json to Activity
  factory UserData.fromJson(Map<String, dynamic> json) {
    List<Trip> tripList = json['trips'].map<Trip>((trip) {
      return Trip.fromJson(trip);
    }).toList();
    return UserData(uid: json['uid'], trips: tripList);
  }

  // Maps Activity to Json
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> convertedTrips = [];
    trips.forEach((trip) {
      Trip thisTrip = trip as Trip;
      convertedTrips.add(thisTrip.toJson());
    });
    return {'uid': uid, 'trips': convertedTrips};
  }
}
