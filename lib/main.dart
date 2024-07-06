import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';
import 'package:quran_app/index.dart';
import 'package:quran_app/setting.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await readJson();
      await getSetting();
      
    });
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    
      theme: ThemeData(
        
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: IndexPage(),
      
    );
  }
}

