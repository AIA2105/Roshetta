import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Links.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Widgets/Widgets.dart';
import 'DigitalPrescription.dart';


class DigitalPrescriptionDetails extends StatefulWidget {

  DigitalPrescription prescription;
  DigitalPrescriptionDetails(this.prescription);

  @override
  _DigitalPrescriptionDetailsState createState() => _DigitalPrescriptionDetailsState();
}

class _DigitalPrescriptionDetailsState extends State<DigitalPrescriptionDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Pallet().background_R,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Pallet().blue_R,
          title: Widgets().screenTitle(widget.prescription.prescriptionDate,Pallet().white_R)
      ),
      body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50,top: 50),
          children:[

            Widgets().arabicText(
              text: 'التشخيص',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R,
            ),

            Card(
              margin:EdgeInsets.symmetric(vertical: 10) ,
              elevation: 0,
              color: Pallet().white_R,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Widgets().arabicText(
                    text: '${widget.prescription.prescriptionClassification}',
                    fontSize: Spaces().bigTitleSize,
                    color: Pallet().red_R,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Widgets().arabicText(
              text: 'الروشتة',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R,
            ),

            Card(
              elevation: 0,
              margin:EdgeInsets.symmetric(vertical: 10) ,
              color: Pallet().white_R,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Widgets().arabicText(
                    text: '${widget.prescription.prescriptionRX}',
                    fontSize: Spaces().bigTitleSize,
                    color: Pallet().red_R,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
                margin:EdgeInsets.symmetric(vertical: 50) ,
                color: Pallet().blue_R,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 50,
                              backgroundColor:
                              Pallet().white_R,
                              child: ClipOval(
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: Image.network(
                                      '${Links().profileImage}/${widget.prescription.doctorId}/${widget.prescription.doctorProfileImage}',
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
                                  ))),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Widgets().arabicText(
                                  text: 'دكتور/ ${widget.prescription.doctorFirstName} ${widget.prescription.doctorLastName}',
                                  fontSize: Spaces().bigTitleSize,
                                  color: Pallet().white_R,
                                ),
                                Widgets().arabicText(
                                  text: 'تخصص/ ${widget.prescription.doctorMaster}',
                                  fontSize: Spaces().mediumSize,
                                  color: Pallet().white_R,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20,),
                      Widgets().arabicText(
                        text: '${widget.prescription.doctorPhoneNumber}',
                        fontSize: Spaces().mediumSize,
                        color: Pallet().white_R,
                      ),
                      Widgets().arabicText(
                        text: ' ${widget.prescription.doctorEmail}',
                        fontSize: Spaces().mediumSize,
                        color: Pallet().white_R,
                      ),


                    ],
                  ),
                )

            ),

          ]
      ),
    );





  }
}
