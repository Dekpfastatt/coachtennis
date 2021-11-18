import 'package:flutter/material.dart';

class ListOfPlayerScreen extends StatefulWidget {
  //const ListOfPlayerScreen({ Key? key }) : super(key: key);

  @override
  _ListOfPlayerScreenState createState() => _ListOfPlayerScreenState();
}

class _ListOfPlayerScreenState extends State<ListOfPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text("List of Players Screen"),
      ),
    );
  }
}
