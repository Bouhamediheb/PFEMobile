// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobilepfe/Login/screen/Login.dart';
import 'package:mobilepfe/chart1.dart';
import 'package:mobilepfe/constant.dart';
import 'package:mobilepfe/drawer.dart';
import 'package:mobilepfe/recapMonetaire.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestionnaire',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        
        canvasColor: secondaryColor,
      ),
      home: CheckAuth(),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  List<Widget> welcomeScreen = [RecapEtat(), LineChartSample1()];

  MyHomePage({this.title = 'Gestionnaire mobile', required this.welcomeScreen});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < widget.welcomeScreen.length; i++)
                  widget.welcomeScreen[i]
              ],
            ),
          ),
        ),
        drawer:  SideMenu());
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: bgColor,
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  Map<String, dynamic>? user;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');
    setState(() {
      user = json.decode(localStorage.getString('user') as String);
    });
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (isAuth == false) {
      child = LoginPage();
    } else {
      if (user!['role'] == 3) {

      } else {
        child = MyHomePage(welcomeScreen: [RecapEtat(), LineChartSample1()]);
      }
    }
    return Scaffold(body: child);
  }
}