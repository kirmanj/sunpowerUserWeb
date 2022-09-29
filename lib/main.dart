import 'package:explore/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SunPower',
      theme: ThemeData(
        highlightColor: Color.fromRGBO(230, 110, 43, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),

      // Scaffold(
      //   body: Center(child:
      //   InkWell(
      //       onTap: (){
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) =>  AddProduct()),
      //         );
      //         },
      //       child: Text('Add Prodcuct',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,))),
      // ),
    );
  }
}
