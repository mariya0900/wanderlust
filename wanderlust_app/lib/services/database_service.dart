import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference trips = FirebaseFirestore.instance.collection('trips');

  void addTrip(
      {required String uid,
      required String title,
      required String year,
      required String duration,
      required String month,
      required String description}) {
    // Call the user's CollectionReference to add a new user
    trips
        .add({
          'uid': uid,
          'title': title,
          'year': year,
          'duration': duration,
          'month': month,
          'description': description
        })
        .then((value) => print("Trip Added"))
        .catchError((error) => print("Failed to add trip: $error"));
  }
}
