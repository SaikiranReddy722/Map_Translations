import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page/signup_screen.dart';
import 'package:login_page/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              // theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 10, 83, 142)),
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.blueGrey,
      ),
      body:
      // Image.asset("images/space.jpg");
      Center(
        child: Column(
          children: [
            // Image.asset("images/space.jpg"),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/space.jpg'),
                radius: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Map Translations',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Container(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 3.1),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginPage()));
                      },
                      child: Text('Login')),
                      
                ),
                Center(
                  child: Container(
                    width: 20,
                  ),
                ),
                Center(
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
          ],
        ),
      ),
    );
  }
}
