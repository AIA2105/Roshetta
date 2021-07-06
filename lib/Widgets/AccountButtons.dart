import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Constants/Users.dart';
import 'package:roshetta/Pages/Doctor/DoctorHomeScreen.dart';
import 'package:roshetta/Pages/Login%20System/ChooseNewUser.dart';
import 'package:roshetta/Pages/Login%20System/ResetEmailSent.dart';
import 'package:roshetta/Pages/Patient/PatientHomeScreen.dart';
import 'package:roshetta/Pages/Pharmacy/PharmacyHomeScreen.dart';
import 'package:roshetta/Widgets/Widgets.dart';

class AccountButtons {

   Future<bool> login(BuildContext context, String email, String password) async {
    print('try to login');
    print('email:$email, password: $password');
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        var result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print(result);
        if (result != null) {
          // pushReplacement
          FirebaseFirestore.instance
              .collection(Strings().fireStoreTableName)
              .doc(result.user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              if (documentSnapshot[Strings().fireStoreUserID] == Users().patient) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PatientHomeScreen()),
                );
              } else if (documentSnapshot[Strings().fireStoreUserID] == Users().doctor) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorHomeScreen()),
                );
              } else if (documentSnapshot[Strings().fireStoreUserID] == Users().pharmacy) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PharmacyHomeScreen()),
                );
              }
            }
          });
        }
        return true;

      } on FirebaseAuthException catch (e) {
        if (e.code != null) {
          print('------- error --------');
          ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
              text: 'خطأ في البيانات',
              background: Pallet().red_R,
              duration: 2
          ));
          return false;
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
          text: 'برجاء ادخال البيانات',
          background: Pallet().red_R,
          duration: 2
      ));
      return false;
    }
  }

  void Reset(BuildContext context, String email) async {
    print('try to login');
    print('email:$email');
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResetEmailSent()),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code != null) {
          print('------- error --------');
          ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
              text: 'خطأ في البيانات',
              background: Pallet().red_R,
              duration: 2
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
          text: 'برجاء ادخال البيانات',
          background: Pallet().red_R,
          duration: 2
      ));
    }
  }

  void newUser(BuildContext context, String email, String password) async {
    print('try to signup');
    print('email:$email, password: $password');
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        var result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(result);
        if (result != null) {
          // pushReplacement
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChooseNewUser(user: result)),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code != null) {
          print('------- error --------');
          ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
              text: 'خطأ في البيانات',
              background: Pallet().red_R,
              duration: 2
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(Widgets().snakBar(
          text: 'برجاء ادخال البيانات',
          background: Pallet().red_R,
          duration: 2
      ));
    }
  }

}
