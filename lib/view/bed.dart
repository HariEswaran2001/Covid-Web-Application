import 'package:covidpat/controller/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'success.dart';

class Bed extends StatefulWidget {
  const Bed({Key? key}) : super(key: key);

  @override
  State<Bed> createState() => _BedState();
}

class _BedState extends State<Bed> {
  TextEditingController patientName = TextEditingController(text: patient.name);
  TextEditingController patientid = TextEditingController(text: patient.id);
  TextEditingController patientPhone =
      TextEditingController(text: patient.mobile.toString());
  TextEditingController patientAddress = TextEditingController();
  TextEditingController patientemail =
      TextEditingController(text: patient.email);
  TextEditingController quantity = TextEditingController();
  int bedType = 0;
  TextEditingController location =
      TextEditingController(text: patient.location);
  TextEditingController hospitalName = TextEditingController();
  TextEditingController hospitalLocation = TextEditingController();
  List<QueryDocumentSnapshot> dataS = [];
  List<QueryDocumentSnapshot> backUp = [];
  List<QueryDocumentSnapshot> forLocation = [];
  List<QueryDocumentSnapshot> forHospital = [];
  late QueryDocumentSnapshot dsp;
  fetch() async {
    QuerySnapshot g = await FirebaseFirestore.instance.collection("Beds").get();
    dataS = g.docs;
    backUp = g.docs;
    print(dataS);

    setState(() {});
  }

  int price = 0;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("payment success");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Success(
            type: 'Bed',
            price: price.toString(),
          ),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  setup() {
    _razorpays.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpays.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpays.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  final Razorpay _razorpays = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
    if (kIsWeb) {
    } else {
      setup();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpays.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(patient.mobile);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Bed Booking",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purpleAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage("assets/hosbed.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(color: Colors.lightBlueAccent.withOpacity(.3)),
          child: SingleChildScrollView(
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: patientName,
                            decoration: const InputDecoration(
                                label: Text("Patient name"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: patientid,
                            decoration: const InputDecoration(
                                label: Text("Patient Id"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: patientPhone,
                            decoration: const InputDecoration(
                                label: Text("Patient mobile"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Text("normal"),
                                    Radio(
                                        value: 1,
                                        groupValue: bedType,
                                        onChanged: (v) {
                                          dataS.clear();
                                          dataS = backUp;
                                          List<QueryDocumentSnapshot> temp = [];
                                          for (int i = 0;
                                              i < dataS.length;
                                              i++) {
                                            if (dataS[i]['bed'] == 1) {
                                              temp.add(dataS[i]);
                                            }
                                          }
                                          setState(() {
                                            dataS = temp;
                                            forLocation = temp;
                                            bedType = int.parse(v.toString());
                                            hospitalName.clear();
                                            hospitalLocation.clear();
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Text("O2"),
                                    Radio(
                                        value: 2,
                                        groupValue: bedType,
                                        onChanged: (v) {
                                          dataS.clear();
                                          dataS = backUp;
                                          List<QueryDocumentSnapshot> temp = [];
                                          for (int i = 0;
                                              i < dataS.length;
                                              i++) {
                                            if (dataS[i]['bed'] == 2) {
                                              temp.add(dataS[i]);
                                            }
                                          }
                                          setState(() {
                                            dataS = temp;
                                            forLocation = temp;
                                            bedType = int.parse(v.toString());
                                            hospitalName.clear();
                                            hospitalLocation.clear();
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Text("ICU"),
                                    Radio(
                                        value: 3,
                                        groupValue: bedType,
                                        onChanged: (v) {
                                          dataS.clear();
                                          dataS = backUp;
                                          List<QueryDocumentSnapshot> temp = [];
                                          for (int i = 0;
                                              i < dataS.length;
                                              i++) {
                                            if (dataS[i]['bed'] == 3) {
                                              temp.add(dataS[i]);
                                            }
                                          }
                                          setState(() {
                                            dataS = temp;
                                            forLocation = temp;
                                            bedType = int.parse(v.toString());
                                            hospitalName.clear();
                                            hospitalLocation.clear();
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: patientAddress,
                            decoration: const InputDecoration(
                                label: Text("Patient Address"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: quantity,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: false),
                            decoration: const InputDecoration(
                                label: Text("quantity"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: location,
                            decoration: const InputDecoration(
                                label: Text("Patient location"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    )
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: hospitalLocation,
                            onChanged: (s) {
                              forLocation = dataS;
                              List<QueryDocumentSnapshot> temp = [];
                              for (int i = 0; i < forLocation.length; i++) {
                                if (forLocation[i]['location']
                                    .toString()
                                    .contains(s)) {
                                  temp.add(forLocation[i]);
                                }
                              }
                              forHospital = temp;
                              forLocation = temp;
                              hospitalName.clear();
                            },
                            decoration: const InputDecoration(
                                label: Text("Hospital location"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    ),
                    PopupMenuButton<QueryDocumentSnapshot>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (QueryDocumentSnapshot value) {
                        forLocation = dataS;
                        List<QueryDocumentSnapshot> temp = [];
                        hospitalLocation.text = value['location'];
                        for (int i = 0; i < forLocation.length; i++) {
                          if (forLocation[i]['location'] == value['location']) {
                            temp.add(forLocation[i]);
                          }
                        }
                        forLocation = temp;
                        forHospital = temp;
                        hospitalName.clear();
                      },
                      itemBuilder: (BuildContext context) {
                        return forLocation
                            .map<PopupMenuItem<QueryDocumentSnapshot>>(
                                (QueryDocumentSnapshot value) {
                          return PopupMenuItem(
                              child: Text(value['location']), value: value);
                        }).toList();
                      },
                    ),
                  ],
                ),
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
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          child: TextField(
                            controller: hospitalName,
                            onChanged: (s) {
                              List<QueryDocumentSnapshot> dd = [];
                              dd = forHospital;
                              List<QueryDocumentSnapshot> temp = [];
                              for (int i = 0; i < dd.length; i++) {
                                if (dd[i]['name'].toString().contains(s)) {
                                  temp.add(dd[i]);
                                }
                              }
                              forHospital = temp;
                              dsp = forHospital.first;
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                label: Text("Hospital Name"),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
                          )),
                    ),
                    PopupMenuButton<QueryDocumentSnapshot>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (QueryDocumentSnapshot value) {
                        List<QueryDocumentSnapshot> dd = [];
                        dd = forHospital;
                        List<QueryDocumentSnapshot> temp = [];
                        hospitalName.text = value['name'];
                        for (int i = 0; i < dd.length; i++) {
                          if (dd[i]['name'] == value['name']) {
                            temp.add(dd[i]);
                          }
                        }
                        forHospital = temp;
                        dsp = forHospital.first;
                      },
                      itemBuilder: (BuildContext context) {
                        return forHospital
                            .map<PopupMenuItem<QueryDocumentSnapshot>>(
                                (QueryDocumentSnapshot value) {
                          return PopupMenuItem(
                              child: Text(value['name']), value: value);
                        }).toList();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        if (patientName.text != "" &&
                            patientid.text != "" &&
                            patientPhone.text != "" &&
                            bedType != 0 &&
                            patientAddress.text != "" &&
                            location.text != "" &&
                            hospitalLocation.text != "" &&
                            quantity.text != "" &&
                            hospitalName.text != "") {
                          if (int.parse(dsp['stock']) >
                              int.parse(quantity.text)) {
                            price = 0;
                            price = int.parse(dsp['price'].toString());
                            price = price * int.parse(quantity.text);
                            print(dsp['name']);
                            firestore.collection("BedBook").doc().set({
                              "name": patientName.text,
                              "mobile": patientPhone.text,
                              "email": patientemail.text,
                              "id": patientid.text,
                              "bedtype": bedType,
                              "patientaddress": patientAddress.text,
                              "location": location.text,
                              "hospitalName": dsp['name'],
                              "hospitalLocation": dsp['location'],
                              "hospitalId": dsp['hospital'],
                              "total":
                                  price.toString() + " for x" + quantity.text,
                            });
                            int stock = int.parse(dsp['stock']);
                            print(stock);
                            stock = stock - int.parse(quantity.text);
                            print(stock);
                            print(dsp['docId']);
                            firestore
                                .collection("Beds")
                                .doc(dsp['docId'])
                                .update({"stock": stock.toString()});
                            var options = {
                              'key': 'rzp_test_d7Gag6em59RelQ',
                              'amount': (price * 100).toString(),
                              'name': 'covipat-x',
                              'description': 'Bed details',
                              'prefill': {
                                'contact': '8888888888',
                                'email': 'test@razorpay.com'
                              }
                            };
                            if (kIsWeb) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Success(
                                      type: 'Bed',
                                      price: price.toString(),
                                    ),
                                  ));
                            } else {
                              _razorpays.open(options);
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(.9),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              )),
                          width: MediaQuery.of(context).size.width * .8,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            "Book Your Bed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
