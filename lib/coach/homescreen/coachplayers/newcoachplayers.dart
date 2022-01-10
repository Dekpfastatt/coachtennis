import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewCoachPlayers extends StatefulWidget {
  const NewCoachPlayers({Key key}) : super(key: key);

  @override
  _NewCoachPlayersState createState() => _NewCoachPlayersState();
}

class _NewCoachPlayersState extends State<NewCoachPlayers> {
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController clubnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coach Players",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add new player",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: firstnameController,
                    decoration: const InputDecoration(
                        labelText: "firstname",
                        hintText: "firstname",
                        border: OutlineInputBorder()),
                    autofocus: false,
                  )),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: const InputDecoration(
                      labelText: "lastname",
                      hintText: "lastname",
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
                  controller: clubnameController,
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
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: "email",
                      hintText: "email",
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
                  controller: mobileController,
                  decoration: const InputDecoration(
                      labelText: "Mobile",
                      hintText: "Mobile",
                      border: OutlineInputBorder()),
                  autofocus: false,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text("Add Player"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  final String firstname = firstnameController.text.trim();
                  final String lastname = lastnameController.text.trim();
                  final String club = clubnameController.text.trim();
                  final String email = emailController.text.trim();
                  final String mobile = mobileController.text.trim();

                  final firestoreInstance = FirebaseFirestore.instance;

                  if (firstname.isEmpty &&
                      lastname.isEmpty &&
                      club.isEmpty &&
                      email.isEmpty &&
                      mobile.isEmpty) {
                    print("Missing input");
                  } else {
                    var coachplayers = FirebaseAuth.instance.currentUser;
                    firestoreInstance.collection("coachplayers").add({
                      "firstname": firstname.toString(),
                      "lastname": lastname.toString(),
                      "clubname": club.toString(),
                      "email": email.toString(),
                      "mobile": mobile.toString(),
                    });
                    firstnameController.text = '';
                    lastnameController.text = '';
                    clubnameController.text = '';
                    emailController.text = '';
                    mobileController.text = '';

                    Navigator.of(context).pop();
                  }
                })
          ],
        ),
      ),
    );
  }
}
