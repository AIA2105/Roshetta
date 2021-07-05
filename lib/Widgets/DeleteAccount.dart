import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Pages/Doctor/DoctorDatabase.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key key}) : super(key: key);

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  var user;
  @override
  void initState(){
    user= FirebaseAuth.instance.currentUser;
    super.initState();
  }
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
                'متأكد من رغبتك في حذف الحساب؟',
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
                    'حذف الحساب',
                    style: TextStyle(
                        color: Color(0xFFC63C22),
                        fontFamily: 'arabic',
                        fontSize: 16),
                  ),
                  onPressed:  () async{
                    DoctorDatabase().delete(user.uid);
                    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
                    await FirebaseAuth.instance.currentUser.delete();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    print('Auth & data deleted');
                  },
                ),

              ],
            );
          },
        );

      },
      child: Text(
        'حذف الحساب',
        style: TextStyle(
            color: Color(0xFFC63C22),
            fontFamily: 'arabic',
            fontSize: 20),
      ),
    );
  }
}
