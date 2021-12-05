import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../classes/notification.dart';

class TripSetReminder extends StatefulWidget {
  TripSetReminder({Key? key}) : super(key: key);

  @override
  State<TripSetReminder> createState() => _TripSetReminder();
}

class _TripSetReminder extends State<TripSetReminder> {
  final messageController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  String timeTextHour = "12:";
  String timeTextMinute = "00";
  String timeTextEnd = " am";

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
              onPressed: () {
                formatTime();
                _selectTime(context);
                formatTime();
              },
              child: Text(timeTextHour + timeTextMinute + timeTextEnd),
            ),

            Container(
                alignment: Alignment.center,
                width: 200,
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(labelText: "Notification Title"),
                )),
            ElevatedButton(
              onPressed: () {
                if (messageController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No Reminder Title")));
                } else {
                  TripNotification(context).showScheduledNotification(
                      selectedDate, selectedTime, messageController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Reminder Created")));

                  messageController.text = "";
                  selectedDate = DateTime.now();
                  selectedTime = TimeOfDay(hour: 0, minute: 0);
                  formatTime();
                }
              },
              child: Text("Set Reminder"),
            ),
            ElevatedButton(
              onPressed: () {
                deleteNote;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Reminders Deleted")));
              },
              child: Text("Delete All Notifications"),
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

  _selectTime(BuildContext context) async {
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
      formatTime();
    }
  }

  deleteNote() async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }

  formatTime() {
    if (selectedTime.hour == 0) {
      timeTextHour = "12:";
      timeTextEnd = " am";
    } else if (selectedTime.hour == 12) {
      timeTextHour = "12:";
      timeTextEnd = " pm";
    } else if (selectedTime.hour > 11) {
      timeTextHour = "${(selectedTime.hour - 12)}:";
      timeTextEnd = " pm";
    } else {
      timeTextHour = "${selectedTime.hour}:";
      timeTextEnd = " am";
    }

    if (selectedTime.minute < 10) {
      timeTextMinute = "0" + "${selectedTime.minute}";
    } else {
      timeTextMinute = "${selectedTime.minute}";
    }
  }
}
