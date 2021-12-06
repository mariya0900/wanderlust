// @dart=2.9
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/pages/add_new_image.dart';
import 'package:wanderlust_app/pages/auth/create_account_page.dart';
import 'package:wanderlust_app/pages/auth/password_reset_page.dart';
import 'package:wanderlust_app/pages/auth/verify_email_page.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  await Firebase.initializeApp();
  runApp(MyApp(
    camera: firstCamera,
  ));
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.camera}) : super(key: key);

  final camera;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanderlust App',
      theme: CustomTheme.lightTheme,
      home: MyLoginPage(),
      routes: {
        '/create_account': (context) => CreateAccountPage(),
        '/login_successful': (context) => VerifyEmailPage(),
        '/account_verified': (context) => HomepageMyTrips(),
        '/reset_password': (context) => PasswordResetPage(),
        '/start': (context) => MyLoginPage(),
        //'/open_map': (context) => TripDestinationMap(),
        //'/open_gallery': (context) => TripGallery(),
        //'/open_itinerary': (context) => TripItinerary(trip: _activeTrip,),
        '/set_reminder': (context) => TripSetReminder(),
        '/open_camera': (context) => AddNewImage(camera: camera)

        //'/new_trip': (context) => AddNewTripPage(),
        //'/view_trip': (context) => SelectedTripPage(),
      },
    );
  }
}
