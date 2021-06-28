
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/AI/camera.dart';
import '../Constants/Spaces.dart';
import '../Widgets/Widgets.dart';


class AIScreen extends StatefulWidget {
  final String result;

  // receive data from the FirstScreen as a parameter
  AIScreen({Key key, @required this.result}) : super(key: key);
  @override
  _AIScreenState createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet().background_R,
      appBar:  AppBar(
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
              text: 'نتيجة التحليل',
              fontSize: Spaces().bigTitleSize,
              color: Pallet().blue_R)),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      color: Pallet().white_R,
                      child: Center(
                        child: Text(
                            widget.result,
                            style: TextStyle(
                                color: Pallet().red_R,
                                fontFamily: 'arabic',
                                fontSize: 72)
                        ),
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
                  child: Text(
                      'رجوع',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'arabic',
                          fontSize: 22)
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
