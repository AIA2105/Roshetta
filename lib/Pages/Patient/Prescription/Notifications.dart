
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Patient/PatientHomeScreen.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import '../../../main.dart';
import 'DigitalPrescription.dart';
import 'PrescriptionDatabase.dart';

class Notifications extends StatefulWidget {
  int numberOfNotifications;
  Notifications(this.numberOfNotifications);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<DigitalPrescription> prescriptionList = [];

  Future<String> downloadData() async {
    prescriptionList = await PrescriptionDatabase().getDigital(FirebaseAuth.instance.currentUser.uid);
    return Future.value("Data download successfully");
    // return your response
  }




  @override
  void initState() {
    downloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: downloadData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Pallet().background_R,
            body: Center(
                child: CircularProgressIndicator(
                  color: Pallet().blue_R,
                )),
          );
        } else {
          if (snapshot.hasError)
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                label: Widgets().arabicText(
                    text: 'حدثت مشكلة اضغط لإعادة المحاولة',
                    color: Pallet().white_R,
                    fontSize: Spaces().smallestSize),
                backgroundColor: Pallet().red_R,
                onPressed: (){
                  main();
                  print(snapshot.error);
                },
                icon: Icon(Icons.refresh),
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/logo.png'),
                        Widgets().arabicText(
                            text: 'روشتة',
                            color: Pallet().red_R,
                            fontSize: Spaces().bigTitleSize),
                      ],
                    )),
              ),
            ) ;
          else {
            return Scaffold(
              backgroundColor: Pallet().background_R,
              appBar: AppBar(
                  leading: IconButton(
                      icon: Widgets().backArrowIcon(Pallet().blue_R),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>PatientHomeScreen())
                        );
                      }),
                  centerTitle: true,
                  backgroundColor: Pallet().background_R,
                  elevation: 0,
                  title: Widgets().screenTitle('الإشعارات', Pallet().blue_R)
              ),
              body: Padding(
                padding:EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 30),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return prescriptionList.length==0?Container():Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Card(
                                  elevation: 0.5,
                                  color: Pallet().background_R,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(80.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22, vertical: 10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Pallet().blue_R,
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                              Pallet().white_R,
                                              child: ClipOval(
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: Center(
                                                      child: Widgets().arabicText(
                                                        text: 'RX',
                                                        fontSize: 22,
                                                        color: Pallet().blue_R,
                                                      ),
                                                    ),
                                                  ))),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Widgets().arabicText(
                                                text: '${prescriptionList[index].doctorFirstName} ${prescriptionList[index].doctorLastName}',
                                                fontSize: Spaces().mediumSize,
                                                color: Pallet().blue_R,
                                              ),
                                              Widgets().arabicText(
                                                text: prescriptionList[index].prescriptionDate,
                                                fontSize: Spaces().mediumSize,
                                                color: Pallet().black,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: widget.numberOfNotifications),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
              floatingActionButton: widget.numberOfNotifications!=0?Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      elevation: 10,
                      onPressed: () {
                        setState(() {
                          widget.numberOfNotifications=0;
                        });
                      },
                      backgroundColor: Pallet().blue_R,
                      child: Icon(
                        Icons.clear,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ):Divider(
                color: Colors.transparent,
              ),
            );
          }
        }
      },
    );
  }
}
