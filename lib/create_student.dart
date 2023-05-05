import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class create_student extends StatefulWidget {
  const create_student({super.key});

  @override
  State<create_student> createState() => _create_studentState();
}

class _create_studentState extends State<create_student> {
  var nameval = TextEditingController();
  var rollval = TextEditingController();
  var classval = TextEditingController();

  create(String name, rno, cla) async {
    await FirebaseFirestore.instance.collection('students').doc(rno).set({
      'name': name,
      'roll number': rno,
      'class': cla,
    });
    print("user created");
    const snackBar = SnackBar(
      content: Text('User added'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create student'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: nameval,
                // onChanged: (value) {
                //   emailval = value;
                // },
                decoration: InputDecoration(
                    hintText: 'Enter Student name',
                    prefixIcon: Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Roll Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rollval,
                // onChanged: (value) {
                //   passval = value;
                // },
                // obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter roll number',
                    prefixIcon: Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Class',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: classval,
                // onChanged: (value) {
                //   passval = value;
                // },
                // obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter class',
                    prefixIcon: Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  create(nameval.text, rollval.text, classval.text);
                  Navigator.pop(context);
                },
                child: Text('Add')),
          ],
        ),
      ),
    );
  }
}
