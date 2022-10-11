import 'package:covidpat/controller/data.dart';
import 'package:covidpat/model/patient.dart';
import 'package:covidpat/view/hospitalModule.dart';
import 'package:covidpat/view/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'patientHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registration extends StatefulWidget {
  final String data;
  const Registration({Key? key, required this.data}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _location = TextEditingController();
  bool? val = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      (widget.data == "patient"
                          ? "assets/businessman.webp"
                          : "assets/doctor.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: const [
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: const [
                        Text(
                          "Register to your account",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: _name,
                        decoration: const InputDecoration(label: Text("Name")),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: _mobile,
                        decoration:
                            const InputDecoration(label: Text("mobile")),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: _email,
                        decoration: const InputDecoration(label: Text("Email")),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: _location,
                        decoration:
                            const InputDecoration(label: Text("Location")),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: _password,
                        decoration:
                            const InputDecoration(label: Text("Password")),
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                                value: val,
                                onChanged: (v) {
                                  setState(() {
                                    val = v;
                                  });
                                }),
                            const Text("Remind me")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (widget.data == "patient" &&
                          _name.text != "" &&
                          _mobile.text != "" &&
                          _location.text != "") {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        try {
                          // print(_email.text);
                          UserCredential user =
                              await auth.createUserWithEmailAndPassword(
                                  email: _email.text.toString().trim(),
                                  password: _password.text);
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          var size = 0;
                          try {
                            QuerySnapshot cnt =
                                await firestore.collection("patient").get();
                            size = cnt.size;
                          } catch (e) {
                            size = 0;
                          }
                          print("vaa" + size.toString());
                          firestore
                              .collection("patient")
                              .doc(_email.text.toString().trim())
                              .set({
                            "name": _name.text,
                            "mobile": _mobile.text,
                            "email": _email.text,
                            "type": "patient",
                            "location": _location.text,
                            "id": ("RP-" + ((size + 1).toString()))
                          });
                          patient = PatientModel(
                              email: _email.text,
                              name: _name.text,
                              location: _location.text,
                              id: ("RP-" + ((size + 1).toString())),
                              mobile: _mobile.text);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const PatientHome()),
                              (Route<dynamic> route) => false);
                        } catch (e) {
                          // print(e.toString().split(" ").first);
                          // print(e
                          //     .toString()
                          //     .replaceAll(e.toString().split(" ").first, ""));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e
                                .toString()
                                .replaceAll(e.toString().split(" ").first, "")),
                          ));
                        }
                      }
                      if (widget.data == "hospital" &&
                          _name.text != "" &&
                          _mobile.text != "") {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        try {
                          // print(_email.text);
                          UserCredential user =
                              await auth.createUserWithEmailAndPassword(
                                  email: _email.text.toString().trim(),
                                  password: _password.text);
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          var size = 0;
                          try {
                            QuerySnapshot cnt =
                                await firestore.collection("hospital").get();
                            size = cnt.size;
                          } catch (e) {
                            size = 0;
                          }
                          print("vaa" + size.toString());
                          firestore
                              .collection("hospital")
                              .doc(_email.text.toString().trim())
                              .set({
                            "name": _name.text,
                            "mobile": _mobile.text,
                            "email": _email.text,
                            "location": _location.text,
                            "type": "hospital",
                            "id": ("RH-" + ((size + 1).toString()))
                          });
                          patient = PatientModel(
                              email: _email.text,
                              name: _name.text,
                              location: _location.text,
                              id: ("RH-" + ((size + 1).toString())),
                              mobile: _mobile.text);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HospitalHome()),
                              (Route<dynamic> route) => false);
                        } catch (e) {
                          // print(e.toString().split(" ").first);
                          // print(e
                          //     .toString()
                          //     .replaceAll(e.toString().split(" ").first, ""));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e
                                .toString()
                                .replaceAll(e.toString().split(" ").first, "")),
                          ));
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: 50,
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(data: widget.data),
                      ));
                },
                child: SizedBox(
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Already have an account ?"),
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
