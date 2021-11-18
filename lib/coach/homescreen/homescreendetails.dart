import 'package:flutter/material.dart';

class HomeScreenDetails extends StatefulWidget {
  //const HomeScreenDetails({ Key? key }) : super(key: key);

  @override
  _HomeScreenDetailsState createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text("Home Screen"),
      ),
    );
  }
}
