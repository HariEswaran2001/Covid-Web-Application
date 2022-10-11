import 'package:covidpat/controller/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'success.dart';

class PcrCt extends StatefulWidget {
  const PcrCt({Key? key}) : super(key: key);

  @override
  State<PcrCt> createState() => _PcrCtState();
}

class _PcrCtState extends State<PcrCt> {
  TextEditingController date = TextEditingController();
  TextEditingController patientAddress = TextEditingController();
  TextEditingController time = TextEditingController();
  int pcr = 0;
  int ct = 0;
  TextEditingController location =
      TextEditingController(text: patient.location);
  TextEditingController hospitalName = TextEditingController();
  TextEditingController hospitalLocation = TextEditingController();
  List<QueryDocumentSnapshot> dataS = [];
  List<QueryDocumentSnapshot> backUp = [];
  List<QueryDocumentSnapshot> another = [];
  List<QueryDocumentSnapshot> forLocation = [];
  List<QueryDocumentSnapshot> forHospital = [];
  late QueryDocumentSnapshot dsp;
  fetch() async {
    QuerySnapshot g = await FirebaseFirestore.instance.collection("Scan").get();
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
            type: 'PCR/CT',
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
  setups() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  final Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
    if (kIsWeb) {
    } else {
      setups();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "PCR/CT Scan",
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
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("CT AVAIL: "),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text("Yes "),
                                      Radio(
                                          value: 1,
                                          groupValue: ct,
                                          onChanged: (v) {
                                            print(
                                                "aaaaaa" + another.toString());
                                            // dataS.clear();
                                            dataS = another;
                                            List<QueryDocumentSnapshot> temp =
                                                [];
                                            print("aaddddddddaaaa" +
                                                another.toString());
                                            for (int i = 0;
                                                i < another.length;
                                                i++) {
                                              print("fffffff");
                                              print(another[i]);
                                              if (another[i]['ct'] == true) {
                                                temp.add(another[i]);
                                                print("lllllll");
                                              }
                                            }
                                            setState(() {
                                              dataS = temp;
                                              print(
                                                  "ppppppp" + dataS.toString());
                                              forLocation = temp;
                                              ct = int.parse(v.toString());
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
                                      const Text("NO "),
                                      Radio(
                                          value: 2,
                                          groupValue: ct,
                                          onChanged: (v) {
                                            dataS.clear();
                                            dataS = another;
                                            List<QueryDocumentSnapshot> temp =
                                                [];
                                            for (int i = 0;
                                                i < dataS.length;
                                                i++) {
                                              temp.add(dataS[i]);
                                            }
                                            setState(() {
                                              dataS = temp;
                                              forLocation = temp;
                                              ct = int.parse(v.toString());
                                              hospitalName.clear();
                                              hospitalLocation.clear();
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ],
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
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("PCR AVAIL: "),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      const Text("Yes "),
                                      Radio(
                                          value: 1,
                                          groupValue: pcr,
                                          onChanged: (v) {
                                            dataS.clear();
                                            dataS = backUp;
                                            List<QueryDocumentSnapshot> temp =
                                                [];
                                            for (int i = 0;
                                                i < dataS.length;
                                                i++) {
                                              if (dataS[i]['pcr'] == true) {
                                                temp.add(dataS[i]);
                                              }
                                            }
                                            setState(() {
                                              dataS = temp;
                                              forLocation = temp;
                                              another = temp;
                                              pcr = int.parse(v.toString());
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
                                      const Text("NO "),
                                      Radio(
                                          value: 2,
                                          groupValue: pcr,
                                          onChanged: (v) {
                                            dataS.clear();
                                            dataS = backUp;
                                            List<QueryDocumentSnapshot> temp =
                                                [];
                                            for (int i = 0;
                                                i < dataS.length;
                                                i++) {
                                              temp.add(dataS[i]);
                                            }
                                            setState(() {
                                              dataS = temp;
                                              forLocation = temp;
                                              another = temp;
                                              pcr = int.parse(v.toString());
                                              hospitalName.clear();
                                              hospitalLocation.clear();
                                              print(another);
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ],
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
                            controller: date,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101));
                                      if (picked != null) {
                                        setState(() {
                                          date.text =
                                              picked.toString().split(" ")[0];
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month)),
                                label: const Text("Appointment Date"),
                                contentPadding: const EdgeInsets.all(10),
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
                            controller: time,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      final TimeOfDay? picked =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          time.text = picked.format(context);
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.timer)),
                                label: const Text("Appointment Time"),
                                contentPadding: const EdgeInsets.all(10),
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
                        if (date.text != "" &&
                            time.text != "" &&
                            pcr != 0 &&
                            ct != 0 &&
                            location.text != "" &&
                            hospitalLocation.text != "" &&
                            hospitalName.text != "") {
                          price = 0;
                          if (pcr == 1) {
                            int ac = int.parse(dsp['pcrPrice']);
                            price = price + ac;
                          }
                          if (ct == 1) {
                            int ac = int.parse(dsp['ctPrice']);
                            price = price + ac;
                          }
                          firestore.collection("BookScan").doc().set({
                            "name": patient.name,
                            "mobile": patient.mobile,
                            "email": patient.email,
                            "id": patient.id,
                            "ct": ct,
                            "pct": pcr,
                            "location": location.text,
                            "date": date.text,
                            "time": time.text,
                            "hospitalName": dsp['name'],
                            "hospitalLocation": dsp['location'],
                            "hospitalId": dsp['hospital'],
                            "total": price.toString(),
                          });
                          var options = {
                            'key': 'rzp_test_d7Gag6em59RelQ',
                            'amount': (price * 100).toString(),
                            'name': 'covipat-x',
                            'description': 'PCR/CT Scan details',
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
                                    type: 'PCR/CT',
                                    price: price.toString(),
                                  ),
                                ));
                          } else {
                            _razorpay.open(options);
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
                            "Book Your Scan",
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
