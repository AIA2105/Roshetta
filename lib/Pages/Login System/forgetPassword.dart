import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';
import 'package:roshetta/Constants/Strings.dart';
import 'package:roshetta/Widgets/InputField_R.dart';
import 'package:roshetta/Widgets/AccountButtons.dart';
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
            icon: Widgets().backArrowIcon(),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('نسيت كلمة السر',Pallet().blue_R)
      ),
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

                  Expanded(child: SizedBox(height: Spaces().mediumSize,)),
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
                          child: Widgets().arabicText(
                              text: 'طلب تغيير',
                              fontSize: Spaces().mediumSize,
                              color: Pallet().white_R
                          ),
                        ),
                        onPressed: () async {AccountButtons().Reset(context, _emailcontroller.text);},
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
