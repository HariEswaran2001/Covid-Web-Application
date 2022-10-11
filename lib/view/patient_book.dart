import 'package:covidpat/controller/data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBookPatient extends StatefulWidget {
  const MyBookPatient({Key? key}) : super(key: key);

  @override
  State<MyBookPatient> createState() => _MyBookPatientState();
}

class _MyBookPatientState extends State<MyBookPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
      ),
      body: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                          child: Scaffold(
                            body: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("BedBook")
                                  .where("id", isEqualTo: patient.id)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var f = snapshot.data.docs[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: f['bedtype'] == 1
                                              ? Text("Normal")
                                              : f['bedtype'] == 2
                                                  ? Text("O2")
                                                  : Text("ICU"),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                  child:
                                                      Text(f['hospitalName'])),
                                              Expanded(
                                                  child:
                                                      Text("Rs." + f['total'])),
                                              Expanded(
                                                  child: Text(
                                                      f['hospitalLocation'])),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ));
              },
              child: ListTile(
                title: Text("Bed"),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                          child: Scaffold(
                            body: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("VaccineBook")
                                  .where("id", isEqualTo: patient.id)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var f = snapshot.data.docs[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: f['vaccineType'] == 1
                                              ? Text("Covaxine")
                                              : f['vaccineType'] == 2
                                                  ? Text("Covishield")
                                                  : Text("Sputnik"),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                  child:
                                                      Text(f['hospitalName'])),
                                              Expanded(
                                                  child:
                                                      Text("Rs." + f['total'])),
                                              Expanded(
                                                  child: Text(
                                                      f['hospitalLocation'])),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ));
              },
              child: ListTile(
                title: Text("Vaccine"),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                          child: Scaffold(
                            body: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("OxygenBook")
                                  .where("id", isEqualTo: patient.id)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var f = snapshot.data.docs[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: f['type'] == 1
                                              ? Text("Ventilator")
                                              : Text("Supply"),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                  child:
                                                      Text(f['hospitalName'])),
                                              Expanded(
                                                  child:
                                                      Text("Rs." + f['total'])),
                                              Expanded(
                                                  child: Text(
                                                      f['hospitalLocation'])),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ));
              },
              child: ListTile(
                title: Text("Oxygen"),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                          child: Scaffold(
                            body: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("BookScan")
                                  .where("id", isEqualTo: patient.id)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var f = snapshot.data.docs[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(f['pct'] == 1
                                                  ? "PCR : Yes"
                                                  : "PCR : No"),
                                              Text(f['ct'] == 1
                                                  ? "CT : Yes"
                                                  : "CT : No"),
                                            ],
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                  child:
                                                      Text(f['hospitalName'])),
                                              Expanded(
                                                  child:
                                                      Text("Rs." + f['total'])),
                                              Expanded(
                                                  child: Text(
                                                      f['hospitalLocation'])),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ));
              },
              child: ListTile(
                title: Text("Scan"),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
