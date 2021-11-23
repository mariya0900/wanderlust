import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

// this will have to connect to the trip database
class AddNewTripPage extends StatelessWidget {
  //AddNewTripPage({Key? key}) : super(key: key);
  TextEditingController _tripNameController = TextEditingController();
  TextEditingController _descrController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('New Trip'),
      ),

      body: Center(child: Text('Full Screen Dialog')),
      //https://material.io/components/dialogs/flutter#full-screen-dialog
      
    );
  }
}