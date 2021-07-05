import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/AI/camera.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Widgets/DeleteAccount.dart';
import 'package:roshetta/Widgets/EditAccount.dart';
import 'package:roshetta/Widgets/ExitAccount.dart';
import '../Login System/LoginScreen.dart';
import 'Pharmacy.dart';
import 'PharmacyDatabase.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({Key key}) : super(key: key);

  @override
  _PharmacyHomeScreenState createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  Pharmacy pharmacy;

  Future<String> downloadData()async{
    pharmacy= await PharmacyDatabase().get(FirebaseAuth.instance.currentUser.uid);
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
            backgroundColor: Color(0xFFF5F5F5),
            body: Center(child: CircularProgressIndicator(color: Pallet().blue_R,)),
          );
        }else{
          if (snapshot.hasError)
            return Scaffold(
              backgroundColor: Color(0xFFF5F5F5),
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          else
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                backgroundColor: Pallet().blue_R,
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Camera()));
                },
              ),
              backgroundColor: Color(0xFFF5F5F5),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(0xFF33CFE8),
                title: Text(
                  'الصفحة الرئيسية للصيدلي',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'arabic', fontSize: 20),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Pallet().blue_R,
                          child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Pallet().white_R,
                              child: ClipOval(
                                  child: Image.network(
                                    'http://roshetta1.pythonanywhere.com/showprofileimage/${FirebaseAuth.instance.currentUser.uid}/${pharmacy.profileImage}',
                                    height: 130,
                                    width: 300,
                                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(color: Pallet().blue_R,),
                                      );
                                    },
                                  )
                              )
                          ),
                        )
                    ),

                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'مرحبا بك ${pharmacy.firstName}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Color(0xFFC63C22),
                            fontFamily: 'arabic',
                            fontSize: 22),
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
                        EditAccount(pharmacy),
                        SizedBox(height: 20,),
                        ExitAccount(),
                        SizedBox(height: 20,),
                        DeleteAccount(),
                      ],
                    ),
                  )),
            );  // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
