import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/AI/camera.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Patient/PatientDatabase.dart';
import 'package:roshetta/Pages/Patient/Prescription/LocalPrescriptions.dart';
import 'package:roshetta/Widgets/EditAccount.dart';
import 'package:roshetta/Widgets/ExitAccount.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'Patient.dart';
import 'Prescription/AddLocalPrescription.dart';
import 'Prescription/DigitalPrescritions.dart';
import 'Prescription/Notifications.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key key}) : super(key: key);

  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  Patient patient;
  String dashboard;
  List numbers;
  String notification;

  Future<String> downloadData() async {
    patient =
        await PatientDatabase().get(FirebaseAuth.instance.currentUser.uid);
    dashboard = await PatientDatabase()
        .dashboard(FirebaseAuth.instance.currentUser.uid);
    numbers = dashboard.split(',');
    notification = await PatientDatabase().notification(FirebaseAuth.instance.currentUser.uid);

    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: downloadData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Pallet().background_R,
            child: Center(
                child: CircularProgressIndicator(
              color: Pallet().blue_R,
            )),
          );
        } else {
          if (snapshot.hasError)
            return Scaffold(
              backgroundColor: Pallet().background_R,
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          else {
            return Scaffold(
                backgroundColor: Pallet().background_R,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Pallet().blue_R,
                  title: Widgets()
                      .screenTitle('الصفحة الرئيسية للمريض', Pallet().white_R),
                  actions: [
                    InkWell(
                      onTap: () {
                        if (notification != '0') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notifications(
                                    int.parse(notification))),
                          );
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              Widgets().snakBar(
                                  text: 'لا توجد اشعارات جديدة',
                                  background: Pallet().blue_R,
                                  duration: 2));
                        }
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10,top: 5),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.notifications_sharp,
                                  color: Pallet().white_R,
                                  size: 30,
                                ),
                              ),
                              notification!='0'?Positioned(
                                right: 15,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(100)),
                                  color: Pallet().red_R,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(
                                      notification,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Pallet().white_R),
                                    ),
                                  ),
                                ),
                              ):Container(),

                            ],
                          )
                        ),
                      ),
                    )
                  ],
                ),
                body: ListView(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 50, top: 50),
                    children: [
                      Container(
                        width: double.infinity,
                        //height: double.infinity,
                        child: Card(
                            elevation: 6,
                            color: Pallet().white_R,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Column(
                              children: [
                                Widgets().arabicText(
                                  text: 'الروشتات المحفوظة',
                                  fontSize: Spaces().biggest,
                                  color: Pallet().blue_R,
                                ),
                                Widgets().arabicText(
                                  text: numbers[0],
                                  fontSize: 100,
                                  color: Pallet().red_R,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 50),
                                  child: ButtonTheme(
                                      minWidth: double.maxFinite,
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          color: Pallet().red_R,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Widgets().arabicText(
                                              text: 'حفظ روشتة جديدة',
                                              fontSize: Spaces().biggest,
                                              color: Pallet().white_R,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddLocalPrescription()),
                                            );
                                          })),
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                Widgets().arabicText(
                                  text: 'الروشتات المستلمة',
                                  fontSize: Spaces().biggest,
                                  color: Pallet().blue_R,
                                ),
                                Widgets().arabicText(
                                  text: numbers[1],
                                  fontSize: 100,
                                  color: Pallet().red_R,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 50),
                                  child: ButtonTheme(
                                      minWidth: double.maxFinite,
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          color: Pallet().red_R,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Widgets().arabicText(
                                              text: 'ترجمة روشتة',
                                              fontSize: Spaces().biggest,
                                              color: Pallet().white_R,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Camera()),
                                            );
                                          })),
                                )
                              ],
                            )),
                      ),
                    ]),
                drawer: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(180)),
                  child: Drawer(
                      child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                              child: EditAccount(
                                  FirebaseAuth.instance.currentUser.uid,
                                  patient.profileImage,
                                  patient)),
                          Center(
                            child: Widgets().arabicText(
                                text:
                                    '${patient.firstName} ${patient.lastName}',
                                fontSize: Spaces().bigTitleSize,
                                color: Pallet().red_R,
                                textDirection: TextDirection.rtl),
                          ),
                          SizedBox(
                            height: 100,
                          ),

                          ListTile(
                            title: Widgets().arabicText(
                              text: 'الإشعارات',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().red_R,
                            ),
                            leading: notification == '0'
                                ? Icon(
                                    Icons.notifications_sharp,
                                    color: Pallet().red_R,
                                  )
                                : Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    color: Pallet().blue_R,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        notification,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Pallet().white_R),
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              if (notification != '0') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Notifications(
                                          int.parse(notification))),
                                );
                              } else {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    Widgets().snakBar(
                                        text: 'لا توجد اشعارات جديدة',
                                        background: Pallet().blue_R,
                                        duration: 2));
                              }
                            },
                          ),

                      ListTile(
                        title: Widgets().arabicText(
                          text: 'ترجمة روشتة',
                          fontSize: Spaces().mediumSize,
                          color: Pallet().red_R,
                        ),
                        leading: Icon(
                          Icons.photo_camera_outlined,
                          color: Pallet().red_R,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Camera()),
                          );
                        },
                      ),

                          ListTile(
                            title: Widgets().arabicText(
                              text: 'روشتتاتي المستلمة',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().red_R,
                            ),
                            leading: Icon(
                              Icons.call_received,
                              color: Pallet().red_R,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DigitalPrescriptions()),
                              );
                            },
                          ),
                          ListTile(
                            title: Widgets().arabicText(
                              text: 'روشتتاتي المحفوظة',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().red_R,
                            ),
                            leading: Icon(
                              Icons.save,
                              color: Pallet().red_R,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocalPrescriptions()),
                              );
                            },
                          ),

                          /////////////////////////
                          Divider(),
                          ExitAccount(),
                        ],
                      ),
                    ],
                  )),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Pallet().blue_R,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientHomeScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Icon(
                      Icons.refresh,
                      color: Pallet().white_R,
                      size: 30,
                    ),
                  ),
                ));
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
