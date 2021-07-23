import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () async {
              main();
      UserCredential userCredential = await auth.signInAnonymously();
      print(userCredential);
      }, child: Text('Anonymous sign in')

        ),
            SizedBox(height: 10),

            TextButton(onPressed: () async {
              main();
              auth.signOut();
              //UserCredential userCredential = await auth.signInAnonymously();
              //print(userCredential);
            }, child: Text('Anonymous sign out')
            ),

            SizedBox(height: 10),

            TextButton(onPressed: () async {
              main();
              try {
                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: "jhamayank@example.com",
                    password: "SuperSecretPassword!"
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            }, child: Text('email id sign in')

            ),


            SizedBox(height:10),
            TextButton(onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: "jhamayank@example.com",
                    password: "SuperSecretPassword!"
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            }, child: Text('sign in if you exist already')),

            SizedBox(height:10),
            TextButton(onPressed: () async
            {
              await auth.signOut();
            }, child: Text('sign out for email id')),
      ],
      ),
      ),

    );
  }
}
