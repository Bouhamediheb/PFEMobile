
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobilepfe/Login/screen/Login.dart';
import 'package:mobilepfe/chart1.dart';
import 'package:mobilepfe/constant.dart';
import 'package:mobilepfe/inventaireetstock.dart';
import 'package:mobilepfe/listedesdocument.dart';
import 'package:mobilepfe/listedesfournisseurs.dart';
import 'package:mobilepfe/listeproduits.dart';
import 'package:mobilepfe/main.dart';
import 'package:mobilepfe/recapMonetaire.dart';
import 'package:mobilepfe/userrights.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}



class _SideMenuState extends State<SideMenu> {
 late List? users = [];
  late var token;
  late Map<String, dynamic>? user;

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
  
  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    token = jsonDecode(prefs.getString('access_token') as String);
    setState(() {
      user = json.decode(prefs.getString('user') as String);
    });
  }

@override
void initState() {
  super.initState();
  getUserData();
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: DrawerHeader(
                  child: Image.asset(
                  
                    "assets/images/logo2.png",
                    color: Colors.white,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Row(
                children: [
                  Text("Bonjour, "+user!["name"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            MaterialButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {


                

                        
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Vos actions ..",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      RecapEtat(),
                      SizedBox(height: 10),
                      Text(
                        "Evolution du chiffre d'affaires",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      LineChartSample1()],
                          )),
                 (Route<dynamic> route) => false
                );

                
              },
              child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/menu_dashbord.svg",
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 16,
                  ),
                  title: const Text(
                    "Tableau de bord",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Text("")),
            ),
            MaterialButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {

                
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [EtatStockGlobal()],
                          )),
                 (Route<dynamic> route) => false
                );
                
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [EtatStockGlobal()],
                          )),
                );
                */
              },
              child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/menu_dashbord.svg",
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 16,
                  ),
                  title: const Text(
                    "Etat du stock & Inventaire",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Text("")),
            ),
            
            ExpansionTile(
                title:
                    Text('Liste des documents', style: TextStyle(fontSize: 14)),
                leading: SvgPicture.asset('assets/icons/menu_doc.svg',
                    color: const Color.fromARGB(255, 255, 255, 255), height: 16),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.arrow_right_rounded,
                      color: Color.fromARGB(255, 197, 195, 195),
                    ),
                    title: Text('Bon de commande fournisseur',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 197, 195, 195))),
                    horizontalTitleGap: 0.0,
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {

                      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [listeDocument(1, 'Liste des bons de commandes fournisseur')],
                          )),
                 (Route<dynamic> route) => false
                );

                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.arrow_right_rounded,
                      color: Color.fromARGB(255, 197, 195, 195),
                    ),
                    title: Text("Bon d'entrée",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 197, 195, 195))),
                    horizontalTitleGap: 0.0,
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [listeDocument(2, 'Liste des bons d/entrée ')],
                          )),
                 (Route<dynamic> route) => false
                );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.arrow_right_rounded,
                      color: Color.fromARGB(255, 197, 195, 195),
                    ),
                    title: Text("Bon de retour",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 197, 195, 195))),
                    horizontalTitleGap: 0.0,
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [listeDocument(4, 'Liste des bons de retour')],
                          )),
                 (Route<dynamic> route) => false
                );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.arrow_right_rounded,
                      color: Color.fromARGB(255, 197, 195, 195),
                    ),
                    title: Text("Bon de sortie",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 197, 195, 195))),
                    horizontalTitleGap: 0.0,
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [listeDocument(6, 'Liste des bons de sortie')],
                          )),
                 (Route<dynamic> route) => false
                );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.arrow_right_rounded,
                      color: Color.fromARGB(255, 197, 195, 195),
                    ),
                    title: Text("Facture",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 197, 195, 195))),
                    horizontalTitleGap: 0.0,
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {
                     Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: "PFE Mobile",
                            welcomeScreen: [listeDocument(6, 'Liste des factures')],
                          )),
                 (Route<dynamic> route) => false
                );
                    },
                  ),
                ]),
            DrawerListTile(
              title: "Fournisseurs",
              svgSrc: "assets/icons/menu_tran.svg",
              subTitle1: 'Liste des fournisseurs',
                            subTitle2: 'Liste des produits',

              press1: () {



                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(welcomeScreen:[listeFournisseur()])),
                );
              },
            ),
            DrawerListTile(
              title: "Produits",
              svgSrc: "assets/icons/menu_doc.svg",
              subTitle1: 'Liste des produits',
               subTitle2: 'Liste des produits',
              press1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(welcomeScreen:[listeProduit()])),
                );
              },
              
            ),
            DrawerListTile(
              title: "Parametres",
              svgSrc: "assets/icons/menu_setting.svg",
              subTitle1: 'Gestion des droits des utilisateurs',
              subTitle2: 'Se Déconnecter',
              press1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(welcomeScreen:[listeUtlisateurs()])),
                );
              },
              press2: () {
                logout();
      
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      this.title,
      this.svgSrc,
      this.press1,
      this.press2,
      this.press3,
      this.subTitle1,
      this.subTitle2,
      this.subTitle3})
      : super(key: key);

  final String? title, svgSrc, subTitle1, subTitle2, subTitle3;
  final VoidCallback? press1, press2, press3;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: SvgPicture.asset(
        svgSrc!,
        color: const Color.fromARGB(255, 255, 255, 255),
        height: 16,
      ),
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          onTap: press1,
          horizontalTitleGap: 0.0,
          leading: const Icon(Icons.arrow_right_rounded,
              color: Color.fromARGB(255, 255, 255, 255)),
          title: Text(
            subTitle1!+"",
            style: const TextStyle(
                color: Color.fromARGB(255, 197, 195, 195), fontSize: 13),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          onTap: press2,
          horizontalTitleGap: 0.0,
          leading: const Icon(Icons.arrow_right_rounded,
              color: Color.fromARGB(255, 255, 255, 255)),
          title: Text(
            subTitle2!+"",
            style: const TextStyle(
                color: Color.fromARGB(255, 197, 195, 195), fontSize: 13),
          ),
        ),
      ],
    );
  }
}