import 'package:barika_web/bottomMenu/waterDialog.dart';
import 'package:barika_web/bottomMenu/weightDialog.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class btmMain extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => btmMainState();
}

class btmMainState extends State<btmMain> {
  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4= GlobalKey();
  GlobalKey keyButton5= GlobalKey();
  @override
  void initState() {
    initTargets();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    // TODO: implement initState
    super.initState();
  }
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
    return  WillPopScope(child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.65), //
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
        GestureDetector(

        child:
        Container(
              width: screenSize.width,
              height: screenSize.height,
            color: Colors.transparent,

            ),  onTap:(){ Navigator.pop(context, 'yes');}
    ),


            Container(
              margin: EdgeInsets.only(bottom: 30*(screenSize.width)/375,),
              alignment: Alignment.bottomCenter,
              child: new RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context, 'yes');
                },
                child: new Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 30.0*(screenSize.width)/375,
                ),
                shape: new CircleBorder(),
                elevation: 2.0,
                fillColor: MyColors.green,
                padding:  EdgeInsets.all(15.0*(screenSize.width)/375),
              ),
            ),
            Container(

              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: (30.0*(screenSize.width)/375)+45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RawMaterialButton(
                    key: keyButton1,
                    onPressed: () async {
                      String g= await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                                padding: EdgeInsets.all(0),
                                child: Dialog(
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    child: waterDialog()));
                          });

                      if(g!=null)    Navigator.pop(context, 'yes');
                    },
                    child:
                     Image.asset(
                      'assets/icons/water.png',
                      color: Colors.white,
                    height:(30.0*(screenSize.width)/375) ,
                    width: (30.0*(screenSize.width)/375) ,
                    ),

                    shape: new CircleBorder(),

                    elevation: 2.0,
                    fillColor: MyColors.aab,
                    padding: EdgeInsets.all(15.0*(screenSize.width)/375),
                  ),
                  SizedBox(
                    width: 90*(screenSize.width)/375,
                  ),
                  RawMaterialButton(
                    key: keyButton5,
                    onPressed: () {

                      Navigator.of(context).pushReplacementNamed('/sports');

                    },
                    child:Image.asset(
                      'assets/icons/sport.png',
                      height:(30.0*(screenSize.width)/375) ,
                      width: (30.0*(screenSize.width)/375) ,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Color(0xffFFB13B),
                    padding:  EdgeInsets.all(15.0*(screenSize.width)/375),
                  ),
                ],
              ),
            ),
            Container(

              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 2*(30.0*(screenSize.width)/375)+80),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RawMaterialButton(
                    key: keyButton2,
                    onPressed: () async {

                      String g=await  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                                padding: EdgeInsets.all(0),
                                child: Dialog(
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    child: weightDialog()));
                          });

                      if(g!=null)    Navigator.pop(context, 'yes');
                    },
                    child: Image.asset(
                      'assets/icons/vazn.png',
                      height:(30.0*(screenSize.width)/375) ,
                      width: (30.0*(screenSize.width)/375) ,
                      color: Colors.white,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Color(0xffD124FC),
                    padding:  EdgeInsets.all(15.0*(screenSize.width)/375),
                  ),
                  SizedBox(
                    width: 30*(screenSize.width)/375,
                  ),
                  RawMaterialButton(
                    key: keyButton4,
                    onPressed: () {
//                      Navigator.pop(context, 'yes');
                      Navigator.of(context).pushReplacementNamed('/foods');
                    },
                    child: Image.asset(
                      'assets/icons/restaurant.png',
                      color: Colors.white,
                      height:(30.0*(screenSize.width)/375) ,
                      width: (30.0*(screenSize.width)/375) ,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: MyColors.ghaza,
                    padding:  EdgeInsets.all(15.0*(screenSize.width)/375),
                  ),
                ],
              ),
            ),
            Container(

              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 3*(30.0*(screenSize.width)/375)+100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    key: keyButton3,
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           Directionality(
                      //               textDirection: TextDirection.rtl,
                      //               child:mainRegim(back: "yes",)
                      //
                      // )));
                    },
                    child: Image.asset(
                      'assets/icons/check.png',
                      color: Colors.white,
                      height:(30.0*(screenSize.width)/375) ,
                      width: (30.0*(screenSize.width)/375) ,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Color(0xffF15A23),
                    padding:  EdgeInsets.all(15.0*(screenSize.width)/375),
                  ),

                ],
              ),
            )
          ],
        ),


    ),
        onWillPop: (){ Navigator.pop(context, 'yes');}

    );
  }
  void initTargets() {
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton1,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "با زدن این دکمه می تونی مقدار آبی رو که خوردی وارد کنی.",
                    style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl,
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "با زدن این دکمه می تونی وزن جدیدت رو وارد کالری شمار کنی.",
                    style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl,
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton3,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "با زدن این دکمه می تونی وارد بخش رژیم های آنلاین بشی و به صورت کاملا علمی و کاربردی انواع رژیم های کاهش وزن، افزایش وزن، حفظ وزن، بارداری، شیردهی، کودکان، ورزشکاری و گیاهخواری رو به صورت کاملا اختصاصی درخواست بدی.",
                    style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl,
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));
    targets.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton4,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "با زدن این دکمه می تونی هر غذایی که خوردی به کالری شمار وارد کنی.",
                    style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));
    targets.add(TargetFocus(
      identify: "Target 5",
      keyTarget: keyButton5,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "با زدن این دکمه می تونی هر ورزش یا فعالیتی که داشتی وارد کنی.",
                    style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl,
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));


  }
  void showTutorial() {
    TutorialCoachMark(context,
        targets: targets,
        colorShadow:MyColors.green,
        textSkip: "بستن",
        paddingFocus: 10,
        opacityShadow: 0.9,
       )
      ..show();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 500), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringCoach=prefs.getString('coach');
      if(stringCoach!=null) {
        List<String> arrayCoach = stringCoach.split("#");
        if (arrayCoach[7] == "0") {
          showTutorial();
          arrayCoach[7] = "1";
          String stringCoachSave = "";
          for (int i = 0; i < arrayCoach.length; i++) {
            if (i != 0)
              stringCoachSave = stringCoachSave + ("#");
            stringCoachSave = stringCoachSave + arrayCoach[i];
          }
          await prefs.setString('coach', stringCoachSave);
        }
      }
    });
  }

}

