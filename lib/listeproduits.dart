import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constant.dart';

class listeProduit extends StatefulWidget {
  @override
  State<listeProduit> createState() => listeProduitState();
}

class listeProduitState extends State<listeProduit> {
  int? produitId;
  List? produits = [];
  Timer? t;
  @override
  void initState() {
    super.initState();
    t = new Timer.periodic(timeDelay, (t) => fetchProduits());
  }

  fetchProduits() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/produit'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        produits = items;
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
                      'La liste des produits',
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
                        child: Text("Référence Produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Nom Produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Stock",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Prix Achat",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("Prix Vente",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Text("TVA",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < produits!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(produits![i]['refProd'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(produits![i]['nomProd'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(produits![i]['stock'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(produits![i]['prixAchat'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text(produits![i]['prixVente'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                            DataCell(Text("${produits![i]['TVA'].toString()}%",
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
