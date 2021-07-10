import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';

import 'Widgets.dart';

class ExitAccount extends StatefulWidget {
  const ExitAccount({Key key}) : super(key: key);

  @override
  _ExitAccountState createState() => _ExitAccountState();
}

class _ExitAccountState extends State<ExitAccount> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(right: 40,left: 30,top: 10),
              title: Text(
                'متأكد من رغبتك في الخروج؟',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Pallet().red_R,
                    fontFamily: Strings().arabicFontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: Spaces().mediumSize),
              ),
              actions: [
                FlatButton(
                  child: Widgets().arabicText(
                    text: 'الغاء العملية',
                    fontSize: 16,
                    color: Pallet().blue_R,
                  ),
                  onPressed:  (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Widgets().arabicText(
                    text: 'تسجيل الخروج',
                    fontSize: 16,
                    color: Pallet().red_R,
                  ),
                  onPressed:  () async{
                    var user= FirebaseAuth.instance.currentUser;
                    var result = await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    print('exit Account');
                  },
                ),

              ],
            );
          },
        );

      },
      leading: RotatedBox(
          quarterTurns: 2,
          child: Icon(Icons.exit_to_app,
            color: Pallet().red_R,
          )
      ),
      title: Widgets().arabicText(
        text: 'تسجيل الخروج',
        fontSize: Spaces().mediumSize,
        color: Pallet().red_R,
      ),
    );
  }
}
