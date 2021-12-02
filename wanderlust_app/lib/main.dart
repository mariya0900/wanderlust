import 'package:flutter/material.dart';
import 'classes/trip.dart';
import 'pages/auth/login_page.dart';
import 'pages/homepage_my_trips.dart';
import 'pages/add_new_trip_page.dart';
import 'pages/selected_trip_page.dart';
import 'pages/trip_destination_map_page.dart';
import 'pages/trip_gallery_page.dart';
import 'pages/trip_itinerary_page.dart';
import 'pages/trip_set_reminder_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(const MyApp());
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanderlust App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyLoginPage(),
      routes: {
        '/login_successful': (context) => HomepageMyTrips(),
        '/open_map': (context) => TripDestinationMap(),
        '/open_gallery': (context) => TripGallery(),
        //'/open_itinerary': (context) => TripItinerary(trip: _activeTrip,),
        '/set_reminder': (context) => TripSetReminder(),

        //'/new_trip': (context) => AddNewTripPage(),
        //'/view_trip': (context) => SelectedTripPage(),
      },
    );
  }
}
