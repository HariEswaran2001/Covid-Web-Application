import 'package:covidpat/controller/data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddVaccine extends StatefulWidget {
  const AddVaccine({Key? key}) : super(key: key);

  @override
  State<AddVaccine> createState() => _AddVaccineState();
}

class _AddVaccineState extends State<AddVaccine> {
  int vaccineType = 0;
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  List<QueryDocumentSnapshot> covaxine = [];
  List<QueryDocumentSnapshot> covishield = [];
  List<QueryDocumentSnapshot> sputnik = [];
  fetch() async {
    try {
      QuerySnapshot d = await FirebaseFirestore.instance
          .collection("Vaccine")
          .where("hospital", isEqualTo: patient.id)
          .get();
      // vaccine = d.docs;

      for (int i = 0; i < d.docs.length; i++) {
        if (d.docs[i]['vaccine'] == 1) {
          covaxine.add(d.docs[i]);
        }
        if (d.docs[i]['vaccine'] == 2) {
          covishield.add(d.docs[i]);
        }
        if (d.docs[i]['vaccine'] == 3) {
          sputnik.add(d.docs[i]);
        }
      }
      print(covaxine);
      print(covishield);
      print(sputnik);
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
        title: Text("Add Vaccine"),
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
                                      "Vaccine Type",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text("Covaxine  "),
                                      Radio(
                                          value: 1,
                                          groupValue: vaccineType,
                                          onChanged: (v) {
                                            stock.clear();
                                            price.clear();
                                            setState(() {
                                              if (covaxine.isNotEmpty) {
                                                vaccineType =
                                                    int.parse(v.toString());
                                                stock.text =
                                                    covaxine.first['stock'];
                                                price.text =
                                                    covaxine.first['price'];
                                              } else {
                                                vaccineType =
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
                                      const Text("Covishield"),
                                      Radio(
                                          value: 2,
                                          groupValue: vaccineType,
                                          onChanged: (v) {
                                            setState(() {
                                              stock.clear();
                                              price.clear();
                                              if (covishield.isNotEmpty) {
                                                vaccineType =
                                                    int.parse(v.toString());
                                                stock.text =
                                                    covishield.first['stock'];
                                                price.text =
                                                    covishield.first['price'];
                                              } else {
                                                vaccineType =
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
                                      Text("Sputnik   "),
                                      Radio(
                                          value: 3,
                                          groupValue: vaccineType,
                                          onChanged: (v) {
                                            stock.clear();
                                            price.clear();
                                            setState(() {
                                              if (sputnik.isNotEmpty) {
                                                vaccineType =
                                                    int.parse(v.toString());
                                                stock.text =
                                                    sputnik.first['stock'];
                                                price.text =
                                                    sputnik.first['price'];
                                              } else {
                                                vaccineType =
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
                  print(vaccineType);
                  print(stock.text);
                  print(price.text);
                  if (vaccineType != 0 &&
                      stock.text != "" &&
                      price.text != "") {
                    print("entered condition ");
                    if (vaccineType == 1 && covaxine.isNotEmpty) {
                      firestore
                          .collection("Vaccine")
                          .doc(covaxine.first.id)
                          .update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else if (vaccineType == 2 && covishield.isNotEmpty) {
                      firestore
                          .collection("Vaccine")
                          .doc(covishield.first.id)
                          .update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else if (vaccineType == 3 && sputnik.isNotEmpty) {
                      firestore
                          .collection("Vaccine")
                          .doc(sputnik.first.id)
                          .update({
                        "stock": stock.text,
                        "price": price.text,
                      });
                    } else {
                      print("called");
                      DocumentReference dr =
                          firestore.collection("Vaccine").doc();
                      dr.set({
                        "stock": stock.text,
                        "vaccine": vaccineType,
                        "price": price.text,
                        "hospital": patient.id,
                        "docId": dr.id,
                        "location": patient.location,
                        "name": patient.name,
                      });
                    }
                  }
                  vaccineType == 0;
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
