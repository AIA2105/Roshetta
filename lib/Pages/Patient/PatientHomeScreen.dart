
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/AI/camera.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Patient/PatientDatabase.dart';
import 'package:roshetta/Widgets/EditAccount.dart';
import 'package:roshetta/Widgets/ExitAccount.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'Patient.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key key}) : super(key: key);

  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  Patient patient;


  Future<String> downloadData()async{
    patient= await PatientDatabase().get(FirebaseAuth.instance.currentUser.uid);
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
                backgroundColor: Pallet().blue_R,
                title: Widgets().screenTitle('الصفحة الرئيسية للمريض',Pallet().white_R)
              ),
              body: Center(
                child: Text('HI !')
              ),
              drawer: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(180)),
                child: Drawer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 100,),
                        EditAccount(FirebaseAuth.instance.currentUser.uid ,patient.profileImage, patient),
                        Widgets().arabicText(
                            text:'${patient.firstName} ${patient.lastName}',
                            fontSize:Spaces().bigTitleSize,
                            color: Pallet().red_R,
                            textDirection: TextDirection.rtl
                        ),
                        SizedBox(height: 100,),

                        Expanded(child:Container()),
                        /////////////////////////

                        ExitAccount(),
                      ],
                    )),
              ),
            );  // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );


  }
}
