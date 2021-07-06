import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/AI/camera.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Widgets/DeleteAccount.dart';
import 'package:roshetta/Widgets/EditAccount.dart';
import 'package:roshetta/Widgets/ExitAccount.dart';
import 'package:roshetta/Widgets/Widgets.dart';
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
              backgroundColor:Pallet().background_R,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(0xFF33CFE8),
                title: Widgets().screenTitle('الصفحة الرئيسية للصيدلي',Pallet().white_R)
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Widgets().profilePicture(FirebaseAuth.instance.currentUser.uid, pharmacy.profileImage),
                    Container(
                      alignment: Alignment.center,
                      child: Widgets().arabicText(
                          text:'مرحبا بك ${pharmacy.firstName}',
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
                        EditAccount(pharmacy),
                        SizedBox(height: Spaces().mediumSize,),
                        ExitAccount(),
                        SizedBox(height: Spaces().mediumSize,),
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
