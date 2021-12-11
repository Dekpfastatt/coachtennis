import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachtennis/coach/homescreen/model/coachschedule.dart';
import 'package:flutter/material.dart';

class HomeScreenDetails extends StatefulWidget {
  //const HomeScreenDetails({ Key? key }) : super(key: key);

  @override
  _HomeScreenDetailsState createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  CollectionReference _coachschedule =
      FirebaseFirestore.instance.collection('coachschedule');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      child: ListTile(
                          title: Text(docsnapshot['clubdetails'].toString()),
                          subtitle: Text(docsnapshot['timefrom'].toString()),
                          trailing: Text(docsnapshot['timeto'].toString())),
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
