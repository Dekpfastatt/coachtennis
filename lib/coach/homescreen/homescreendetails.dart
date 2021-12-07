import 'package:coachtennis/coach/homescreen/model/coachschedule.dart';
import 'package:flutter/material.dart';

class HomeScreenDetails extends StatefulWidget {
  //const HomeScreenDetails({ Key? key }) : super(key: key);

  @override
  _HomeScreenDetailsState createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: CoachSchedule.scheduleList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(CoachSchedule.scheduleList[index].scheduleDate),
                Text(CoachSchedule.scheduleList[index].scheduleTimeFrom),
                Text(CoachSchedule.scheduleList[index].scheduleTimeTo),
                Text(CoachSchedule.scheduleList[index].studentName),
                Text(CoachSchedule.scheduleList[index].clubDetails),
                Text(CoachSchedule.scheduleList[index].clubCourt),
              ],
            ),
          );
        },
      ),
    );
  }
}
