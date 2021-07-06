import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Pages/Doctor/Doctor.dart';
import 'package:roshetta/Pages/Doctor/EditDoctorData.dart';
import 'package:roshetta/Pages/Patient/EditPatientData.dart';
import 'package:roshetta/Pages/Patient/Patient.dart';
import 'package:roshetta/Pages/Pharmacy/EditPharmacyData.dart';
import 'package:roshetta/Pages/Pharmacy/Pharmacy.dart';

import 'Widgets.dart';



class EditAccount extends StatefulWidget {
  Object user;
  EditAccount(this.user);


  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        if(widget.user is Patient){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>EditPatientData(widget.user)));
        }else if(widget.user is Doctor){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>EditDoctorData(widget.user)));
        }else if(widget.user is Pharmacy){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>EditPharmacyData(widget.user)));
        }
      },
      child: Widgets().arabicText(
        text: 'تعديل البيانات',
        fontSize: Spaces().mediumSize,
        color: Pallet().red_R,
      ),
    );
  }
}
