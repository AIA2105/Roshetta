
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/AI/camera.dart';
import '../Constants/Spaces.dart';
import '../Widgets/Widgets.dart';


class AIResultScreen extends StatefulWidget {
  final String result;

  AIResultScreen({Key key, @required this.result}) : super(key: key);
  @override
  _AIResultScreenState createState() => _AIResultScreenState();
}

class _AIResultScreenState extends State<AIResultScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar:  AppBar(
          leading: IconButton(
            icon: Widgets().backArrowIcon(Pallet().blue_R),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Pallet().background_R,
          title: Widgets().screenTitle('نتيجة التحليل',Pallet().blue_R)
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30,top: 30,left: 15,right: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Pallet().white_R, width: 1),
                        borderRadius: BorderRadius.circular(Spaces().mediumSize),
                      ),
                      elevation: 10,
                      color: Pallet().white_R,
                      child: ListView(
                        children: [
                          Center(
                            child: Widgets().arabicText(
                              text: widget.result,
                              fontSize: 48,
                              color: Pallet().red_R,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              )
          ),

            Container(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () async{
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Camera()));
                  },
                  child: Widgets().arabicText(
                      text: 'رجوع',
                      fontSize:Spaces().bigTitleSize,
                      color: Pallet().white_R
                  ),

                  color: Pallet().red_R,
                  padding: EdgeInsets.all(15),
                )
            ),
        ],
      ),
    );
  }
}
