import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/pages/auth/create_account_page.dart';
import 'package:wanderlust_app/pages/auth/password_reset_page.dart';
import 'classes/trip.dart';
import 'custom_theme.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: CustomTheme.lightTheme,
      home: MyLoginPage(),
      routes: {
        '/create_account': (context) => CreateAccountPage(),
        '/login_successful': (context) => HomepageMyTrips(),
        '/reset_password': (context) => PasswordResetPage(),
        '/open_map': (context) => TripDestinationMap(),
        //'/open_gallery': (context) => TripGallery(),
        //'/open_itinerary': (context) => TripItinerary(trip: _activeTrip,),
        '/set_reminder': (context) => TripSetReminder(),

        //'/new_trip': (context) => AddNewTripPage(),
        //'/view_trip': (context) => SelectedTripPage(),
      },
    );
  }
}
