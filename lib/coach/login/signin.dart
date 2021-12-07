// import 'dart:ui';

// import 'package:coachtennis/coach/login/passwordreset.dart';
// import 'package:coachtennis/main.dart';
// import 'package:flutter/material.dart';

// import '../signup/signupscreen.dart';

// class SignIn extends StatelessWidget {
//   const SignIn({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign In Page"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Tennis Coach",
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 30),
//             Container(
//               width: 300,
//               child: const TextField(
//                 decoration: InputDecoration(
//                     labelText: "Enter your Email",
//                     hintText: "Email address",
//                     border: OutlineInputBorder()),
//                 autofocus: false,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               width: 300,
//               child: const TextField(
//                 decoration: InputDecoration(
//                     labelText: "Enter your Password",
//                     hintText: "Password",
//                     border: OutlineInputBorder()),
//                 autofocus: false,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               //crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   //width: 300,
//                   margin: const EdgeInsets.only(left: 40),
//                   child: Checkbox(
//                     value: true,
//                     activeColor: Colors.green,
//                     onChanged: (value) {},
//                   ),
//                 ),
//                 Container(
//                   child: const Text('Remember me',
//                       textDirection: TextDirection.ltr,
//                       textAlign: TextAlign.left),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text("Sign In"),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.green,
//                 onPrimary: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 20),
//             InkWell(
//               child: const Text('forgot Password?'),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (_) => PasswordReset()),
//                 );
//               },
//             ),
//             const SizedBox(height: 10),
//             InkWell(
//               child: const Text('Do not have an account? Sign Up'),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (_) => SignIn()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
