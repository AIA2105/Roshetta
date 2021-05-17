import 'package:flutter/material.dart';
import 'package:roshetta/Constants/Pallet.dart';
import 'package:roshetta/Constants/Spaces.dart';

class InputField_R extends StatefulWidget {
  final Text title;
  final Icon icon;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool secure;
  final int length;
  final TextAlign textAlign;

  const InputField_R(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.textEditingController,
      @required this.textInputType,
      @required this.secure,
      this.length,
      this.textAlign})
      : super(key: key);

  @override
  _InputField_RState createState() => _InputField_RState(
      title, icon, textEditingController, textInputType, secure);
}

class _InputField_RState extends State<InputField_R> {
  Text title;
  Icon icon;
  TextEditingController textEditingController;
  TextInputType textInputType;
  bool secure;
  _InputField_RState(this.title, this.icon, this.textEditingController,
      this.textInputType, this.secure);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 15),
          width: double.maxFinite,
          child: title,
        ), //label
        TextField(
          textAlign: widget.textAlign !=null? widget.textAlign:TextAlign.left,
          maxLength: widget.length,
          cursorColor: Pallet().blue_R,
          obscureText: secure,
          style: TextStyle(fontSize: Spaces().smallSize, fontFamily: 'arabic'),
          keyboardType: textInputType,
          controller: textEditingController,
          decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.only(bottom: 8,top: 8,right: 10,left: 10),
              fillColor: Pallet().white_R,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Spaces().circularBorder),
                borderSide: BorderSide(width: 2, color: Pallet().blue_R),
              ),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(Spaces().circularBorder),
              ),
              prefixIcon: icon),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
