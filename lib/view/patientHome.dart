import 'dart:ui';

import 'package:covidpat/view/oxygen.dart';
import 'package:covidpat/view/patient_book.dart';
import 'package:covidpat/view/pcrct.dart';
import 'package:covidpat/view/vaccine.dart';
import 'package:flutter/material.dart';

import '../controller/data.dart';
import 'bed.dart';
import 'profile.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, .95),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/homeback.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Stack(
            children: [
              Container(
                color: Colors.transparent.withOpacity(.4),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ));
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/businessman.webp"),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              "Current loction",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              patient.location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MyBookPatient()));
                            },
                            icon: Icon(
                              Icons.book,
                              size: 30,
                              color: Color.fromRGBO(50, 50, 168, 1),
                            )),
                        const SizedBox(width: 20)
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Bed(),
                                ));
                          },
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage("assets/bed.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Colors.blue,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(7, 7),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Bed",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(75, 75, 193, 1.0),
                                      shadows: [
                                        Shadow(
                                          color: Colors.blueAccent,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PcrCt(),
                                ));
                          },
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage("assets/ct.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Colors.blue,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5, 5),
                                        blurRadius: 6,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "PCR/CT scan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(75, 75, 193, 1.0),
                                      shadows: [
                                        Shadow(
                                          color: Colors.blueAccent,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Vaccine(),
                                ));
                          },
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage("assets/vacc1.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Color.fromRGBO(75, 75, 193, 1.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5, 5),
                                        blurRadius: 6,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Vaccine",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(75, 75, 193, 1.0),
                                      shadows: [
                                        Shadow(
                                          color: Colors.blueAccent,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Oxygen(),
                                ));
                          },
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage("assets/oxygen.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Color.fromRGBO(75, 75, 193, 1.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5, 5),
                                        blurRadius: 6,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Oxygen",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(75, 75, 193, 1.0),
                                      shadows: [
                                        Shadow(
                                          color: Colors.blueAccent,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
