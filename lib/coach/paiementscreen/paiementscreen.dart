import 'package:flutter/material.dart';

class PaiementScreen extends StatefulWidget {
  //const PaiementScreen({ Key? key }) : super(key: key);

  @override
  _PaiementScreenState createState() => _PaiementScreenState();
}

class _PaiementScreenState extends State<PaiementScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text("List of Paiement"),
      ),
    );
  }
}
