import 'dart:ui';

import 'package:flutter/material.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tennis Coach",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text("Forgot your password"),
            const SizedBox(height: 30),
            Container(
              width: 300,
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Enter your Email",
                    hintText: "Email address",
                    border: OutlineInputBorder()),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
