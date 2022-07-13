import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:mobilepfe/constant.dart';
import 'package:mobilepfe/lignedoc.dart';


class listeDocument extends StatefulWidget {
  int? typeDoc;
  String? nomListeDoc;
  listeDocument(this.typeDoc,this.nomListeDoc);
  @override
  State<listeDocument> createState() => _listeDocumentState();
}

class _listeDocumentState extends State<listeDocument> {
  int? documentId;
  List? documents = [];
  String dropdownvalue = 'Tous les Documents';
  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  String getDocType(int number) {
    if (number == 1) {
      return "Bon de commande";
    } else if (number == 2) {
      return "Bon d'entrée";
    } else if (number == 3) {
      return "Bon de retour";
    } else if (number == 4) {
      return "Ticket";
    } else if (number == 5) {
      return "Facture";
    } else if (number == 6) {
      return 'Bon de sortie';
    }
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
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: SizedBox(
          child: Column(children: <Widget>[
             Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                  child: SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    widget.nomListeDoc!,
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),

                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Flexible(
                        child: Text("Type du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Numéro du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Date du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Montant total du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < documents!.length; i++)
                        if (documents![i]['type'] == widget.typeDoc)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(
                                    child: Text(
                                        getDocType(documents![i]['type']))),
                              ),
                              DataCell(InkWell(
                                  onTap: () {
                                    showAnimatedDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            backgroundColor: bgColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            content: SizedBox(
                                                width: 800,
                                                child: SingleChildScrollView(
                                                                  physics: BouncingScrollPhysics(),
scrollDirection: Axis.horizontal,
                                                  child: listeLigneDocument(
                                                      documents![i]['id']),
                                                )));
                                      },
                                      animationType:
                                          DialogTransitionType.fadeScale,
                                      curve: Curves.fastOutSlowIn,
                                      duration: const Duration(seconds: 1),
                                    );
                                  },
                                  child: Center(
                                      child: Text(documents![i]['numDoc'])))),
                              DataCell(Center(
                                  child: Text(
                                      documents![i]['dateDoc'].toString()))),
                              DataCell(Center(
                                  child: Text(
                                      "${documents![i]['totalDoc'].toString()} DT"))),
                              
                            ],
                          )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
