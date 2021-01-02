import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/DeepLinksUtil.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper.dart';
import 'forignFator.dart';

class FirstPayment extends StatefulWidget {
  String amount;
  String userid;
  String diet;
  String acount;
  String acountname;
  String apkType;
  String sku;
  String country;

  final name;
  User id;
  final returnVal;
  final type2Str;
  final logId;

  FirstPayment(
      {this.amount,
      this.userid,
      this.diet,
      this.acount,
      this.acountname,
      this.id,
      this.name,
      this.returnVal,
      this.type2Str,
      this.logId,
      this.apkType,
      this.country,
      this.sku});

  @override
  State<StatefulWidget> createState() => FirstPaymentState();
}

class FirstPaymentState extends State<FirstPayment>
    with WidgetsBindingObserver {
  String _value = "";
  String _discount = "";
  String _country = "";
  String _disAmount = "";
  String _value1 = "";
  String _userid;
  String diet;
  String acount;
  String _code = "";
  String apkType;
  int time = 0;
  bool showLoading = false;
  bool showLoading2 = false;
  final formatter = new intl.NumberFormat("###,###");
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    apkType = widget.apkType;

    _country=widget.country;
    getContry();
    WidgetsBinding.instance.addObserver(this);
    print(widget.name);
    _value = widget.amount.toString();
    _value1 = widget.amount.toString();
    widget.userid == null ? _getUser() : _userid = widget.userid;
    diet = widget.diet;
    if (diet == "keep") diet = "weight_fix";
    acount = widget.acount;

    super.initState();
  }

  Widget loadingView() {
    return Center(
        child: SpinKitCircle(
      color: MyColors.vazn,
    ));
  }

  var fontvar = 1.0;

  @override
  Widget build(BuildContext context) {
//    print("01  "+widget.amount??"null");
//    print("01  "+widget.userid??"null");
//    print("01  "+widget.diet??"null");
//    print("01  "+widget.name??"null");
//    print("01  "+widget.name??"null");
//    print("01  "+widget.acount??"null");
//    print("01  "+widget.acountname??"null");
//    print("01  "+widget.name??"null");
//    print("01  "+widget.returnVal??"null");
//    print("01  "+widget.type2Str??"null");
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffF5FAF2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 85,
          title: Text(
            'پرداخت',
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Image.asset(
                  'assets/icons/wallet.png',
                  alignment: Alignment.center,
                  width: 80 * (screenSize.width) / 375,
                  height: 80 * (screenSize.width) / 375,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  " خرید " + getNsme(),
                  style: TextStyle(
                      color: Color(0xff5c5c5c),
                      fontWeight: FontWeight.w600,
                      fontSize: 16 * fontvar),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30, top: 23),
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                formatter.format(int.parse(_value)),
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
              // Container(
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.circular(12)),
              //   ),
              //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
              //   child: Text(
              //     _country=="98"
              //         ?formatter.format(int.parse(_value)) + "  تومان "
              //         :formatter.format(int.parse(_value)) + "  یورو ",
              //
              //
              //     textDirection: TextDirection.rtl,
              //     style: TextStyle(
              //         color: Color(0xff5c5c5c),
              //         fontSize: 14*fontvar,
              //         fontWeight: FontWeight.w500),
              //   ),
              //   width: 100*(screenSize.width)/375,
              //   height: 40*(screenSize.width)/375,
              // ),
              apkType == "bazaar"
                  ? Container(
                      height: 50,
                      width: 0,
                    )
                  : Container(
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
                                      onTap: () async {
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
                              child:  Image.asset(
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
              // Container(
              //
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //       ),
              //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //
              //         children: <Widget>[
              //           Padding(
              //             padding: EdgeInsets.only(bottom: 5,left: 10,right: 5),
              //             child: Icon(
              //               Icons.card_giftcard,
              //               color: Color(0xffF15A23),
              //               size: 22*(screenSize.width)/375,
              //             ),
              //           ),
              //           Expanded(child:   TextField(
              //             onChanged: (String val){
              //               setState(() {
              //                 _code=val;
              //               });
              //             },
              //             maxLines: 1,
              //             textAlign: TextAlign.right,
              //             textDirection: TextDirection.rtl,
              //             style:
              //             TextStyle(fontSize: 13*fontvar, fontWeight: FontWeight.w400),
              //             decoration: InputDecoration(
              //               hintText: "کد تخفیف را وارد کنید...",
              //               border: InputBorder.none,
              //             ),
              //           ),),
              //
              //           Stack(
              //             alignment: Alignment.center,
              //             children: <Widget>[
              //               Padding(padding: EdgeInsets.symmetric(horizontal: 3),child:    SizedBox(
              //
              //                 height: 30*(screenSize.width)/375,
              //                 width: 60*(screenSize.width)/375,
              //                 child: RaisedButton(
              //                   onPressed: () {
              //                     time==0?  discount():cansel();
              //                   },
              //                   color:  time==0?Color(0xff6CBD45):Colors.red,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: new BorderRadius.circular(18.0),
              //                   ),
              //                   child: Text(
              //                     time==0?'اعمال':"لغو",
              //                     style:
              //                     TextStyle(color: Colors.white, fontSize: 10*fontvar),
              //                   ),
              //                   padding: EdgeInsets.all(0),
              //                   elevation: 0,
              //                 ),
              //               ),),
              //               (showLoading)?
              //                 SpinKitCircle(
              //                   color: Colors.white,
              //                   size: 20*(screenSize.width)/375,
              //                 ):Container(width:0,height:0),
              //             ],
              //
              //           )
              //
              //         ],
              //       ),
              //       width: 100*(screenSize.width)/375,
              //       height: 50*(screenSize.width)/375,
              //
              //     ),
              //     Container(
              //
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //       ),
              //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //
              //         children: <Widget>[
              //           Padding(
              //             padding: EdgeInsets.only(bottom: 5,left: 10,right: 5),
              //             child:Radio(value: 1, groupValue: 1, onChanged: (int a){},
              //           )),
              //           Padding(padding: EdgeInsets.symmetric(horizontal: 3),
              //               child:Text('پرداخت آنلاین')   )
              //         ],
              //       ),
              //       width: 100*(screenSize.width)/375,
              //       height: 50*(screenSize.width)/375,
              //
              //     ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xff6DC07B)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  margin: EdgeInsets.only(left: 5, bottom: 7),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: new Text(
                                      "تایید و پرداخت اینترنتی",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15 * fontvar,
                                          color: Colors.white),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                onTap: showLoading2
                                    ? null
                                    : () async {
                                        setState(() {
                                          showLoading2 = true;
                                        });
                                        await payMethod();
                                      },
                              )))),
                  (showLoading2)
                      ? SpinKitCircle(
                          color: Colors.white,
                          size: 20 * (screenSize.width) / 375,
                        )
                      : Container(width: 0, height: 0),
                ],
              )
            ]))
          ],
        ));
  }

  _getUser() async {
    final reactiveModel = Injector.getAsReactive<userStore>();
    await reactiveModel.setState((store) async => await store.getNotNull(context),
        onData: (context, userSt ) {

          if (userSt.user != null) {
            _userid = userSt.user.uid;
          }});

  }



  Future<void> discount() async {
    if (_code.isEmpty) {
      showSnakBar("کد تخفیف را وارد کنید.");
    } else {
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
        String type3 = diet == null ? "account" : "diet";

        final response = await Provider.of<apiServices>(context, listen: false)
            .Paydiscount(_code, _value, type3, 'Bearer ' + apiToken);
        print(response.bodyString);

        if (response.statusCode == 200) {
          final post = json.decode(response.bodyString);
          print(post["status"]);
          print(post["finalAmount"]);
          print(post["disAmount"]);
          print(post["discount"]["code"]);
          setState(() {
            var value = post["finalAmount"];
            _value = value.toString();
            _disAmount =
                post["disAmount"] == null ? null : post["disAmount"].toString();
            _discount = post["discount"]["code"] == null
                ? null
                : post["discount"]["code"].toString();
          });

          if (post["status"] == "failed") {
            showSnakBar("کد نادرست است.");
          } else if (post["status"] == "success") {
            setState(() {
              time = 1;
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
//
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String payloadStr = generateRandomString(10);
    _value = "0";


     if (diet == null) {

      if (_value != "0") {
        String orderid = await orderID(
            "account", _userid, _value, account_id: acount, diet_type: "");
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
                builder: (_) =>
                    WillPopScope(
                        onWillPop: () {},
                        child: Dialog(
                          child: Container(
                            alignment: FractionalOffset.center,
                            height: 80.0,
                            padding: EdgeInsets.all(20.0),
                            child: Row(
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
            if (await canLaunch(returnUrl)) {
              bool islunched = await launch(returnUrl,
                forceSafariVC: false,
                enableJavaScript: true,
              );
              Timer(Duration(seconds: 2), () async {
                Navigator.of(context, rootNavigator: true).pop();

                Navigator.pop(context);
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
              builder: (_) =>
                  WillPopScope(
                      onWillPop: () {},
                      child: Dialog(
                        child: Container(
                          alignment: FractionalOffset.center,
                          height: 80.0,
                          padding: EdgeInsets.all(20.0),
                          child: Row(
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
              "https://api.barikaapp.com/api/payment/request?order_id=${orderid}")) {
            bool islunched = await launch(
              "https://api.barikaapp.com/api/payment/request?order_id=${orderid}",
              forceSafariVC: false, enableJavaScript: true,);

            Timer(Duration(seconds: 2), () async {
              Navigator.of(context, rootNavigator: true).pop();
              await  DeepLinksUtil().initUniLinks(context);
              print("backbcak");
              Navigator.pop(context);
            });
          } else {
            throw 'Could not launch';
          }
        }
      }

      else {
        await zpayacount();
      }
    }

    setState(() {
      showLoading2 = false;
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

  getNsme() {
    if (widget.diet != null) {
      return "رژیم " + dietNameSelector(diet);
    } else
      return widget.acountname;
  }

  cansel() {
    setState(() {
      _value = _value1;
      time = 0;
    });
  }

  Future<void> zpayacount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try {
      final response = await Provider.of<apiServices>(context, listen: false)
          .freeAcount(_userid, acount, 'Bearer ' + apiToken);

      if (response.statusCode == 200) {
        final post = json.decode(response.bodyString);
        print(post);
        if (post["msg"] == "success") {

          final reactiveModel = Injector.getAsReactive<userStore>();
          await reactiveModel.setState((store) async => await store.getUser(context),
              onData: (context, userSt ) {

                if (userSt.user != null) {
                  _userid = userSt.user.uid;
                }});
          Navigator.pop(context, "yess");
        }
      } else {
        print(response.statusCode.toString());
        showSnakBar("خطا اتصال به اینترنت");
      }
    } catch (e) {
      print(e.toString());
      showSnakBar("خطا اتصال به اینترنت");
    }
  }

  Future<String> orderID(String type, String user_id, String amount,
      {String diet_type, String account_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try {
      final response = await Provider.of<apiServices>(context, listen: false)
          .creatPay(type, amount, _discount, _disAmount, user_id, account_id,
              diet_type, 'Bearer ' + apiToken);

      if (response.statusCode == 200) {
        final post = json.decode(response.bodyString);
        print(diet_type + "post[order]");
        print(post.toString());
        if (post["msg"] == "success") {
          print(post["order"] + "post[order]");
          return post["order"];
        }
      } else {
        print(response.statusCode.toString());

        showSnakBar("خطا اتصال به اینترنت");
      }
    } catch (e) {
      print(e.toString());

      showSnakBar("خطا اتصال به اینترنت");
    }
  }

  Future<void> getContry() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("_country is null");
    if(_country==null)
      setState(() {
      print("_country is null");
      print(_country);
      print("_country is null");
      _country = prefs.getString('country');
    });
  }


}
