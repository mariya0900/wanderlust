import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/classes/userdata.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');

  void addTrip(
      {required String uid,
      required String title,
      required String year,
      required String duration,
      required String month,
      required String description}) {
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

  void addTripWithClass(Trip trip) {
    trips
        .add(trip.toJson())
        .then((value) => print("Trip Added"))
        .catchError((error) => print("Failed to add trip: $error"));
  }

  void addActivity(
      {required String uid,
      required String name,
      required String aditionalInfo,
      required String location,
      required String date,
      required String startTime,
      required String endTime}) {
    trips
        .add({
          'uid': uid,
          'name': name,
          'aditionalInfo': aditionalInfo,
          'location': location,
          'date': date,
          'startTime': startTime,
          'endTime': endTime
        })
        .then((value) => print("Activity Added"))
        .catchError((error) => print("Failed to add activity: $error"));
  }

  Future<List<Trip>?> getTrips({required String uid}) async {
    QuerySnapshot snapshot =
        await firestore.collection('trips').where('uid', isEqualTo: uid).get();
    List<Trip> trips = [];
    for (var trip in snapshot.docs) {
      trips.add(Trip(trip['title'], trip['year'], trip['duration'],
          trip['month'], trip['description']));
    }
    return trips;
  }

  void addUser({required UserData user}) {
    print(user.toJson());
    userData
        .doc(user.uid)
        .set(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<dynamic> getUserData({required String uid}) async {
    DocumentSnapshot snapshot = await userData.doc(uid).get();
    return snapshot.data();
  }

  Stream<QuerySnapshot>getUserTripSnapshot({required String uid}) {
    //DocumentSnapshot snapshot = await userData.doc(uid).get();
    //return snapshot.data();
    return userData.where('uid', isEqualTo: uid).snapshots();
  }
}
