import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'coachschedule/editcoachschedule.dart';
import 'coachschedule/newcoachschedule.dart';
import 'widgets/labelwidget.dart';

class HomeScreenDetails extends StatefulWidget {
  //const HomeScreenDetails({ Key? key }) : super(key: key);

  @override
  _HomeScreenDetailsState createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  DocumentSnapshot coachschedule;

  CollectionReference _coachschedule =
      FirebaseFirestore.instance.collection('coachschedule');

  Future<void> _deleteschedule(String coachdetails) async {
    await _coachschedule.doc(coachdetails).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('You have successfuly deleted!'),
    ));
  }

  Future<void> _updatepaiement(String coachdetails, bool val) async {
    CollectionReference firestoreInstance =
        FirebaseFirestore.instance.collection('coachschedule');

    firestoreInstance.doc(coachdetails).update({
      "paiement": val,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NewCoachSchedule()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder(
            stream: _coachschedule.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot docsnapshot =
                        streamSnapshot.data.docs[index];
                    return Card(
                      elevation: 50,
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.orange, width: 0.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderWidget(docsnapshot),
                            FooterWidget(docsnapshot),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget HeaderWidget(DocumentSnapshot docsnapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('splashscreen1.jpg'),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelWidget(
              labelText: docsnapshot['studentname'].toString(),
              colorText: Colors.green,
              sizeText: 22,
            ),
            LabelWidget(
              labelText: docsnapshot['clubdetails'].toString(),
              colorText: Colors.white,
              sizeText: 13,
            ),
          ],
        ),
        //SizedBox(width: 100),
        PaidWidget(docsnapshot),
      ],
    );
  }

  Widget PaidWidget(DocumentSnapshot docsnapshot) {
    return Expanded(
      child: IconButton(
        alignment: Alignment.topRight,
        icon: docsnapshot['paiement'] == true
            ? Icon(
                Icons.paid_outlined,
                color: Colors.yellow,
                size: 40.0,
              )
            : Icon(
                Icons.paid_outlined,
                color: Colors.red,
                size: 40.0,
              ),
        // onPressed: () {
        //   if (docsnapshot['paiement'] == false)
        //     _updatepaiement(docsnapshot.id, true);
        //   setState(() {});
        // },
      ),
    );
  }

  Widget FooterWidget(DocumentSnapshot docsnapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Start and End
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelWidget(
              labelText: docsnapshot['scheduledate'].toString(),
              colorText: Colors.red,
              sizeText: 16,
            ),
            Row(children: [
              LabelWidget(
                labelText: "Start:",
                colorText: Colors.white,
              ),
              SizedBox(width: 10),
              LabelWidget(
                labelText: docsnapshot['timefrom'].toString(),
                colorText: Colors.white,
              ),
              SizedBox(width: 10),
              LabelWidget(
                labelText: "End:",
                colorText: Colors.white,
              ),
              SizedBox(width: 10),
              LabelWidget(
                labelText: docsnapshot['timeto'].toString(),
                colorText: Colors.white,
              ),
            ]),
          ],
        ),
        // icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) =>
                          EditCoachSchedule(coachschedule: docsnapshot)),
                );
              },
            ),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteschedule(docsnapshot.id);
              },
            )
          ],
        ),
      ],
    );
  }
}
