import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachtennis/coach/homescreen/coachschedule/editcoachschedule.dart';
import 'package:coachtennis/coach/homescreen/coachschedule/newcoachschedule.dart';
import 'package:coachtennis/coach/homescreen/widgets/labelwidget.dart';
import 'package:flutter/material.dart';

class PaiementScreenDetail extends StatefulWidget {
  //const PaiementScreen({ Key? key }) : super(key: key);

  @override
  _PaiementScreenDetailState createState() => _PaiementScreenDetailState();
}

class _PaiementScreenDetailState extends State<PaiementScreenDetail> {
  DocumentSnapshot coachschedule;

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
                    if (index == 0) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LabelWidget(
                                labelText:
                                    docsnapshot['studentname'].toString(),
                                colorText: Colors.red,
                                sizeText: 30,
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      );
                    } else
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LabelWidget(
          labelText: docsnapshot['scheduledate'].toString(),
          colorText: Colors.white,
          sizeText: 25,
        ),
        SizedBox(width: 50),
        LabelWidget(
          labelText: docsnapshot['paiement'].toString(),
          colorText: Colors.green,
          sizeText: 25,
        ),
      ],
    );
  }
}
