import 'dart:ui';

import 'package:covidpat/controller/data.dart';
import 'package:covidpat/view/addVaccine.dart';
import 'package:covidpat/view/add_bed.dart';
import 'package:covidpat/view/add_oxygen.dart';
import 'package:covidpat/view/add_scan.dart';
import 'package:covidpat/view/bookings_hospital.dart';
import 'package:covidpat/view/oxygen.dart';
import 'package:covidpat/view/pcrct.dart';
import 'package:covidpat/view/vaccine.dart';
import 'package:flutter/material.dart';

import 'bed.dart';
import 'profile.dart';

class HospitalHome extends StatefulWidget {
  const HospitalHome({Key? key}) : super(key: key);

  @override
  State<HospitalHome> createState() => _HospitalHomeState();
}

class _HospitalHomeState extends State<HospitalHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, .95),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(.7),
            image: DecorationImage(
              image: AssetImage(
                "assets/adminback.jpg",
              ),
              opacity: .4,
              fit: BoxFit.fill,
            )),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent.withOpacity(.5),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.9, sigmaY: 1.9),
            child: Column(
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
                            backgroundImage: AssetImage("assets/doctor.png"),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "Current loction",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MyBookHos()));
                          },
                          icon: const Icon(
                            Icons.book_rounded,
                            size: 30,
                            color: Colors.blue,
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
                                builder: (context) => AddBed(),
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
                                    color: Colors.blue,
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
                                builder: (context) => AddScan(),
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
                                    color: Colors.blue,
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
                                builder: (context) => AddVaccine(),
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
                                  "Vaccine",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
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
                                builder: (context) => AddOxygen(),
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
                                  "Oxygen",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
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
          ),
        ),
      ),
    );
  }
}
