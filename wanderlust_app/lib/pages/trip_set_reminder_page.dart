import 'package:flutter/material.dart';
import '../classes/notification.dart';

class TripSetReminder extends StatefulWidget {
  TripSetReminder({Key? key}) : super(key: key);

  @override
  State<TripSetReminder> createState() => _TripSetReminder();
}

class _TripSetReminder extends State<TripSetReminder> {
  final messageController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Set Trip Reminder'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //picture box

            Text("Select Date"),
            ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")),
            Text("Select Time"),
            ElevatedButton(
              onPressed: _selectStartTime,
              child: Text("${selectedDate.hour}:${selectedDate.minute}"),
            ),

            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: "Notification Title"),
            ),
            ElevatedButton(
              onPressed: () {
                TripNotification(context).showScheduledNotification(
                    selectedDate, selectedTime, messageController.text);

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Reminder Created")));
              },
              child: Text("Set Reminder"),
            ),
          ],
        )));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  _selectStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
        selectedDate = new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute, 0, 0, 0);
      });
    }
  }
}
