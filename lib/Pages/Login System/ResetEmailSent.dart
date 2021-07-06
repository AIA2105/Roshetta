import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Pages/Login%20System/LoginScreen.dart';
import 'package:roshetta/Widgets/Widgets.dart';

class ResetEmailSent extends StatefulWidget {
  const ResetEmailSent({Key key}) : super(key: key);

  @override
  _ResetEmailSentState createState() => _ResetEmailSentState();
}

class _ResetEmailSentState extends State<ResetEmailSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet().background_R,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      'images/checked.png',
                      height: 200,
                      width: 300,
                    ),
                  ),
                  Widgets().arabicText(
                      text: 'تم ارسال ايميل التأكيد بنجاح!',
                      fontSize: Spaces().mediumSize,
                      color: Pallet().red_R),
                  Expanded(
                      child: SizedBox(
                    height: Spaces().mediumSize,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xFF33CFE8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Widgets().arabicText(
                              text: 'العودة الى الصفحة الرئيسية',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().white_R
                          ),

                        ),
                        onPressed: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
