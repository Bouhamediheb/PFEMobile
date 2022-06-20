import 'package:flutter/material.dart';
import 'package:mobilepfe/chart1.dart';
import 'package:mobilepfe/constant.dart';
import 'package:mobilepfe/drawer.dart';
import 'package:mobilepfe/recapMonetaire.dart';

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
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: 'Gestionnaire Mobile',
        welcomeScreen: [RecapEtat(), LineChartSample1()],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  List<Widget> welcomeScreen = [RecapEtat(), LineChartSample1()];

  MyHomePage({this.title = 'Demo', required this.welcomeScreen});

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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                for (var i = 0; i < widget.welcomeScreen.length; i++)
                  widget.welcomeScreen[i]
              ],
            ),
          ),
        ),
        drawer: const SideMenu());
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
