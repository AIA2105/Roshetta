import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Constants/Users.dart';
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
    var mainUser = Users().noUser;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if(FirebaseAuth.instance.currentUser !=null){
      print('Current User Found!');
      await FirebaseFirestore.instance.collection(Strings().fireStoreTableName).doc(FirebaseAuth.instance.currentUser.uid).get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          mainUser= documentSnapshot[Strings().fireStoreUserID];
          print('from main mainUser= $mainUser');
        }else{
          mainUser= 0;
          print('Data not found for ${FirebaseAuth.instance.currentUser.uid},from main mainUser= $mainUser');
          await FirebaseAuth.instance.currentUser.delete();
        }
          });
    }else{
      print('No Current User Found!');
    }

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings().appName,
      home: FirebaseAuth.instance.currentUser != null? userScreen(mainUser):LoginScreen(),
    ));
  } else {
    print('No internet :( Reason:');
    print(InternetConnectionChecker().lastTryResults);
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings().appName,
      home: NoInternet(),
    ));
  }

}

Widget userScreen(int mainUser){

  print('from userScreen mainUser= $mainUser');
  if(mainUser==Users().patient){
    return PatientHomeScreen();
  }else if(mainUser==Users().doctor){
    return DoctorHomeScreen();
  }else if(mainUser==Users().pharmacy){
    return PharmacyHomeScreen();
  }else if(mainUser==Users().noUser){
    print('User Auth has deleted -Cause: Auth found but data not found for ${FirebaseAuth.instance.currentUser.uid}');
    return LoginScreen();
  }else{
    print('LoginScreen from userScreen');
    return LoginScreen();
  }
}

