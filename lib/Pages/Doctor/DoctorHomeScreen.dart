import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Widgets/DeleteAccount.dart';
import 'package:roshetta/Widgets/EditAccount.dart';
import 'package:roshetta/Widgets/ExitAccount.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import '../Login System/LoginScreen.dart';
import 'Doctor.dart';
import 'DoctorDatabase.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key key}) : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  Doctor doctor;

  Future<String> downloadData()async{
    doctor= await DoctorDatabase().get(FirebaseAuth.instance.currentUser.uid);
    return Future.value("Data download successfully");
    // return your response
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: downloadData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  // AsyncSnapshot<Your object type>
        if( snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            backgroundColor:Pallet().background_R,
            body: Center(child: CircularProgressIndicator(color: Pallet().blue_R,)),
          );
        }else{
          if (snapshot.hasError)
            return Scaffold(
              backgroundColor:Pallet().background_R,
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          else {
            return Scaffold(
              backgroundColor:Pallet().background_R,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(0xFF33CFE8),
                title: Widgets().screenTitle('الصفحة الرئيسية للطبيب',Pallet().white_R)
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Widgets().profilePicture(FirebaseAuth.instance.currentUser.uid, doctor.profileImage),
                    Container(
                      alignment: Alignment.center,
                      child: Widgets().arabicText(
                          text:'مرحبا بك ${doctor.firstName}',
                          fontSize:Spaces().bigTitleSize,
                          color: Pallet().red_R,
                          textDirection: TextDirection.rtl
                      ),
                    ),
                  ],
                ),
              ),
              drawer: Drawer(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditAccount(doctor),
                        SizedBox(height: Spaces().mediumSize),
                       ExitAccount(),
                        SizedBox(height: Spaces().mediumSize),
                        DeleteAccount(),
                      ],
                    ),
                  )),
            );
          }  // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
