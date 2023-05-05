import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_page/signup_screen.dart';

import 'package:login_page/home_screen.dart';

class loginPage extends StatelessWidget {
  // var nameval = TextEditingController();
  String emailval = '';
  String passval = '';
  loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN PAGE'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'E-Mail',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                // controller: emailval,
                onChanged: (value) {
                  emailval = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Enter email id',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                // controller: passval,
                onChanged: (value) {
                  passval = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter password',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  // Center(
                  // child:
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: MediaQuery.of(context).size.width / 3.1,
                        right: 10),
                    child: ElevatedButton(
                        onPressed: () async {
                          // print("Login button pressed");
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: emailval, password: passval);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => home_screen()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              const snackBar = SnackBar(
                                content: Text('No user found'),
                              );  
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              const snackBar = SnackBar(
                                content: Text('Wrong password'),
                              );  
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                        },
                        child: Text('Login')),
                  ),
                  // ),
                  // Container(
                  //   width: 10,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup_screen()));
                        },
                        child: Text('Sign-Up')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
