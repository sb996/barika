
import 'dart:convert';

import 'package:barika_web/helper.dart';
import 'package:barika_web/menu/unitConvertDialog.dart';
import 'package:barika_web/models/cereals.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/sqfliteProvider/cereal_provider.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class unitConvert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => unitConvertState();
}

class unitConvertState extends State<unitConvert> {

  List <cereals>_cereals = [];
  double calorie1;
  double calorie2;
  String result;
  String amount;
  bool _isLoading=true;

  Color textColor = Color(0xff555555);


  cereals _currectCereal1;
  cereals _currectCereal2;


  @override
  void initState() {
    getallCereals();


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

    return Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(100*(screenSize.width)/375),
          child: new Container(
              padding: EdgeInsets.only(top: 10*(screenSize.width)/375),
              decoration: new BoxDecoration(
                color: MyColors.green
              ),
              child: new SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 8),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Text(
                            'تبدیل واحد مواد نشاسته ای به یکدیگر',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16*fontvar,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '( انواع نان، برنج، ماكاروني و سيب زميني )',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14*fontvar,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 32*(screenSize.width)/375,
                      ),
                      onPressed: () {
                        Navigator.pop(context, 'yes');
                      },
                      alignment: Alignment.topLeft,
                      color: Colors.white,
                      splashColor: Colors.amber,
                      padding: EdgeInsets.all(7),
                    ),



                  ],
                ),
              )),
        ),

        body:
        _isLoading
            ?Center(
            child: SpinKitCircle(
              color: MyColors.vazn,
            ))
            :CustomScrollView(slivers: <Widget>[
    SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Container(
          margin: EdgeInsets.only(top: 15, right: 12, left: 12),
          child: Column(
            children: <Widget>[


              Padding(padding: EdgeInsets.only(
                top: 10,
              ),
                child: Text(
                  "غذای نشاسته ای مورد نظر را انتخاب کنید.", style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13*fontvar
                ),),),
              GestureDetector(
                child:              Container(
                  width:screenSize.width,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  margin: EdgeInsets.only(right: 12,left: 12, top: 15),
                  child:Text(_currectCereal1.name),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1,
                          color: Colors.green
                      )
                  ),
                ),

                onTap: ()async {

                  cereals returnVAl=await showDialog(context: context,
                      builder: (BuildContext context) {
                        return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 30),child:  Dialog(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.transparent,
                            child:  Directionality(textDirection: TextDirection.rtl,
                                child: unitConvertDialog(
                                  cerealsList: _cereals,
                                )

                            )
                        ));});
                  print(returnVAl);
                  if(returnVAl!=null){
                    setState(() {
                      _currectCereal1 = returnVAl;
                      calorie1 =double.parse(returnVAl.calorie);
                      if (amount != null && calorie1 != null && calorie2 != null)
                        result = (double.parse(amount)*calorie1 / calorie2).toStringAsFixed(1);
                      print(result);
                    });
                  }
                },
              ),


              Container(
                width: screenSize
                    .width/2,
                height: 52,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: TextField(
                  maxLines: 1,

                  onChanged: (String value) {
                    setState(() {
                      amount = value;
                      if (amount != null && calorie1 != null && calorie2 != null )
                        result = (double.parse(amount)*calorie1 / calorie2).toStringAsFixed(1);
                    });
                  },

                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(0),
                    border: new OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: MyColors.green, width: 1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: MyColors.green, width: 1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: MyColors.green, width: 1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    hintText: 'مقدار را وارد کنید',
                    hintStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 14*fontvar,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              Text("تبدیل شود به :", style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13*fontvar
              ),),

              GestureDetector(
                child:              Container(
                  width:screenSize.width,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  margin: EdgeInsets.only(right: 12,left: 12, top: 15),
                  child:Text(_currectCereal2.name),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1,
                          color: Colors.green
                      )
                  ),
                ),

                onTap: ()async {

                  cereals returnVAl=await showDialog(context: context,
                      builder: (BuildContext context) {
                        return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 30),child:  Dialog(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.transparent,
                            child:  Directionality(textDirection: TextDirection.rtl,
                                child: unitConvertDialog(
                                  cerealsList: _cereals,
                                )

                            )
                        ));});
                  print(returnVAl);
                  if(returnVAl!=null){
                    setState(() {
    _currectCereal2 = returnVAl;
    calorie2 =double.parse(returnVAl.calorie);
    print("_currectCereal2");
    print(_currectCereal2);
    if (amount != null && calorie1 != null && calorie2 != null )
    result = (double.parse(amount)*calorie1 / calorie2).toStringAsFixed(1);
    print(result);
    });

                  }
                },
              ),

              Text("نتیجه :", style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13*fontvar
              ),),
              Container(
                alignment: Alignment.center,
                width: screenSize
                    .width/2,
                height: 45,
                margin: EdgeInsets.only(top: 3, left: 2),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: MyColors.green, width: 1
                    )
                ),
                child: Text(
                  result ?? "",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14*fontvar,

                  ),
                ),
              ),

            ],
          ),
        )

    ]))]));
  }


  Future<bool> getallCereals() async {


    var _cerealsProvider = cerealProvider(idbFactory: idbFactoryNative);

    await _cerealsProvider.open();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    String _cerealDate=prefs.getString("date_cereal")??"";



    if(! await checkConnectionInternet() || DateTime.now().difference(DateTime.parse(_cerealDate==""?"2020-05-05":_cerealDate)).inHours<1) {
      List<cereals> list =await _cerealsProvider.getAllcereals();
      setState(() {
        _cereals=list;
        if(_cereals.isEmpty){
          print("amoooooooooo");
          _isLoading = false;
        }
        else {

          _currectCereal1 = _cereals[0];
          _currectCereal2 = _cereals[0];
          calorie1 = double.parse(_currectCereal1.calorie);
          calorie2 = double.parse(_currectCereal2.calorie);
          _isLoading = false;
        }
      });

    }

    else{
      List createdCereals=[];
      List updatedCereals=[];
      List deletedCereals=[];


      try {
        final response = await Provider.of<apiServices>(context, listen: false)
            .getCereals(_cerealDate, 'Bearer ' + apiToken);

        print("response" + response.bodyString);
        final post = json.decode(response.bodyString);
        if (response.statusCode == 200 && post["result"]=="done") {
          try {


            createdCereals = post["data"]["createdCereals"];
            updatedCereals = post["data"]["updatedCereals"];
            deletedCereals = post["data"]["deletedCereals"];


            await _cerealsProvider.saveAllcereal(createdCereals);
            await _cerealsProvider.saveAllcereal(updatedCereals);
            await _cerealsProvider.deleteAllcereal(deletedCereals);



            prefs.setString("date_cereal",getDateToday());
          }catch(e){
            print(e.toString());
          }
        } else {
          return null;
        }
      } catch (e) {
        print(e.toString() + "catttttch");
        return null;
      }
      List<cereals> list =await _cerealsProvider.getAllcereals();
      setState(() {
        _cereals=list;
        if(_cereals.isEmpty){
          print("amoooooooooo");
          _isLoading = false;
        }
        else {

          _currectCereal1 = _cereals[0];
          _currectCereal2 = _cereals[0];
          calorie1 = double.parse(_currectCereal1.calorie);
          calorie2 = double.parse(_currectCereal2.calorie);
          _isLoading = false;
        }
      });


    }

  }

}
