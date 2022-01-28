import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachtennis/coach/homescreen/coachplayers/editcoachplayers.dart';
import 'package:coachtennis/coach/homescreen/coachplayers/newcoachplayers.dart';
import 'package:coachtennis/coach/homescreen/widgets/labelwidget.dart';
import 'package:flutter/material.dart';

class ListOfPlayerScreen extends StatefulWidget {
  //const ListOfPlayerScreen({ Key? key }) : super(key: key);

  @override
  _ListOfPlayerScreenState createState() => _ListOfPlayerScreenState();
}

class _ListOfPlayerScreenState extends State<ListOfPlayerScreen> {
  CollectionReference _coachplayers =
      FirebaseFirestore.instance.collection('coachplayers');

  Future<void> _deleteschedule(String coachdetails) async {
    await _coachplayers.doc(coachdetails).delete();
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
              MaterialPageRoute(builder: (_) => NewCoachPlayers()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder(
            stream: _coachplayers.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot docsnapshot =
                        streamSnapshot.data.docs[index];
                    return Card(
                      color: Colors.green[200],
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelWidget(
              labelText: docsnapshot['firstname'].toString(),
              colorText: Colors.orange,
              sizeText: 22,
            ),
            LabelWidget(
              labelText: docsnapshot['lastname'].toString(),
              colorText: Colors.black,
              sizeText: 13,
            ),
          ],
        ),
      ],
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
            Row(children: [
              LabelWidget(
                labelText: "Club:",
                colorText: Colors.black,
              ),
              SizedBox(width: 10),
              LabelWidget(
                labelText: docsnapshot['clubname'].toString(),
                colorText: Colors.black,
              ),
            ]),
          ],
        ),
        // icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) =>
                          EditCoachPlayers(coachplayers: docsnapshot)),
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
