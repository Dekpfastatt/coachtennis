import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditCoachClubs extends StatefulWidget {
  DocumentSnapshot coachclubs;
  EditCoachClubs({Key key, this.coachclubs}) : super(key: key);

  @override
  _EditCoachClubState createState() => _EditCoachClubState();
}

class _EditCoachClubState extends State<EditCoachClubs> {
  TextEditingController clubnameController = new TextEditingController();
  TextEditingController clubcityController = new TextEditingController();
  TextEditingController postcodeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clubnameController.text = widget.coachclubs['clubname'];
    clubcityController.text = widget.coachclubs['clubcity'];
    postcodeController.text = widget.coachclubs['clubpostcode'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coach Clubs",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Edit Club",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: clubnameController,
                    decoration: const InputDecoration(
                        labelText: "clubname",
                        hintText: "clubname",
                        border: OutlineInputBorder()),
                    autofocus: false,
                  )),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: clubcityController,
                  decoration: const InputDecoration(
                      labelText: "clubcity",
                      hintText: "clubcity",
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
                  controller: postcodeController,
                  decoration: const InputDecoration(
                      labelText: "postcode",
                      hintText: "postcode",
                      border: OutlineInputBorder()),
                  autofocus: false,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text("Update Club"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  final String clubname = clubnameController.text.trim();
                  final String clubcity = clubcityController.text.trim();
                  final String postcode = postcodeController.text.trim();

                  //final firestoreInstance = FirebaseFirestore.instance;

                  if (clubname.isEmpty &&
                      clubcity.isEmpty &&
                      postcode.isEmpty) {
                    print("Missing input");
                  } else {
                    final firestoreInstance =
                        FirebaseFirestore.instance.collection('coachclubs');
                    // var coachplayers = FirebaseAuth.instance.currentUser;
                    firestoreInstance.doc(widget.coachclubs.id).update({
                      "clubname": clubname.toString(),
                      "clubcity": clubcity.toString(),
                      "clubpostcode": postcode.toString()
                    });
                    clubnameController.text = '';
                    clubcityController.text = '';
                    postcodeController.text = '';

                    Navigator.of(context).pop();
                  }
                })
          ],
        ),
      ),
    );
  }
}
