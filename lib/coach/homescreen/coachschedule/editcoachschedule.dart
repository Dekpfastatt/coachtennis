import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditCoachSchedule extends StatefulWidget {
  DocumentSnapshot coachschedule;
  EditCoachSchedule({Key key, this.coachschedule}) : super(key: key);

  @override
  _EditCoachScheduleState createState() => _EditCoachScheduleState();
}

class _EditCoachScheduleState extends State<EditCoachSchedule> {
  TextEditingController dateController = new TextEditingController();
  TextEditingController studentController = new TextEditingController();
  TextEditingController clubController = new TextEditingController();
  TextEditingController timeFromController = new TextEditingController();
  TextEditingController timeToController = new TextEditingController();
  bool _paiementvalue = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentController.text = widget.coachschedule['studentname'];
    clubController.text = widget.coachschedule['clubdetails'];
    timeFromController.text = widget.coachschedule['timefrom'];
    dateController.text = widget.coachschedule['scheduledate'];
    timeToController.text = widget.coachschedule['timeto'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coach Schedule",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Edit schedule",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                        labelText: "Schedule date",
                        hintText: "Schedule date",
                        border: OutlineInputBorder()),
                    autofocus: false,
                    onTap: () async {
                      DateTime date = DateTime(2021);
                      DateFormat formatter = DateFormat('dd/MM/yyyy');
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2100));

                      dateController.text = formatter.format(date);
                    },
                  )),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: studentController,
                  decoration: const InputDecoration(
                      labelText: "student",
                      hintText: "student",
                      border: OutlineInputBorder()),
                  autofocus: false,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: clubController,
                  decoration: const InputDecoration(
                      labelText: "club",
                      hintText: "club",
                      border: OutlineInputBorder()),
                  autofocus: false,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: timeFromController,
                  decoration: const InputDecoration(
                      labelText: "Time from",
                      hintText: "Time from",
                      border: OutlineInputBorder()),
                  autofocus: false,
                  onTap: () async {
                    TimeOfDay pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      String formattedTime =
                          DateFormat('HH:mm').format(parsedTime);
                      setState(() {
                        timeFromController.text = formattedTime;
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: timeToController,
                  decoration: const InputDecoration(
                      labelText: "Time To",
                      hintText: "Time To",
                      border: OutlineInputBorder()),
                  autofocus: false,
                  onTap: () async {
                    TimeOfDay pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickedTime.format(context).toString());
                      String formattedTime =
                          DateFormat('HH:mm').format(parsedTime);
                      setState(() {
                        timeToController.text = formattedTime;
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Transform.scale(
                      scale: 2.0,
                      child: Switch(
                        value: _paiementvalue,
                        onChanged: (value) {
                          setState(() {
                            _paiementvalue = value;
                          });
                        },
                        activeColor: Colors.green,
                        activeTrackColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.red,
                      )),
                  Text(
                    'Amount to be paid: 30€',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text("Update Schedule"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  final String dateSchedule = dateController.text.trim();
                  final String student = studentController.text.trim();
                  final String timefrom = timeFromController.text.trim();
                  final String timeto = timeToController.text.trim();
                  final String club = clubController.text.trim();
                  final bool paiement = _paiementvalue;

                  final firestoreInstance =
                      FirebaseFirestore.instance.collection('coachschedule');

                  if (student.isEmpty && timefrom.isEmpty && club.isEmpty) {
                    print("Missing input");
                  } else {
                    firestoreInstance.doc(widget.coachschedule.id).update({
                      "scheduledate": dateSchedule.toString(),
                      "clubdetails": club.toString(),
                      "studentname": student.toString(),
                      "timefrom": timefrom.toString(),
                      "timeto": timeto.toString(),
                      "paiement": paiement.toString(),
                    });
                    dateController.text = '';
                    studentController.text = '';
                    timeFromController.text = '';
                    timeToController.text = '';
                    clubController.text = '';
                    _paiementvalue = false;

                    Navigator.of(context).pop();
                  }
                })
          ],
        ),
      ),
    );
  }
}
