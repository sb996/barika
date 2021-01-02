import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;
//conditional import
import 'package:barika_web/UiFake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:barika_web/models/user.dart';
import 'package:barika_web/regims/pishFactor.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import '../helper.dart';
class LoginScreen extends StatefulWidget {

  User user;
  String selfId;
  String type;
  String uid;
  String url;
  String metype;
  String dietId;
  bool edit;
  int counter;
  LoginScreen({Key key,this.type,this.uid,this.url,this.user,this.metype,this.selfId,this.dietId,this.edit,this.counter}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  User _user;
  int counter;
  String type;
  String uid;
  String selfId;
  String token;
  String baseUrl;

  String randId="";
  @override
  void initState() {
    _user=widget.user;
    selfId=widget.selfId;
    uid=widget.uid;
    type=widget.type;

    randId=generateRandomString(3);
    baseUrl="https://api2.barikaapp.com/api/v3/diets/${dietName(type)}/$uid?"
        "user_name=${_user.name}&"
        "user_height=${_user.height}&"
        "user_weight=${_user.weight}&"
        "user_birthdate=${_user.birthdate}&"
        "user_sex=${_user.gender}&"
        "user_appetite=${_user.appetite}&"
        "user_activity=${_user.activity}";



    String loginUrl = widget.url != null
        ? widget.url
        : widget.dietId != null
        ? widget.selfId == null
        ? baseUrl+"&dietId=${widget.dietId}"
        : baseUrl+"&dietId=${widget.dietId}&selfId=${widget.selfId}"
        : widget.selfId == null
        ? baseUrl
        : baseUrl+"&selfId=${widget.selfId}";


print(loginUrl);

    ui.platformViewRegistry.registerViewFactory(randId, (int viewId) {
      element = IFrameElement();
      counter=widget.counter;

      element.onLoad.forEach((elementtt) async {
        print(elementtt.path.length);
        print(elementtt.eventPhase);
        print(elementtt.isTrusted);

       MessageEvent messageEvent= await  window.onMessage.first;

        print('E: ${messageEvent.data}');
       if(messageEvent.data.toString().isNotEmpty){
         counter++;
        print(" counter"+ counter.toString());
       }






        if(type=="children2-3"){
          if (counter ==1) {
            element.remove();
            mpop();
          }
        }else  if (counter == 2){
          element.remove();
          mpop();
        }


      }
      );

      element.onReset.forEach((elementtt) async {

      }
      );
      element.onChange.forEach((elementtt) async {
        print(elementtt.type);
        print(element.name);


      }
      );
      element.onAbort.forEach((elementtt) async {
        print(elementtt.type);
        print(element.name);
      }  );
      element.onWaiting.forEach((elementtt) async {
        print(elementtt.type);
        print(element.name);});


      // element.requestFullscreen();
      element.src =loginUrl;
      element.style.border = 'none';
      return element;
    });

    super.initState();

  }
  IFrameElement element;
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  void dispose() {

    // element.remove();
    // TODO: implement dispose
    super.dispose();
  }
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);




    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(30 * (screenSize.width) / 375),
        //     child: Container(
        //       color: MyColors.green,
        //       padding: EdgeInsets.only(top: 20 * (screenSize.width) / 375),
        //       child: IconButton(
        //         icon: Icon(
        //           Icons.chevron_right,
        //           size: 32 * (screenSize.width) / 375,
        //         ),
        //         onPressed: () {
        //           Navigator.pop(context, 'yes');
        //         },
        //         alignment: Alignment.topLeft,
        //         color: Colors.white,
        //         splashColor: Colors.amber,
        //         padding: EdgeInsets.all(7),
        //       ),
        //     )
        // ),

        body: Builder(builder: (BuildContext context) {
          return
         HtmlElementView(
              key: UniqueKey(),
              viewType: randId,
            );

        }));
  }

  void mpop() {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Directionality(
                textDirection: TextDirection
                // .rtl, child: FirstPayment(userid: uid,diet:widget.metype ,amount:amount ,name: type,id: widget.user,)),
                    .rtl,
                child: pishFactor(
                  uidDiet: widget.uid,
                  dietId:  widget.dietId,
                  dietType: widget.metype,
                  diet: widget.metype,
                  edit: widget.edit,)),
      ),
    );
  }}


