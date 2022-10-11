import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/data.dart';

class AddOxygen extends StatefulWidget {
  const AddOxygen({Key? key}) : super(key: key);

  @override
  State<AddOxygen> createState() => _AddOxygenState();
}

class _AddOxygenState extends State<AddOxygen> {
  int oxygenType = 0;
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  List<QueryDocumentSnapshot> ventilation = [];
  List<QueryDocumentSnapshot> supply = [];
  fetch() async {
    try {
      QuerySnapshot d = await FirebaseFirestore.instance
          .collection("Oxygen")
          .where("hospital", isEqualTo: patient.id)
          .get();
      // vaccine = d.docs;

      for (int i = 0; i < d.docs.length; i++) {
        if (d.docs[i]['oxygen'] == 1) {
          ventilation.add(d.docs[i]);
        }
        if (d.docs[i]['oxygen'] == 2) {
          supply.add(d.docs[i]);
        }
      }
      print(ventilation);
      print(supply);
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Oxygen"),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  color: Colors.grey,
                  offset: Offset(12, 12),
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  offset: const Offset(-12, -12),
                  blurRadius: 10,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            )),
                        width: MediaQuery.of(context).size.width * .4,
                        height: 200,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Oxygen Type",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text("Ventilator  "),
                                      Radio(
                                          value: 1,
                                          groupValue: oxygenType,
                                          onChanged: (v) {
                                            stock.clear();
                                            price.clear();
                                            setState(() {
                                              if (ventilation.isNotEmpty) {
                                                oxygenType =
                                                    int.parse(v.toString());
                                                stock.text =
                                                    ventilation.first['stock'];
                                                price.text =
                                                    ventilation.first['price'];
                                              } else {
                                                oxygenType =
                                                    int.parse(v.toString());
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text("Supply      "),
                                      Radio(
                                          value: 2,
                                          groupValue: oxygenType,
                                          onChanged: (v) {
                                            setState(() {
                                              stock.clear();
                                              price.clear();
                                              if (supply.isNotEmpty) {
                                                oxygenType =
                                                    int.parse(v.toString());
                                                stock.text =
                                                    supply.first['stock'];
                                                price.text =
                                                    supply.first['price'];
                                              } else {
                                                oxygenType =
                                                    int.parse(v.toString());
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: TextField(
                      controller: stock,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Stock", labelText: "Stock"),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: TextField(
                      controller: price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Price",
                        labelText: "Price",
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print("btn clicked");
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  print(oxygenType);
                  print(stock.text);
                  print(price.text);
                  if (oxygenType != 0 && stock.text != "" && price.text != "") {
                    print("entered condition ");
                    if (oxygenType == 1 && ventilation.isNotEmpty) {
                      firestore
                          .collection("Oxygen")
                          .doc(ventilation.first.id)
                          .update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else if (oxygenType == 2 && supply.isNotEmpty) {
                      firestore
                          .collection("Oxygen")
                          .doc(supply.first.id)
                          .update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else {
                      print("called");
                      DocumentReference dr =
                          firestore.collection("Oxygen").doc();
                      dr.set({
                        "stock": stock.text,
                        "oxygen": oxygenType,
                        "price": price.text,
                        "hospital": patient.id,
                        "docId": dr.id,
                        "location": patient.location,
                        "name": patient.name,
                      });
                    }
                  }
                  oxygenType == 0;
                  price.clear();
                  stock.clear();
                  setState(() {});
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Data updated Successfully !!!")));
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
