import 'package:coachtennis/coach/signup/services/authservice.dart';
import 'package:coachtennis/utilities/coachtennis_theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key key, this.themeVal}) : super(key: key);
  ThemeData themeVal;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up Page",
          style: themeVal.textTheme.headline1,
        ),
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
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: "Enter your Email",
                    hintText: "Email address",
                    border: OutlineInputBorder()),
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: "Enter your Password",
                    hintText: "Password",
                    border: OutlineInputBorder()),
                obscureText: true,
                autofocus: false,
              ),
            ),
            const SizedBox(height: 10),
            // Container(
            //   width: 300,
            //   child: const TextField(
            //     decoration: InputDecoration(
            //         labelText: "Confirm Password",
            //         hintText: "Confirm password",
            //         border: OutlineInputBorder()),
            //     autofocus: false,
            //   ),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String email = emailController.text.trim();
                final String password = passwordController.text.trim();

                if (email.isEmpty) {
                  print("Email is empty");
                } else {
                  if (password.isEmpty) {
                    print("Password is Empty");
                  } else {
                    context
                        .read<AuthService>()
                        .signUp(email, password)
                        .then((value) async {
                      User users = FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(users.uid)
                          .set({
                        'uid': users.uid,
                        'email': email,
                        'password': password,
                      });
                    });
                  }
                }
              },
              child: const Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final String email = emailController.text.trim();
                final String password = passwordController.text.trim();

                if (email.isEmpty) {
                  print("Email is empty");
                } else {
                  if (password.isEmpty) {
                    print("Password is Empty");
                  } else {
                    context.read<AuthService>().login(email, password);
                  }
                }
              },
              child: const Text("Sign In"),
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
