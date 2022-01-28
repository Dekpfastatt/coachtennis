import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewCoachClubs extends StatefulWidget {
  const NewCoachClubs({Key key}) : super(key: key);

  @override
  _NewCoachClubState createState() => _NewCoachClubState();
}

class _NewCoachClubState extends State<NewCoachClubs> {
  TextEditingController clubnameController = new TextEditingController();
  TextEditingController clubcityController = new TextEditingController();
  TextEditingController postcodeController = new TextEditingController();

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
              "Add new club",
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
                child: const Text("Add Club"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  final String clubname = clubnameController.text.trim();
                  final String clubcity = clubcityController.text.trim();
                  final String postcode = postcodeController.text.trim();

                  final firestoreInstance = FirebaseFirestore.instance;

                  if (clubname.isEmpty &&
                      clubcity.isEmpty &&
                      postcode.isEmpty) {
                    print("Missing input");
                  } else {
                    var coachclubs = FirebaseAuth.instance.currentUser;
                    firestoreInstance.collection("coachclubs").add({
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
