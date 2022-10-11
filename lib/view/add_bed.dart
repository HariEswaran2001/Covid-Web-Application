import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/data.dart';

class AddBed extends StatefulWidget {
  const AddBed({Key? key}) : super(key: key);

  @override
  State<AddBed> createState() => _AddBedState();
}

class _AddBedState extends State<AddBed> {
  int bedType = 0;
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  List<QueryDocumentSnapshot> normal = [];
  List<QueryDocumentSnapshot> o2 = [];
  List<QueryDocumentSnapshot> icu = [];
  fetch() async {
    try {
      QuerySnapshot d = await FirebaseFirestore.instance
          .collection("Beds")
          .where("hospital", isEqualTo: patient.id)
          .get();
      // vaccine = d.docs;

      for (int i = 0; i < d.docs.length; i++) {
        if (d.docs[i]['bed'] == 1) {
          normal.add(d.docs[i]);
        }
        if (d.docs[i]['bed'] == 2) {
          o2.add(d.docs[i]);
        }
        if (d.docs[i]['bed'] == 3) {
          icu.add(d.docs[i]);
        }
      }
      print(normal);
      print(o2);
      print(icu);
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
        title: Text("Add Bed"),
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
                                      "Bed Type",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text("Normal  "),
                                      Radio(
                                          value: 1,
                                          groupValue: bedType,
                                          onChanged: (v) {
                                            stock.clear();
                                            price.clear();
                                            setState(() {
                                              if (normal.isNotEmpty) {
                                                bedType =
                                                    int.parse(v.toString());
                                                stock.text =
                                                    normal.first['stock'];
                                                price.text =
                                                    normal.first['price'];
                                              } else {
                                                bedType =
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
                                      const Text("O2        "),
                                      Radio(
                                          value: 2,
                                          groupValue: bedType,
                                          onChanged: (v) {
                                            setState(() {
                                              stock.clear();
                                              price.clear();
                                              if (o2.isNotEmpty) {
                                                bedType =
                                                    int.parse(v.toString());
                                                stock.text = o2.first['stock'];
                                                price.text = o2.first['price'];
                                              } else {
                                                bedType =
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
                                      Text("ICU       "),
                                      Radio(
                                          value: 3,
                                          groupValue: bedType,
                                          onChanged: (v) {
                                            stock.clear();
                                            price.clear();
                                            setState(() {
                                              if (icu.isNotEmpty) {
                                                bedType =
                                                    int.parse(v.toString());
                                                stock.text = icu.first['stock'];
                                                price.text = icu.first['price'];
                                              } else {
                                                bedType =
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
                      decoration: const InputDecoration(
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
                  print(bedType);
                  print(stock.text);
                  print(price.text);
                  if (bedType != 0 && stock.text != "" && price.text != "") {
                    print("entered condition ");
                    if (bedType == 1 && normal.isNotEmpty) {
                      firestore.collection("Beds").doc(normal.first.id).update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else if (bedType == 2 && o2.isNotEmpty) {
                      firestore.collection("Beds").doc(o2.first.id).update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else if (bedType == 3 && icu.isNotEmpty) {
                      firestore.collection("Beds").doc(icu.first.id).update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else {
                      print("called");
                      DocumentReference dr = firestore.collection("Beds").doc();
                      dr.set({
                        "stock": stock.text,
                        "bed": bedType,
                        "price": price.text,
                        "hospital": patient.id,
                        "docId": dr.id,
                        "location": patient.location,
                        "name": patient.name,
                      });
                    }
                  }
                  bedType == 0;
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
