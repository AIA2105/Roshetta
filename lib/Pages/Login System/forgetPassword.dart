import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/LoginButton.dart';
import 'package:roshetta/Widgets/Widgets.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Pallet().blue_R,
              size: Spaces().backButton,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().arabicText(
              text: 'نسيت كلمة السر',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R)),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      'images/forget.png',
                      height: 200,
                      width: 300,
                    ),
                  ),
                  InputField_R(
                      title: Widgets().arabicText(
                          text: 'البريد الإلكتروني',
                          fontSize: Spaces().smallSize,
                          color: Pallet().blue_R),
                      icon: Widgets().inputFieldPrefix(Icons.alternate_email),
                      textEditingController: _emailcontroller,
                      textInputType: TextInputType.emailAddress,
                      secure: false),

                  Expanded(child: SizedBox(height: 20,)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5,bottom: 50),
                    child: ButtonTheme(
                      minWidth: double.maxFinite,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xFF33CFE8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'طلب تغيير',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'arabic',
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () async {LoginButton().Reset(context, _emailcontroller.text);},
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
