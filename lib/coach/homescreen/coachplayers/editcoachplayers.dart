import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditCoachPlayers extends StatefulWidget {
  DocumentSnapshot coachplayers;
  EditCoachPlayers({Key key, this.coachplayers}) : super(key: key);

  @override
  _EditCoachPlayersState createState() => _EditCoachPlayersState();
}

class _EditCoachPlayersState extends State<EditCoachPlayers> {
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController clubnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstnameController.text = widget.coachplayers['firstname'];
    lastnameController.text = widget.coachplayers['lastname'];
    clubnameController.text = widget.coachplayers['clubname'];
    emailController.text = widget.coachplayers['email'];
    mobileController.text = widget.coachplayers['mobile'];
  }

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
              "Edit player",
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
                child: const Text("Update Player"),
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

                  //final firestoreInstance = FirebaseFirestore.instance;

                  if (firstname.isEmpty &&
                      lastname.isEmpty &&
                      club.isEmpty &&
                      email.isEmpty &&
                      mobile.isEmpty) {
                    print("Missing input");
                  } else {
                    final firestoreInstance =
                        FirebaseFirestore.instance.collection('coachplayers');
                    // var coachplayers = FirebaseAuth.instance.currentUser;
                    firestoreInstance.doc(widget.coachplayers.id).update({
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
