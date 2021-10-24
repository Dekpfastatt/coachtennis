import 'dart:ui';

import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
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
            const Text("Sign Up your account"),
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
            const SizedBox(height: 10),
            Container(
              width: 300,
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Enter your Password",
                    hintText: "Password",
                    border: OutlineInputBorder()),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Confirm password",
                    border: OutlineInputBorder()),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sign Up"),
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
