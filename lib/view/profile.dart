import 'package:covidpat/controller/data.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController patientName = TextEditingController(text: patient.name);
  TextEditingController patientid = TextEditingController(text: patient.id);
  TextEditingController patientPhone =
      TextEditingController(text: patient.mobile);
  TextEditingController patientAddress = TextEditingController();
  TextEditingController patientemail =
      TextEditingController(text: patient.email);
  int type = 0;
  TextEditingController location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Profile",
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
              BoxDecoration(color: Colors.lightBlueAccent.withOpacity(.7)),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
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
                                  enabled: false,
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
                                  enabled: false,
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
                            height: 60,
                            child: TextField(
                              controller: patientemail,
                              decoration: const InputDecoration(
                                  enabled: false,
                                  label: Text("email"),
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
                                  enabled: false,
                                  label: Text("Patient mobile"),
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none
                                  // border: OutlineInputBorder(),
                                  ),
                            )),
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //           decoration: BoxDecoration(
                  //               color: Colors.white.withOpacity(.7),
                  //               borderRadius: const BorderRadius.all(
                  //                 Radius.circular(5),
                  //               )),
                  //           width: MediaQuery.of(context).size.width * .8,
                  //           height: 50,
                  //           child: TextField(
                  //             controller: patientAddress,
                  //             decoration: const InputDecoration(
                  //                 label: Text("Patient Address"),
                  //                 contentPadding: EdgeInsets.all(10),
                  //                 border: InputBorder.none
                  //                 // border: OutlineInputBorder(),
                  //                 ),
                  //           )),
                  //     )
                  //   ],
                  // ),
                  // Row(

                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //           decoration: BoxDecoration(
                  //               color: Colors.white.withOpacity(.7),
                  //               borderRadius: const BorderRadius.all(
                  //                 Radius.circular(5),
                  //               )),
                  //           width: MediaQuery.of(context).size.width * .8,
                  //           height: 50,
                  //           child: TextField(
                  //             controller: location,
                  //             decoration: const InputDecoration(
                  //                 label: Text("Patient location"),
                  //                 contentPadding: EdgeInsets.all(10),
                  //                 border: InputBorder.none
                  //                 // border: OutlineInputBorder(),
                  //                 ),
                  //           )),
                  //     )
                  //   ],
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.deepOrange.withOpacity(.9),
                  //             borderRadius: const BorderRadius.all(
                  //               Radius.circular(5),
                  //             )),
                  //         width: MediaQuery.of(context).size.width * .8,
                  //         height: 50,
                  //         alignment: Alignment.center,
                  //         child: const Text(
                  //           "Update",
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
