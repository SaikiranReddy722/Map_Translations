import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class delete_student extends StatefulWidget {
  const delete_student({super.key});

  @override
  State<delete_student> createState() => _delete_studentState();
}

class _delete_studentState extends State<delete_student> {
  var searchval = TextEditingController();
  deleteStud(String rno) async {
    await FirebaseFirestore.instance.collection('students').doc(rno).delete();
    print("User deleted");
    const snackBar = SnackBar(
      content: Text('User deleted'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Student'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 600,
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                controller: searchval,
                decoration: InputDecoration(
                    hintText: 'Enter Roll number of student to be deleted',
                    prefixIcon: Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Container(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  // const snackBar = SnackBar(
                  //   content: TextButton(
                  //     child: Text('Confirm Deletion?'),
                  //     onPressed:(){
                  //       deleteStud(searchval.text);
                  //     },
                  //   ),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Navigator.pop(context);
                  deleteStud(searchval.text);
                  Navigator.pop(context);
                },
                child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
