import 'dart:async';

import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LanguageScreenState();
}

class LanguageScreenState extends State<LanguageScreen> {
//  startTime() {
//    // var _duration = new Duration(seconds: 5);
//    //  return new Timer(_duration , navigationPage );
//  }
//
//  navigationPage() {
//    Navigator.of(context).pushNamed('/main');
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    startTime();
  }

  var loginColor = Color(0xffF15A23);
  var signupColor = Color(0xFF6DC07B);
  var textColor = Color(0xff51565F);

  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return new Scaffold(
      backgroundColor: signupColor,
        body: new Stack(
          alignment: AlignmentDirectional.bottomCenter,
      fit: StackFit.expand,
      children: <Widget>[

        Container(

          child:    Image.asset('assets/images/bg_intro.png',
            color: Colors.white,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
            height: screenSize.height/3,

          ),
        ),
         Center(child: Image.asset('assets/images/logo.png',
          width: 150*(screenSize.width)/375,
          height: 180*(screenSize.width)/375,
          fit: BoxFit.contain,)),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                            color: signupColor,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');},
                            elevation: 12,
                            child: Text(
                              'ثبت نام',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14*fontvar),
                            )),
                      )),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          color: loginColor,
                          onPressed: () {    Navigator.of(context).pushNamed('/login');},
                          elevation: 12,
                          child: Text(
                            'ورود',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14*fontvar),
                          )),
                    ),
                  ),

                ],
              ),
            ),
//            Container(
//              margin: EdgeInsets.symmetric(horizontal: 10),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
////                  Container(
////
////                      child: FlatButton(
////
////                        onPressed: () {},
////                        padding: EdgeInsets.all(0),
////                        child: Text(
////                          'English',
////                          style: TextStyle(
////                              fontSize: 14,
////                              color: textColor,
////                              fontWeight: FontWeight.w400),
////                        ),
////
////                      )),
////
////                 Container(
////
////                      child: FlatButton(
////
////                        onPressed: () {},
////                        padding: EdgeInsets.all(0),
////                        child: Text(
////                          'عربی',
////                          style: TextStyle(
////                              fontSize: 14,
////                              color: textColor,
////                              fontWeight: FontWeight.w400),
////                        ),
////                      ),
////                    ),
////
//
//
//                  Container(
//
//                    child: FlatButton(
//                      onPressed: () {},
//                      padding: EdgeInsets.all(0),
//                      splashColor: Colors.teal,
//                      child: Text(
//                        'فارسی',
//                        style: TextStyle(
//                            fontSize: 14,
//                            color: textColor,
//                            fontWeight: FontWeight.w400),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            )
          ],
        )
      ],
    ));
  }
}
