import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Patient/Prescription/LocalPrescription.dart';
import 'package:roshetta/Widgets/Widgets.dart';


class LocalPrescriptionDetails extends StatefulWidget {

  LocalPrescription prescription;
  LocalPrescriptionDetails(this.prescription);

  @override
  _LocalPrescriptionDetailsState createState() => _LocalPrescriptionDetailsState();
}

class _LocalPrescriptionDetailsState extends State<LocalPrescriptionDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Pallet().background_R,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Pallet().blue_R,
          title: Widgets().screenTitle(widget.prescription.date,Pallet().white_R)
      ),
      body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50,top: 50),
          children:[
            Image.network(
              '${Links().localPrescriptionImage}/${FirebaseAuth.instance.currentUser.uid}/${widget.prescription.image}',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Pallet().blue_R,
                  ),
                );
              },
            ),

            Card(
                margin:EdgeInsets.symmetric(vertical: 50) ,
                elevation: 0,
                color: Pallet().red_R,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Widgets().arabicText(
                        text: 'دكتور/ ${widget.prescription.doctorName}',
                        fontSize: Spaces().bigTitleSize,
                        color: Pallet().white_R,
                      ),
                      Widgets().arabicText(
                        text: 'تخصص/ ${widget.prescription.master}',
                        fontSize: Spaces().mediumSize,
                        color: Pallet().white_R,
                      ),
                    ],
                  ),
                )
            )

          ]
      ),
    );





  }
}
