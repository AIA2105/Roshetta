import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Pages/Patient/NewPatientData.dart';
import 'Pages/Doctor/DoctorHomeScreen.dart';
import 'Pages/Login System/LoginScreen.dart';
import 'Pages/Login System/NoInternet.dart';
import 'Pages/Patient/PatientHomeScreen.dart';
import 'Pages/Pharmacy/PharmacyHomeScreen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


void main() async {

  // runApp(MaterialApp(
  //   title: 'Roshetta',
  //   home: NewPatientData(),
  // ));

  bool result = await InternetConnectionChecker().hasConnection;
  if(result == true) {
    print('We have internet!');
    var mainUser=0;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if(FirebaseAuth.instance.currentUser !=null){
      print('Current User Found!');
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          mainUser= documentSnapshot['id'];
          print('from main mainUser= $mainUser');
        }});
    }else{
      print('No Current User Found!');
    }

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roshetta',
      home: FirebaseAuth.instance.currentUser != null? userScreen(mainUser):LoginScreen(),
    ));
  } else {
    print('No internet :( Reason:');
    print(InternetConnectionChecker().lastTryResults);
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roshetta',
      home: NoInternet(),
    ));
  }

}

Widget userScreen(int mainUser){

  print('from userScreen mainUser= $mainUser');
  if(mainUser==1){
    return PatientHomeScreen();
  }else if(mainUser==2){
    return DoctorHomeScreen();
  }else if(mainUser==3){
    return PharmacyHomeScreen();
  }else{
    print('LoginScreen from userScreen');
    return LoginScreen();
  }
}

