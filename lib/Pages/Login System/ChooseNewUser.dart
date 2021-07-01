import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Doctor/NewDoctorData.dart';
import 'package:roshetta/Pages/Patient/NewPatientData.dart';
import 'package:roshetta/Pages/Pharmacy/NewPharmacyData.dart';
import 'LoginScreen.dart';

class ChooseNewUser extends StatefulWidget {
  final UserCredential user;
  ChooseNewUser({Key key, @required this.user}) : super(key: key);

  _ChooseNewUserState createState() => _ChooseNewUserState(user);
}

class _ChooseNewUserState extends State<ChooseNewUser> {
  UserCredential user;
  bool clicked=false;

  _ChooseNewUserState(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Pallet().blue_R,
            size: Spaces().backButton,
          ),
          onPressed: () async{
            var delAuth = await FirebaseAuth.instance.currentUser.delete();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            print('Auth deleted');
            },
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        title: Text(
          'مستخدم جديد',
          style: TextStyle(
              color: Color(0xFFC63C22), fontFamily: 'arabic', fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('images/user.png'),
              SizedBox(height: 50),
              Text(
                'التسجيل كـ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Color(0xFFC63C22), fontFamily: 'arabic', fontSize: 18),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xFF33CFE8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'مريض',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'arabic',
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('users').doc(user.user.uid).set({
                            'id': 1,
                            'email': user.user.email,
                          });
                          print(user);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPatientData()),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 26,
                      left: 44,
                      child: Image.asset('images/patient.png',))
                ],
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xFF33CFE8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'طبيب',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'arabic',
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('users').doc(user.user.uid).set({
                            'id': 2,
                            'email': user.user.email,
                          });
                          print(user);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewDoctorData()),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 26,
                      left: 44,
                      child: Image.asset('images/doctor.png',))
                ],
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xFF33CFE8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'صيدلي',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'arabic',
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('users').doc(user.user.uid).set({
                            'id': 3,
                            'email': user.user.email,
                          });
                          print(user);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPharmacyData()),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 26,
                      left: 44,
                      child: Image.asset('images/pharmacy.png',))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
