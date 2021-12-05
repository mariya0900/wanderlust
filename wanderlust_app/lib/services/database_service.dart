import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wanderlust_app/classes/trip.dart';
import 'package:wanderlust_app/classes/userdata.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');

  void addUser({required UserData user}) {
    print('DATA SAVED: ' + user.toJson().toString());
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

  Stream<QuerySnapshot> getUserTripSnapshot({required String uid}) {
    //DocumentSnapshot snapshot = await userData.doc(uid).get();
    //return snapshot.data();
    return userData.where('uid', isEqualTo: uid).snapshots();
  }
}
