import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Pages/Doctor/DoctorDatabase.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';

class ExitAccount extends StatefulWidget {
  const ExitAccount({Key key}) : super(key: key);

  @override
  _ExitAccountState createState() => _ExitAccountState();
}

class _ExitAccountState extends State<ExitAccount> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(right: 40,left: 30,top: 10),
              title: Text(
                'متأكد من رغبتك في الخروج؟',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Pallet().red_R,
                    fontFamily: 'arabic',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'الغاء العملية',
                    style: TextStyle(
                        color: Pallet().blue_R,
                        fontFamily: 'arabic',
                        fontSize: 16),
                  ),
                  onPressed:  (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                        color: Color(0xFFC63C22),
                        fontFamily: 'arabic',
                        fontSize: 16),
                  ),
                  onPressed:  () async{
                    var user= FirebaseAuth.instance.currentUser;
                    var result = await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    print('exit Account');
                  },
                ),

              ],
            );
          },
        );

      },
      child: Text(
        'تسجيل الخروج',
        style: TextStyle(
            color: Color(0xFFC63C22),
            fontFamily: 'arabic',
            fontSize: 20),
      ),
    );
  }
}
