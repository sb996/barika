import 'dart:async';
import 'dart:convert';
import 'package:barika_web/regims/regimList.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class mainRegim extends StatefulWidget {
  final back;
  @override
  mainRegim({Key key,this.back}) : super(key: key);

  @override
  State<StatefulWidget> createState() => mainRegimState();
}

class mainRegimState extends  State<mainRegim>
with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<mainRegim> {
@override
bool get wantKeepAlive => true;


List<String> images=[
    "assets/images/reduse.png",
    "assets/images/increas.png",
    "assets/images/keep.png",
    "assets/images/pregnancy.png",
    "assets/images/milk.png",
    "assets/images/child.png",
    "assets/images/activity.png",
    "assets/images/vegetables.png",
  ];
  List<String> names=[ 'کاهش وزن','افزایش وزن','حفظ وزن', 'بارداری ','شیردهی','کودکان و نوزادان','ورزشکاری','گیاهخواری',];
  List<String>values=["weight_loss",  "weight_gain", "weight_fix",  "pregnancy","lactation","children", "athletes",  "vegetarian",];
  @override
  void initState() {
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

    return Scaffold(
        backgroundColor: Color(0xffF5FAF2),
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 8,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.green,
          title: Text("برنامه غذایی",style: TextStyle(
              color: Colors.white,
            fontSize: 16*fontvar,
            fontWeight: FontWeight.w600,
          ),),
          actions: <Widget>[
            widget.back!=null?   Padding(padding: EdgeInsets.only(top: 4),child:     IconButton(
            icon: Icon(
              Icons.chevron_right,
              size: 32*(screenSize.width)/375,
              textDirection: TextDirection.rtl,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            alignment: Alignment.topLeft,
            color: Colors.white,
            splashColor: Colors.amber,
            padding: EdgeInsets.all(7),
          )):Container()
        ],
        ),
        body: new ListView.builder(
                    itemCount:names.length,
                     padding: EdgeInsets.only(top: 28,right: 10,left: 10),
                    itemBuilder: (context, index) {
                   return regimItem(index);
                              }));



  }

  Widget regimItem(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child:GestureDetector(
        onTap: (){
          Navigator.push(
          context,
          MaterialPageRoute(

            builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: regimList(
                  type: values[index],)),
          ),
        );
        },
        child:   Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Image.asset(images[index],fit: BoxFit.fitWidth,width: MediaQuery.of(context).size.width ,),
            Padding(padding: EdgeInsets.only(right: 12,bottom: 12),
              child: Text(names[index],style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize:30*fontvar,
                  color: Colors.white
              ),),
            )
          ],
        ),
      )
//


    );}}

