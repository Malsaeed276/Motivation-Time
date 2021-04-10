import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Home Page.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyApp extends StatelessWidget {
  static CollectionReference liked = FirebaseFirestore.instance.collection('liked');
  static CollectionReference actionList =
  FirebaseFirestore.instance.collection('actionList');
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motivation time',
      theme: ThemeData(
        fontFamily:'quoteScript',
        //backgroundColor: Colors.white,
        accentColor: Colors.white,
        primarySwatch: Colors.blue,
        cardColor: Colors.grey,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white,)
        )

      ),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text("there is an Erorr ${snapshot.error.toString()}"),);
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
