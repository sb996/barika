
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final validator;
  final keyboardtype;
  final TextEditingController controller;

  InputFieldArea({this.hint  , this.validator,this.keyboardtype,this.controller});


  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar=(bh)/3.75;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child:  TextFormField(

        controller: controller,
        keyboardType: keyboardtype,
        validator: validator,
        style:   TextStyle(color: Color(0xff51565F) , fontSize: 14*fontvar,fontWeight: FontWeight.w400),
        decoration: new InputDecoration(
          enabledBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                  color: Color(0xffD5D5D5),
                width: 1
              ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                  color: Color(0xff6DC07B),
                  width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          errorBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                  color: Color(0xffED0A0A),
                  width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffED0A0A),
                    width: 1
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          hintText: hint,
          hintStyle:  TextStyle(color: Colors.grey , fontSize: 14*fontvar,fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.only(
            top: 10 , right: 5 , bottom: 10 , left: 5
          )
        ),
      ),
    );
  }

}