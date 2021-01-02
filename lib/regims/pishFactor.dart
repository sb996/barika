import 'dart:async';
import 'dart:convert';
import 'dart:math';


import 'dart:ui';
import 'package:barika_web/home/questionnaire.dart';
import 'package:barika_web/models/formInfo.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/profile/editprofileScreen.dart';
import 'package:barika_web/profile/profileScreen.dart';
import 'package:barika_web/regims/regimList.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/store/forignFator.dart';
import 'package:barika_web/test_state_builder/diet_store.dart';
import 'package:barika_web/utils/DeepLinksUtil.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';


import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper.dart';

class pishFactor extends StatefulWidget {
  String dietType;
  String diet;
  String returnVal;
  String uidDiet;
  String dietId;
  bool edit;
  pishFactor({this.dietType,this.diet,this.returnVal,this.edit,this.uidDiet,this.dietId});

  @override
  State<StatefulWidget> createState() => pishFactorState();
}

class pishFactorState extends State<pishFactor> with WidgetsBindingObserver {
  String _discount = "";
  String _disAmount = "";
  String _value1 = "";
  String _code = "";
  String _apkType="";
  String selfId="";
  bool showLoading2=false;
  String _activity;
  String _appetite;
  bool showLoading = false;
  bool _isloading = true;
  List<formInfo> _formList = [];
  String _country = "";
  List<String>_nots=[];
  User _user;
  String _price;
  String dietType;
  String birthdate;
  int time = 0;
  String diet;
  final formatter = new intl.NumberFormat("###,###");
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {

    // getContry();
    _country="98";
    getFactor();
    dietType = widget.dietType;
    print(dietType);
    print("dietType");
    diet=widget.diet;
    if(diet=="keep") diet="weight_fix";
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Widget loadingView() {
    return Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));
  }

  var fontvar = 1.0;
  Size screenSize =Size(300, 300);
  @override
  Widget build(BuildContext context) {
    // getFactor();
    print(selfId.toString());
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;
    screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffF5FAF2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 85,
          title: Text(
            'تایید اطلاعات و پرداخت',
            style: TextStyle(
                fontSize: 14 * fontvar,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_right,
                size: 32 * (screenSize.width) / 375,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              alignment: Alignment.topLeft,
              color: Colors.white,
              splashColor: Colors.amber,
              padding: EdgeInsets.all(7),
            ),
          ],
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: MyColors.green),
          ),
        ),
        body: _isloading
            ? loadingView()
            : CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xff6DC07B),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "اطلاعات پروفایل",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14 * fontvar,
                                  fontWeight: FontWeight.w500),
                            )
                          // width: 100*(screenSize.width)/375,
                          // height: 50*(screenSize.width)/375,

                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff6DC07B), width: 1),
                            color: Color(0xffF2F2F2).withOpacity(.34),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              userItem("نام کاربر", _user.name),
                              userItem("نوع رژیم درخواستی",
                                  dietNameSelector(_user.dietType)),
                              userItem("تاریخ تولد", birthdate ?? ""),
                              userItem("قد", _user.height+" سانتی متر"),
                              userItem("وزن", _user.weight+" کیلوگرم"),
                              calculateAge(_user.birthdate) >= 3
                                  ? userItem("فعالیت", _activity)
                                  : Container(
                                width: 0,
                                height: 0,
                              ),
                              calculateAge(_user.birthdate) >= 3
                                  ? userItem("اشتها", _appetite)
                                  : Container(
                                width: 0,
                                height: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  calculateAge(_user.birthdate) >= 3? Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xff6DC07B),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "اطلاعات پرسشنامه",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14 * fontvar,
                                  fontWeight: FontWeight.w500),
                            )
                          // width: 100*(screenSize.width)/375,
                          // height: 50*(screenSize.width)/375,

                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff6DC07B), width: 1),
                            color: Color(0xffF2F2F2).withOpacity(.34),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: formItems()),
                        ),
                      ],
                    ),
                  ):Container(width: 0,height: 0,),
                  Container(
                    margin: EdgeInsets.only(
                        right: 30, left: 30, top: 23),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "مبلغ فاکتور",
                            style: TextStyle(
                                fontSize: 18 * fontvar,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5C5C5C)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xff6DC07B).withOpacity(0.21),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _price??"",
                                    style: TextStyle(
                                        color: Color(0xff5C5C5C),
                                        fontSize: 26 * fontvar,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    _country == "98" ? " تومان" : "  یورو ",
                                    style: TextStyle(
                                        color: Color(0xff5C5C5C),
                                        fontSize: 16 * fontvar,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            // width: 100*(screenSize.width)/375,
                            // height: 50*(screenSize.width)/375,

                          ),
                        )
                      ],
                    ),
                  ),
                  _apkType == "bazaar"
                      ? Container(
                    height: 50,
                    width: 0,
                  )
                      :         Container(
                    height: 50 * (screenSize.width) / 375,
                    margin: EdgeInsets.only(
                        right: 30, left: 30, top: 23, bottom: 17),
                    child: TextFormField(
                      onChanged: (String val) {
                        setState(() {
                          _code = val;
                        });
                      },
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Color(0xff5c5c5c),
                          fontSize: 14 * fontvar,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          suffixIcon: Container(
                            alignment: Alignment.centerLeft,
                            width: 50 * (screenSize.width) / 375,
                            height: 50 * (screenSize.width) / 375,
                            child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 50 * (screenSize.width) / 375,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10),
                                            right: Radius.circular(0)),
                                        color: time == 0
                                            ? Color(0xff6DC07B)
                                            : Colors.red,
                                      ),
                                      child: Text(
                                        time == 0 ? 'اعمال' : "لغو",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12 * fontvar,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onTap: ()async {
                                      time == 0 ? await discount() : cansel();
                                    },
                                  ),
                                  (showLoading)
                                      ? SpinKitCircle(
                                    color: Colors.white,
                                    size: 20 * (screenSize.width) / 375,
                                  )
                                      : Container(width: 0, height: 0),
                                ]),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/gift.png',
                              height: 10 * (screenSize.width) / 375,
                              width: 10 * (screenSize.width) / 375,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          hintText:
                          'در صورت داشتن کد تخفیف آن را وارد و سپس پرداخت کنید',
                          hintStyle: TextStyle(
                              color: Color(0xff828282),
                              fontSize: 11 * fontvar,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.only(
                              top: 10, right: 8, bottom: 10, left: 8)),
                    ),
                  ),

                  Column(
                      children: notesWidget()
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         height: 9 * (screenSize.width) / 375,
                  //         width: 9 * (screenSize.width) / 375,
                  //         margin: EdgeInsets.only(left: 8),
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF15A23),
                  //           shape: BoxShape.circle
                  //         ),
                  //       ),
                  //    Expanded(
                  //      child:    Text("کاربر گرامی لطفا در وارد کردن اطلاعات دقت کنید، بعد از تایید اطلاعات، امکان ویرایش وجود ندارد.",
                  //        style: TextStyle(
                  //            color: Color(0xff5C5C5C),
                  //            fontWeight:FontWeight.w500 ,
                  //            fontSize:12*fontvar
                  //        ),
                  //      ),
                  //    )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         height: 9 * (screenSize.width) / 375,
                  //         width: 9 * (screenSize.width) / 375,
                  //         margin: EdgeInsets.only(left: 8),
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF15A23),
                  //           shape: BoxShape.circle
                  //         ),
                  //       ),
                  //    Expanded(
                  //      child:    Text("مدت زمان رژیم غذایی 14 روز می باشد.",
                  //        style: TextStyle(
                  //            color: Color(0xff5C5C5C),
                  //            fontWeight:FontWeight.w500 ,
                  //            fontSize:12*fontvar
                  //        ),
                  //      ),
                  //    )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         height: 9 * (screenSize.width) / 375,
                  //         width: 9 * (screenSize.width) / 375,
                  //         margin: EdgeInsets.only(left: 8),
                  //         decoration: BoxDecoration(
                  //           color: Color(0xffF15A23),
                  //           shape: BoxShape.circle
                  //         ),
                  //       ),
                  //    Expanded(
                  //      child:    Text("از این تاریخ ۱۴ روز اشتراک رایگان استفاده از کالری شمار باریکا بعنوان هدیه دریافت خواهید کرد.",
                  //        style: TextStyle(
                  //            color: Color(0xff5C5C5C),
                  //            fontWeight:FontWeight.w500 ,
                  //            fontSize:12*fontvar
                  //        ),
                  //      ),
                  //    )
                  //     ],
                  //   ),
                  // ),
                  //

                  Container(

                    margin: EdgeInsets.symmetric(vertical: 17, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Expanded(child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[ FlatButton(

                                color: Color(0xff6DC07B),

                                height: 55* (screenSize.width) / 375,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                disabledColor: Color(0xff6DC07B).withOpacity(0.5),
                                onPressed:showLoading2?null: () async {
                                  setState(() {
                                    showLoading2=true;
                                  });
                                  await payMethod();
                                },
                                child: Text(
                                  'تایید و پرداخت اینترنتی',
                                  style: TextStyle(
                                      color:Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14*fontvar),
                                  textAlign: TextAlign.center,
                                )),
                              (showLoading2)?
                              SpinKitCircle(
                                color: Colors.white,
                                size: 20*(screenSize.width)/375,
                              ):Container(width:0,height:0),
                            ])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: FlatButton(
                            height: 55* (screenSize.width) / 375,
                            shape: RoundedRectangleBorder(
                              borderRadius:  BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            color: Color(0xffFA8668),
                            onPressed: () async {

                              if(widget.edit==null){
                                await Navigator
                                    .push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: profileScreen(
                                          regim: _user.dietType,
                                          userSend: _user,
                                          selfId:selfId ,


                                        )),
                                  ),
                                );}
                              else{
                                await Navigator
                                    .push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: editprofileScreen(
                                            regim: _user.dietType,
                                            userSend: _user,
                                            dietId:widget.dietId,
                                            selfId:selfId ,
                                            // regimId:widget.regimId,


                                          )),
                                    ));
                              }
                            },
                            child: Text(
                              'ویرایش اطلاعات',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14*fontvar),  textAlign: TextAlign.center,
                            )),)

                      ],


                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  )
                ]))
          ],
        ));
  }

  Future<void> getFactor() async {
    _nots=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    print(dietType);
    print(dietType);
    print(widget.uidDiet);
    // print(dietType);
    _formList = [];
    try {
      print("response.bodyString");
      final response = await Provider.of<apiServices>(context, listen: false)
          .getFactor(dietType, 'Bearer ' + apiToken);

      print(response.bodyString);
      print(response.error);

      if (response.statusCode == 200) {
        final post = json.decode(response.bodyString);

        setState(() {
          _user = User.fromJson4(post["userInfo"]);
          print(_user.toMap4());
          var persianDateee = PersianDateTime.fromGregorian(
              gregorianDateTime: _user.birthdate ?? '1996-09-17');
          var pbirthDate = persianDateee.toJalaali(format: 'YYYY-MM-DD');
          birthdate = pbirthDate.toString();
          List valList = post["formInfo"];
          List nots = post["notes"];

          nots.forEach((element) {
            print(element.toString());
            _nots.add(element.toString());
          });
          valList.forEach((element) {
            _formList.add(formInfo.fromJson(element));
          });

          print(_formList.length.toString());

          _price = post["price"].toString();

          _value1 = _price;

          selfId= post["dietId"].toString();

          print(_price.toString());
          getAppetite();
          getActivate();
        });
      } else {
        showSnakBar("خطا در دریافت اطلاعات");
        print(response.statusCode.toString() + "error");
      }

      setState(() {
        _isloading = false;
      });
    } catch (e) {
      showSnakBar("خطا در دریافت اطلاعات");
      print(e.toString() + "catttttch");
    }


//
  }

  Future<void> getContry() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _country = prefs.getString('country');
    });
  }

  showSnakBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2),
      backgroundColor: MyColors.vazn,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Text(
        s,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15 * fontvar,
            fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }

  userItem(String title, String detail) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title??"",
                style: TextStyle(
                    color: Color(0xff818181),
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * fontvar),
              ),
              Text(
                detail??"",
                style: TextStyle(
                    color: Color(0xff5C5C5C),
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * fontvar),
              )
            ],
          ),
        ),
        title == "اشتها"
            ? Container(
          width: 0,
          height: 0,
        )
            : Divider(
          color: Color(0xffC3CBCE),
          height: 1,
        )
      ],
    );
  }

  List<Widget> formItems() {
    List<Widget> items = [];

    for (int i = 0; i < _formList.length; i++) {
      items.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${i + 1}-",
                    style: TextStyle(
                        color: Color(0xff818181),
                        fontWeight: FontWeight.w600,
                        fontSize: 14 * fontvar),
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                      child: Text(
                        _formList[i].question,
                        style: TextStyle(
                            color: Color(0xff818181),
                            fontWeight: FontWeight.w400,
                            fontSize: 13 * fontvar),
                        textAlign: TextAlign.start,
                      ))
                ],
              )),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                _formList[i].answer,
                style: TextStyle(
                    color: Color(0xff5C5C5C),
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * fontvar),
                textAlign: TextAlign.end,
              )),
          Divider(
            color: i == _formList.length - 1
                ? Colors.transparent
                : Color(0xffC3CBCE),
            height: 1,
          )
        ],
      ));
    }
    return items;
  }

  Future<void> discount() async {
    if(_code.isEmpty){
      showSnakBar("کد تخفیف را وارد کنید.");
    }
    else {
      setState(() {
        showLoading = true;
      });
//    "status": "failed",
//    "discount": null,
//    "finalAmount": "2000"
//
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String apiToken = prefs.getString('user_token');
      try {
        final response = await Provider.of<apiServices>(context, listen: false)
            .Paydiscount(_code, _price, "diet", 'Bearer ' + apiToken);
        print(response.bodyString);

        if (response.statusCode == 200) {
          final post = json.decode(response.bodyString);

          if (post["status"] == "failed") {
            showSnakBar("کد نادرست است.");
          } else if (post["status"] == "success") {
            setState(() {
              time = 1;
              var value = post["finalAmount"];
              _price = value.toString();
              _disAmount =
              post["disAmount"] == null ? null : post["disAmount"].toString();
              _discount = post["discount"]["code"] == null
                  ? null
                  : post["discount"]["code"].toString();
            });
            showSnakBar("با موفقیت اعمال شد.");
          } else if (post["status"] == "expired") {
            showSnakBar("کد منقضی شده است.");
          } else {
            showSnakBar("خطا در دریافت اطلاعات");
            print(response.statusCode.toString() + "error");
          }
        }
      } catch (e) {
        showSnakBar("خطا در دریافت اطلاعات");
        print(e.toString() + "catttttch");
      }

      setState(() {
        showLoading = false;
      });
//}
    }}
  cansel() {
    setState(() {
      _price = _value1;
      _disAmount="";
      _discount="";
      time = 0;
    });
  }

  getActivate(){
    if(calculateAge(_user.birthdate)>=3 ){
      if(calculateAge(_user.birthdate)<=12){
        switch (_user.activity) {
          case "5":
            _activity = 'خیلی پر جنب و جوش';
            break;
          case "4":
            _activity = 'پر جنب و جوش';
            break;
          case "3":
            _activity = 'معمولی';
            break;
          case "2":
            _activity = 'کم فعالیت';
            break;
          case "1":
            _activity = 'بی فعالیت';
            break;
        }
      }
      else {
        switch (_user.activity) {
          case "5":
            _activity =   'خیلی زیاد';
            break;
          case "4":
            _activity =     'زیاد';
            break;
          case "3":
            _activity =    'متوسط';
            break;
          case "2":
            _activity =     'کم';
            break;
          case "1":
            _activity =   'بی فعالیت';
            break;
        }
      }
    }
  }
  getAppetite(){
    if(calculateAge(_user.birthdate)>=3 ){
      switch (_user.appetite) {
        case "5":
          _appetite = 'خیلی زیاد';
          break;
        case "4":
          _appetite =  'زیاد';
          break;
        case "3":
          _appetite = 'متوسط';
          break;
        case "2":
          _appetite = 'کم ';
          break;
        case "1":
          _appetite ='بی اشتها';
          break;
      }
    }

  }
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
  Future<void> payMethod() async {
    _price = "0";
    if(widget.returnVal!=null){

      if(_price!="0") {
        String orderid=  await orderID("diet",widget.uidDiet,_price,account_id: "",diet_type:"children" );
        if (_country != "98") {
          String returnUrl = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: forignFator(orderId: orderid,)),
            ),
          );


          if (returnUrl != null) {
            showDialog(

                barrierDismissible: false,
                context: context,
                builder: (_) =>WillPopScope(
                    onWillPop: () {},
                    child:  Dialog(
                      child:  Container(
                        alignment: FractionalOffset.center,
                        height: 80.0,
                        padding:  EdgeInsets.all(20.0),
                        child:  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 10.0),
                              child:  Text("منتظر بمانید"),
                            ),
                            CircularProgressIndicator(),

                          ],
                        ),
                      ),
                    )));
            if (await canLaunch(returnUrl)) {
              // await launch(returnUrl, forceSafariVC: false, enableJavaScript: true,forceWebView: true);
              Timer(Duration(seconds: 2), () async {
                print("Yeah, this line is printed after 3 seconds");
                DeepLinksUtil().initUniLinkdietChild();
                // Navigator.of(context,rootNavigator:true).pop();

//        Navigator.pop(context);
//                 getDiets();
//                 Navigator.pushReplacement(context, MaterialPageRoute(
//                   builder: (context) =>
//                       Directionality(
//                           textDirection: TextDirection
//                               .rtl,
//                           child: regimList(type: "children",)),
//                 ),);


              });
            } else {
              throw 'Could not launch';
            }
          }
        }
        else {
          showDialog(

              barrierDismissible: false,
              context: context,
              builder: (_) =>WillPopScope(
                  onWillPop: () {},
                  child:  Dialog(
                    child:  Container(
                      alignment: FractionalOffset.center,
                      height: 80.0,
                      padding:  EdgeInsets.all(20.0),
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: new EdgeInsets.only(left: 10.0),
                            child: new Text("منتظر بمانید"),
                          ),
                          CircularProgressIndicator(),

                        ],
                      ),
                    ),
                  )));
          if (await canLaunch(
              "https://api2.barikaapp.com/api/payment/request?order_id=${orderid}")) {
            await launch(
              "https://api2.barikaapp.com/api/payment/request?order_id=${orderid}",

              forceSafariVC: false,
              enableJavaScript: true,
            );
            Timer(Duration(seconds: 2), () async {
              print("Yeah, this line is printed after 3 seconds");

              Navigator.of(context,rootNavigator:true).pop();
              // new DeepLinksUtil().initUniLinkdietChild(
              //     _user.uid, widget.id, widget.returnVal, widget.type2Str,
              //     widget.logId);
//        Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) =>
                    Directionality(
                        textDirection: TextDirection
                            .rtl,
                        child: regimList(
                          // logId: widget.logId,
                          user: "male",
                          type: "children",
                          // type2: widget.type2Str,
                          type1: widget.returnVal,
                          // userr: widget.id,
                        )),
              ),

              );});
          } else {
            throw 'Could not launch';
          }
        }
      } else{
        await zpaychild();
      }
    }
    else{
      print("payDiet");



      if(_price!="0") {
        // String orderid=   await orderID("diet",widget.uidDiet,_price,account_id: "",diet_type:diet );
//         if(_country!="98"){
//           String returnUrl = await  Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   Directionality(
//                       textDirection: TextDirection.rtl, child: forignFator(orderId: orderid,)),
//             ),
//           );
//
//           if (returnUrl != null) {
//             showDialog(
//
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (_) =>WillPopScope(
//                     onWillPop: () {},
//                     child:  Dialog(
//                       child:  Container(
//                         alignment: FractionalOffset.center,
//                         height: 80.0,
//                         padding:  EdgeInsets.all(20.0),
//                         child:  Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: new EdgeInsets.only(left: 10.0),
//                               child: new Text("منتظر بمانید"),
//                             ),
//                             CircularProgressIndicator(),
//
//                           ],
//                         ),
//                       ),
//                     )));
//             if (await canLaunch(returnUrl)) {
//               await launch(returnUrl,
//
//                 forceSafariVC: false,
//                 enableJavaScript: true,
//               );
//               Timer(Duration(seconds: 2), () async {
//                 print("Yeah, this line is printed after 3 seconds");
//
//                 Navigator.of(context,rootNavigator:true).pop();
//               // DeepLinksUtil().initUniLinkdiet(_user.uid,widget.name,widget.id, diet);
// //        Navigator.pop(context);
//               Navigator.pushReplacement(context ,MaterialPageRoute(
//                 builder: (context) =>
//                     Directionality(
//                         textDirection: TextDirection
//                             .rtl, child: regimList(user: widget.id.gender,type1:widget.name , userr: widget.id,type2:diet,type:widget.name,)),
//               ),);});
//             } else {
//               throw 'Could not launch';
//             }
//           }
//         }
//         else{
//           showDialog(
//
//               barrierDismissible: false,
//               context: context,
//               builder: (_) =>WillPopScope(
//                   onWillPop: () {},
//                   child:  Dialog(
//                     child:  Container(
//                       alignment: FractionalOffset.center,
//                       height: 80.0,
//                       padding:  EdgeInsets.all(20.0),
//                       child:  Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Padding(
//                             padding: new EdgeInsets.only(left: 10.0),
//                             child: new Text("منتظر بمانید"),
//                           ),
//                           CircularProgressIndicator(),
//
//                         ],
//                       ),
//                     ),
//                   )));
//         if (await canLaunch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}")) {
//           await launch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}",
//
//             forceSafariVC: false,
//             enableJavaScript: true,
//           );
//           Timer(Duration(seconds: 2), () async {
//             print("Yeah, this line is printed after 3 seconds");
//
//             Navigator.of(context,rootNavigator:true).pop();
//           // DeepLinksUtil().initUniLinkdiet(_user.uid,widget.name,widget.id, diet);
// //        Navigator.pop(context);
//           Navigator.pushReplacement(context ,MaterialPageRoute(
//             builder: (context) =>
//                 Directionality(
//                     textDirection: TextDirection
//                         .rtl, child: regimList(user: widget.id.gender,type1:widget.name , userr: widget.id,type2:diet,type:widget.name,)),
//           ),);});
//         } else {
//           throw 'Could not launch';
//         }}
//       }

      }else{
        await zpaydiet();
      }
    }
    setState(() {
      showLoading2=false;
    });
  }
  Future<String> orderID(String type,String user_id,String amount,{String diet_type,String account_id}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');

    print(type);
    print(amount);
    print(_discount);
    print(_disAmount);
    print(user_id);
    print(account_id);
    print(diet_type);

    try{
      final response = await Provider.of<apiServices>(context,listen: false)
          .creatPay(type,amount,_discount,_disAmount,user_id,account_id,diet_type,'Bearer '+ apiToken );

      print(response.bodyString);
      if (response.statusCode == 200) {
        final  post = json.decode(response.bodyString);
        if(post["msg"]=="success") {
          return post["order"];
        }
      } else {
        print(response.statusCode.toString());

        showSnakBar("خطا اتصال به اینترنت");}
    } catch(e){
      print(e.toString());

      showSnakBar("خطا اتصال به اینترنت");
    }


  }
  Future<void> zpaychild() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      final response = await Provider.of<apiServices>(context,listen: false)
          .freeDiet(widget.uidDiet,diet,'Bearer '+ apiToken );
      if (response.statusCode == 200) {
        final  post = json.decode(response.bodyString);
        if(post["msg"]=="success"){
          getDiets();
          Navigator.pushReplacement(context ,MaterialPageRoute(
            builder: (context) =>
                Directionality(
                    textDirection: TextDirection
                        .rtl, child: regimList(type: "children",)),
          ),);
        }
      }
      else {
        print(response.statusCode.toString());
        showSnakBar("خطا اتصال به اینترنت");
      }

    }
    catch(e){
      print(e.toString());
      showSnakBar("خطا اتصال به اینترنت");
    }

  }

  Future<void> zpaydiet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      final response = await Provider.of<apiServices>(context,listen: false)
          .freeDiet(widget.uidDiet,diet,'Bearer '+ apiToken );
      print(widget.uidDiet);
      print(diet);
      if (response.statusCode == 200) {
        final  post = json.decode(response.bodyString);
        if(post["msg"]=="success"){
//
          getDiets();
          Navigator.pushReplacement(context ,MaterialPageRoute(
            builder: (context) =>
                Directionality(
                    textDirection: TextDirection
                        .rtl, child: regimList(type: diet,)),
          ),);
        }
      }
      else {
        print(response.statusCode.toString());
        showSnakBar("خطا اتصال به اینترنت");
      }

    }
    catch(e){
      print(e.toString());
      showSnakBar("خطا اتصال به اینترنت");
    }

  }




  List<Widget> notesWidget() {
    List <Widget> items=[];
    for(int i=0;i<_nots.length;i++){
      items.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 9 * (screenSize.width) / 375,
                width: 9 * (screenSize.width) / 375,
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    color: Color(0xffF15A23),
                    shape: BoxShape.circle
                ),
              ),
              Expanded(
                child:    Text(_nots[i],
                  style: TextStyle(
                      color: Color(0xff5C5C5C),
                      fontWeight:FontWeight.w500 ,
                      fontSize:12*fontvar
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return items;

  }

  void getDiets() {
    final reactiveModel = Injector.getAsReactive<dietStore>();
    reactiveModel.setState(
          (store) => store.getDiet(context),
      onError: (context, error) {
        if (error) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Couldn't fetch weather. Is the device online?"),
            ),
          );
        } else {
          throw error;
        }
      },
    );
  }

}
