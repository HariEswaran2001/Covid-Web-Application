import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/data.dart';

class AddScan extends StatefulWidget {
  const AddScan({Key? key}) : super(key: key);

  @override
  State<AddScan> createState() => _AddScanState();
}

class _AddScanState extends State<AddScan> {
  bool pcr = false;
  bool ct = false;
  String pcrPrice = "";
  String ctPrice = "";
  TextEditingController pPrice = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  // List<QueryDocumentSnapshot> pcr = [];
  // List<QueryDocumentSnapshot> ct = [];
  fetch() async {
    try {
      QuerySnapshot d = await FirebaseFirestore.instance
          .collection("Scan")
          .where("hospital", isEqualTo: patient.id)
          .get();
      // vaccine = d.docs;
      QueryDocumentSnapshot fir = d.docs.first;
      pcr = fir['pcr'];
      ct = fir['ct'];
      pcrPrice = fir['pcrPrice'];
      ctPrice = fir['ctPrice'];
      pPrice.text = pcrPrice;
      cPrice.text = ctPrice;
      setState(() {});
      print(pcr);
      print(ct);
      print(pcrPrice);
      print(ctPrice);
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
        title: Text("Add Scan"),
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
                                  children: [
                                    const Text(
                                      "PCR",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Switch(
                                        value: pcr,
                                        onChanged: (v) {
                                          setState(() {
                                            pcr = v;
                                          });
                                        })
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "CT",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Switch(
                                        value: ct,
                                        onChanged: (v) {
                                          setState(() {
                                            ct = v;
                                          });
                                        })
                                  ],
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
                      controller: pPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "PCR price", labelText: "PCR price"),
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
                      controller: cPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "CT price",
                        labelText: "CT price",
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  print("btn clicked");
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  print(ct);
                  print(pcr);
                  print(pPrice.text);
                  print(cPrice.text);
                  if (pPrice.text != "" && cPrice.text != "") {
                    try {
                      QuerySnapshot d = await FirebaseFirestore.instance
                          .collection("Scan")
                          .where("hospital", isEqualTo: patient.id)
                          .get();
                      // vaccine = d.docs;
                      QueryDocumentSnapshot fir = d.docs.first;
                      FirebaseFirestore.instance
                          .collection("Scan")
                          .doc(fir.id)
                          .update({
                        "pcr": pcr,
                        "ct": ct,
                        "hospital": patient.id,
                        "pcrPrice": pPrice.text,
                        "ctPrice": cPrice.text,
                      });
                    } catch (e) {
                      DocumentReference dr =
                          FirebaseFirestore.instance.collection("Scan").doc();
                      dr.set({
                        "pcr": pcr,
                        "ct": ct,
                        "hospital": patient.id,
                        "pcrPrice": pPrice.text,
                        "ctPrice": cPrice.text,
                        "docId": dr.id,
                        "location": patient.location,
                        "name": patient.name,
                      });
                    }
                  }
                  pPrice.clear();
                  cPrice.clear();
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
