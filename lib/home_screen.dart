// import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'show_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/retreive_student.dart';
import 'package:login_page/update_student.dart';
import 'package:login_page/view_one.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'create_student.dart';
import 'delete_student.dart';
import 'get_prediction.dart';
import 'package:http/http.dart' as http;
import 'input.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // Uint8List? image;
  // Future<Uint8List> pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     // if (image == null) return;
  //     final imageTemp = File(image!.path);
  //     setState(() => this.image = imageTemp);
  //     return image;
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  Future<GetPrediction> askPrediction(Uint8List img,int c) async {
    // setState(() {
    //   loading = true;
    // });
    // int c = 0;
    String base64String = base64Encode(img);
    // print(base64String);
    final response = await http.post(
      Uri.parse(
          'https://a917-183-82-111-80.in.ngrok.io/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'type': c,
        'image': base64String,
      }),
    );

    if (response.statusCode == 200) {
      print("hello res");
      return GetPrediction.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.body}.');
      throw Exception('Failed to fetch');
    }
  }

  @override
  Widget build(BuildContext context) {
    void Store(String file1, String file2) {
      String postid = const Uuid().v1();
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      print(uid);
      FirebaseFirestore.instance
          .collection('images')
          .doc(uid)
          .collection('input')
          .doc(postid)
          .set({'input': file1, 'output': file2});
      print('stored');
    }

    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Image Upload"),
        ),
        body: Center(
          
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(onPressed: () async {
                      Uint8List? file, file1;
                      // print("file $file");
                      try {
                        file = await pickImage(ImageSource.gallery);
                        // print("file $file");
                        try {
                          final GetPrediction s =
                              await askPrediction(file as Uint8List,0);
                          // setState(() {
                          //   loading = false;
                          // });
                          // file1 = s.result;
                          file1 = base64Decode(s.result);
                          print(file1);
                          // print(s.result);
                        } catch (e) {
                          // print("erorr pred");
                        }
                        // print(file1);
                      } catch (e) {
                        // print(e.toString());
                      }
                      Store(base64Encode(file as Uint8List),
                          base64Encode(file1 as Uint8List));
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Post(
                                    img1: file as Uint8List,
                                    img2: file1 as Uint8List,
                                  )));
                    }, child: Text('Satellite to Map')),
                  Container(
                height: 20,
              ),
              ElevatedButton(onPressed: () async {
                      //     // Navigator.of(context).pop();
                      // Navigator.push(context,
                      //   MaterialPageRoute(builder: (context) => Edit()));
                      Uint8List? file, file1;
                      // print("file $file");
                      try {
                        file = await pickImage(ImageSource.gallery);
                        // print("file $file");
                        try {
                          final GetPrediction s =
                              await askPrediction(file as Uint8List,1);
                          // setState(() {
                          //   loading = false;
                          // });
                          // file1 = s.result;
                          file1 = base64Decode(s.result);
                          print(file1);
                          // print(s.result);
                        } catch (e) {
                          // print("erorr pred");
                        }
                        // print(file1);
                      } catch (e) {
                        // print(e.toString());
                      }
                      Store(base64Encode(file as Uint8List),
                          base64Encode(file1 as Uint8List));
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Post(
                                    img1: file as Uint8List,
                                    img2: file1 as Uint8List,
                                  )));
                    }, child: Text('Map to Satellite'))
            ],
          ),
        ));
  }
}