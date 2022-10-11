import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidpat/view/hospitalModule.dart';
import 'package:covidpat/view/registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/data.dart';
import '../model/patient.dart';
import 'patientHome.dart';

class Login extends StatefulWidget {
  final String data;
  const Login({Key? key, required this.data}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? val = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                          "Login",
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
                          "Login to your account",
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
                        controller: email,
                        decoration: const InputDecoration(label: Text("Email")),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: password,
                        decoration:
                            const InputDecoration(label: Text("Password")),
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
                      if (widget.data == "patient") {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          UserCredential user =
                              await auth.signInWithEmailAndPassword(
                                  email: email.text.toString().trim(),
                                  password: password.text);
                          DocumentSnapshot cnt = await firestore
                              .collection("patient")
                              .doc(email.text.toString().trim())
                              .get();
                          if (cnt['type'] == "patient") {
                            patient = PatientModel(
                                email: cnt['email'],
                                name: cnt['name'],
                                id: cnt['id'],
                                location: cnt['location'],
                                mobile: cnt['mobile']);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const PatientHome()),
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("user not exists !!"),
                            ));
                          }
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e
                                .toString()
                                .replaceAll(e.toString().split(" ").first, "")),
                          ));
                        }
                      } else {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          UserCredential user =
                              await auth.signInWithEmailAndPassword(
                                  email: email.text.toString().trim(),
                                  password: password.text);
                          DocumentSnapshot cnt = await firestore
                              .collection("hospital")
                              .doc(email.text.toString().trim())
                              .get();
                          if (cnt['type'] == "hospital") {
                            patient = PatientModel(
                                email: cnt['email'],
                                name: cnt['name'],
                                id: cnt['id'],
                                location: cnt['location'],
                                mobile: cnt['mobile']);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HospitalHome()),
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("user not exists !!"),
                            ));
                          }
                        } catch (e) {
                          print(e);
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
                        "Login",
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
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Registration(data: widget.data),
                      ));
                },
                child: SizedBox(
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Don't have an account ?"),
                        Text(
                          "Register",
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
