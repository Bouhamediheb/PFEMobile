import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepfe/constant.dart';
import 'package:mobilepfe/lignedoc.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class listeDocument extends StatefulWidget {
  @override
  State<listeDocument> createState() => _listeDocumentState();
}

class _listeDocumentState extends State<listeDocument> {
  int? documentId;
  List? documents = [];
  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  String getDocType(int number) {
    print("Hedha type doc");
    if (number == 1) {
      return "Bon de commande";
    } else if (number == 2) {
      return "Bon de livraison";
    } else if (number == 3) {
      return "Bon de retour";
    } else if (number == 4) {}
    return "Devis";
  }

  fetchDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        documents = items;
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
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
                      'La Liste des documents ',
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
                        flex: 1,
                        child: Text("Type du document",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Expanded(
                        flex: 1,
                        child: Text("Numéro du document",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Date du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Montant total du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white)),
                      )),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < documents!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Center(
                                  child: Text(
                                getDocType(documents![i]['type']),
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            DataCell(InkWell(
                                onTap: () {
                                  showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          backgroundColor:
                                              Color.fromARGB(255, 39, 45, 80),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          content: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Contenu du document",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Divider(
                                                      thickness: 5,
                                                      color: Colors.white,
                                                    ),
                                                    listeLigneDocument(
                                                        documents![i]['id']),
                                                  ],
                                                ),
                                              )));
                                    },
                                    animationType:
                                        DialogTransitionType.fadeScale,
                                    curve: Curves.fastOutSlowIn,
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: Center(
                                  child: Text(documents![i]['numDoc'],
                                      style: TextStyle(color: Colors.white)),
                                ))),
                            DataCell(Center(
                              child: Text(documents![i]['dateDoc'].toString(),
                                  style: TextStyle(color: Colors.white)),
                            )),
                            DataCell(Center(
                              child: Text(
                                  documents![i]['totalDoc'].toString() + " DT",
                                  style: TextStyle(color: Colors.white)),
                            )),
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
