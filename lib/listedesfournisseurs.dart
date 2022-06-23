import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constant.dart';

class listeFournisseur extends StatefulWidget {
  @override
  State<listeFournisseur> createState() => listeFournisseurState();
}

class listeFournisseurState extends State<listeFournisseur> {
  int? produitId;
  List? fournisseurs = [];
  Timer? t;
  @override
  void initState() {
    super.initState();
    t = new Timer.periodic(timeDelay, (t) => fetchFournisseurs());
  }

  fetchFournisseurs() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        fournisseurs = items;
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: bgColor,
          elevation: 2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                    child: SizedBox(
                  child: Center(
                    child: Text(
                      'La Liste des fournisseurs',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
              const Divider(
                thickness: 3,
              ),
              SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Expanded(
                        child: Text("Raison sociale",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Téléphone",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Email",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Matricule fiscale",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Pays",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Ville",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < fournisseurs!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                                fournisseurs![i]['raisonSociale'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(fournisseurs![i]['tel'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(fournisseurs![i]['email'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(fournisseurs![i]['mf'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(fournisseurs![i]['pays'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(
                                Text("${fournisseurs![i]['ville'].toString()}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
