import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'coachschedule/editcoachschedule.dart';
import 'coachschedule/newcoachschedule.dart';

class HomeScreenDetails extends StatefulWidget {
  //const HomeScreenDetails({ Key? key }) : super(key: key);

  @override
  _HomeScreenDetailsState createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  CollectionReference _coachschedule =
      FirebaseFirestore.instance.collection('coachschedule');

  Future<void> _deleteschedule(String coachdetails) async {
    await _coachschedule.doc(coachdetails).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('You have successfuly deleted!'),
    ));
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
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ListTile(
                              title: Text(
                                docsnapshot['scheduledate'].toString(),
                                style: TextStyle(color: Colors.green),
                              ),
                              subtitle:
                                  Text(docsnapshot['clubdetails'].toString()),
                              trailing: SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(docsnapshot['studentname']
                                                .toString()),
                                          ]),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('Start:  '),
                                            Text(
                                              docsnapshot['timefrom']
                                                  .toString(),
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text('  End:  '),
                                            Text(
                                              docsnapshot['timeto'].toString(),
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ]),
                                    ],
                                  ))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => EditCoachSchedule(
                                            coachschedule: docsnapshot)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteschedule(docsnapshot.id);
                                },
                              )
                            ],
                          ),
                        ],
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
}
