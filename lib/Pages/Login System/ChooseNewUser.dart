import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Pages/Doctor/NewDoctorData.dart';
import 'package:roshetta/Pages/Patient/NewPatientData.dart';
import 'package:roshetta/Pages/Pharmacy/NewPharmacyData.dart';
import 'package:roshetta/Widgets/Widgets.dart';
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
      backgroundColor:Pallet().background_R,
      appBar: AppBar(
        leading: IconButton(
          icon: Widgets().backArrowIcon(),
          onPressed: () async{
            var delAuth = await FirebaseAuth.instance.currentUser.delete();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            print('Auth deleted');
            },
        ),
        centerTitle: true,
        backgroundColor:Pallet().background_R,
        elevation: 0,
        title: Widgets().screenTitle('مستخدم جديد',Pallet().blue_R)
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('images/user.png'),
              SizedBox(height: 50),
              Widgets().arabicText(
                  text: 'التسجيل كـ',
                  fontSize: Spaces().mediumSize,
                  color: Pallet().red_R
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
                        color: Pallet().blue_R,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Widgets().arabicText(
                              text: 'مريض',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().white_R
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection(Strings().fireStoreTableName).doc(user.user.uid).set({
                            Strings().fireStoreUserID: 1,
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
                          child: Widgets().arabicText(
                              text: 'طبيب',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().white_R
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection(Strings().fireStoreTableName).doc(user.user.uid).set({
                            Strings().fireStoreUserID: 2,
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
                          child: Widgets().arabicText(
                              text: 'صيدلي',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().white_R
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection(Strings().fireStoreTableName).doc(user.user.uid).set({
                            Strings().fireStoreUserID: 3,
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
