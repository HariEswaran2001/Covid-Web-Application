import 'package:covidpat/controller/data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBookHos extends StatefulWidget {
  const MyBookHos({Key? key}) : super(key: key);

  @override
  State<MyBookHos> createState() => _MyBookHosState();
}

class _MyBookHosState extends State<MyBookHos> {
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
                                  .where("hospitalId", isEqualTo: patient.id)
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
                                              Text(f['name']),
                                              Text("Rs." + f['total']),
                                              Text(f['location']),
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
                                  .where("hospitalId", isEqualTo: patient.id)
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
                                              Text(f['name']),
                                              Text("Rs." + f['total']),
                                              Text(f['location']),
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
                                  .where("hospitalId", isEqualTo: patient.id)
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
                                              Text(f['name']),
                                              Text("Rs." + f['total']),
                                              Text(f['location']),
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
                                  .where("hospitalId", isEqualTo: patient.id)
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
                                              Text(f['name']),
                                              Text("Rs." + f['total']),
                                              Text(f['location']),
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
