import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachtennis/coach/homescreen/coachschedule/editcoachschedule.dart';
import 'package:coachtennis/coach/homescreen/coachschedule/newcoachschedule.dart';
import 'package:coachtennis/coach/homescreen/test.dart';
import 'package:coachtennis/coach/homescreen/widgets/labelwidget.dart';
import 'package:coachtennis/coach/paiementscreen/paiementscreendetail.dart';
import 'package:flutter/material.dart';

class PaiementScreen extends StatefulWidget {
  //const PaiementScreen({ Key? key }) : super(key: key);

  @override
  _PaiementScreenState createState() => _PaiementScreenState();
}

class _PaiementScreenState extends State<PaiementScreen> {
  DocumentSnapshot coachschedule;
  int totalamountpaid = 0;
  int totalamountunpaid = 0;
  int indexval = 0;

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

                    // calculate Total
                    //docsnapshot['paiement'].toString(),
                    if (indexval <= index) {
                      if (docsnapshot['paiement'] == true) {
                        totalamountpaid += 30;
                      } else {
                        totalamountunpaid += 30;
                      }
                      indexval++;
                      return Text('');
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LabelWidget(
                            labelText: totalamountpaid.toString(),
                            colorText: Colors.green,
                            sizeText: 30,
                          ),
                          SizedBox(width: 100),
                          LabelWidget(
                            labelText: totalamountunpaid.toString(),
                            colorText: Colors.red,
                            sizeText: 30,
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }

                    //} //else
                    // return Card(
                    //   elevation: 50,
                    //   margin: EdgeInsets.all(10.0),
                    //   shape: RoundedRectangleBorder(
                    //       side: BorderSide(color: Colors.orange, width: 0.5),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         HeaderWidget(docsnapshot),
                    //       ],
                    //     ),
                    //   ),
                    // );
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
          labelText: docsnapshot['studentname'].toString(),
          colorText: Colors.white,
          sizeText: 25,
        ),
        SizedBox(width: 100),
        InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PaiementScreenDetail()),
              );
            },
            child: LabelWidget(
              labelText: '+ 30 €',
              colorText: Colors.green,
              sizeText: 25,
            )),
        SizedBox(width: 5),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PaiementScreenDetail()),
            );
          },
          child: LabelWidget(
            labelText: '- 60 €',
            colorText: Colors.red,
            sizeText: 25,
          ),
        ),
      ],
    );
  }
}
