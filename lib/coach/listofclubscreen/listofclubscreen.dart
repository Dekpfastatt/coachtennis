import 'package:flutter/material.dart';

class ListOfClubScreen extends StatefulWidget {
  //const ListOfClubScreen({ Key? key }) : super(key: key);

  @override
  _ListOfClubScreenState createState() => _ListOfClubScreenState();
}

class _ListOfClubScreenState extends State<ListOfClubScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text("List of Clubs Screen"),
      ),
    );
  }
}
