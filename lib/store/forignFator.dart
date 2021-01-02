import 'dart:convert';
import 'dart:ui';

import 'package:barika_web/models/user.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barika_web/utils/custom_expansion_tile4.dart' as custom;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forignFator extends StatefulWidget {
  String orderId;
  forignFator({Key key, this.orderId,}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new forignFatorState();
}

class forignFatorState extends State<forignFator> {
  final _formKey = GlobalKey<FormState>();
  bool showLoading = false;
  bool showLoading2 = false;

//  String _emailValue;
  String _phonValue;
  String _nameValue;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final GlobalKey<
      custom.ExpansionTileState4> expansionTileKeyCar = GlobalKey(); // NE
  String countryCode = "";
  List<String> _MyExpandedList = [];

  startTime() {

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareData();
    showLoading = false;
  }

  bool sufix = true;
  var loginColor = Color(0xffF15A23);
  var signupColor = Color(0xFF6DC07B);
  var textColor = Color(0xff51565F);


  var fontvar = 1.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 85,
        title: Text(
          'انتقال به درگاه پرداخت',
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
          decoration: BoxDecoration(
              color: MyColors.green
          ),
        ),
      ),
      key: _scaffoldKey,
      body: Builder(
        builder: (context) =>
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[

                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 16, left: 5, top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("نام", style: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 12 * fontvar,
                                              fontWeight: FontWeight.w400
                                          ),),
                                          TextFormField(

                                            controller: _fnameController,
                                            keyboardType: TextInputType.text,
                                            validator: (String value) {
                                              if (value.length == 0) {
                                                return
                                                  'نام خود را وارد کنید!';
                                              }
                                            },
                                            style: TextStyle(
                                                color: Color(0xff51565F),
                                                fontSize: 14 * fontvar,
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(
                                                            0xffD5D5D5),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(
                                                            0xff6DC07B),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),


                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14 * fontvar,
                                                    fontWeight: FontWeight
                                                        .w400),
                                                contentPadding: const EdgeInsets
                                                    .only(
                                                    top: 10,
                                                    right: 5,
                                                    bottom: 10,
                                                    left: 5
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 5, top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("نام خانوادگی", style: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 12 * fontvar,
                                              fontWeight: FontWeight.w400
                                          ),),
                                          TextFormField(

                                            controller: _lnameController,
                                            keyboardType: TextInputType.text,
                                            validator: (String value) {
                                              if (value.length == 0) {
                                                return
                                                  'نام خانوادگی خود را وارد کنید!';
                                              }
                                            },
                                            style: TextStyle(
                                                color: Color(0xff51565F),
                                                fontSize: 14 * fontvar,
                                                fontWeight: FontWeight.w500),
                                            decoration: new InputDecoration(
                                                enabledBorder: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffD5D5D5),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xff6DC07B),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14 * fontvar,
                                                    fontWeight: FontWeight
                                                        .w400),
                                                contentPadding: const EdgeInsets
                                                    .only(
                                                    top: 10,
                                                    right: 5,
                                                    bottom: 10,
                                                    left: 5
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 16, left: 5, top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("ایمیل", style: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 12 * fontvar,
                                              fontWeight: FontWeight.w400
                                          ),),
                                          TextFormField(

                                            controller: emailController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            validator: (String value) {
                                              if (value.length == 0) {
                                                return
                                                  'ایمیل خود را وارد کنید!';
                                              }
                                            },
                                            style: TextStyle(
                                                color: Color(0xff51565F),
                                                fontSize: 14 * fontvar,
                                                fontWeight: FontWeight.w500),
                                            decoration: new InputDecoration(
                                                enabledBorder: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffD5D5D5),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xff6DC07B),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14 * fontvar,
                                                    fontWeight: FontWeight
                                                        .w400),
                                                contentPadding: const EdgeInsets
                                                    .only(
                                                    top: 10,
                                                    right: 5,
                                                    bottom: 10,
                                                    left: 5
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 5, top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("شماره موبایل", style: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 12 * fontvar,
                                              fontWeight: FontWeight.w400
                                          ),),
                                          TextFormField(

                                            controller: phoneController,
                                            keyboardType: TextInputType.phone,
                                            validator: (String value) {
                                              if (value.length == 0) {
                                                return
                                                  'شماره موبایل خود را وارد کنید';
                                              }
                                            },
                                            style: TextStyle(
                                                color: Color(0xff51565F),
                                                fontSize: 14 * fontvar,
                                                fontWeight: FontWeight.w500),
                                            decoration: new InputDecoration(
                                                enabledBorder: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffD5D5D5),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xff6DC07B),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14 * fontvar,
                                                    fontWeight: FontWeight
                                                        .w400),
                                                contentPadding: const EdgeInsets
                                                    .only(
                                                    top: 10,
                                                    right: 5,
                                                    bottom: 10,
                                                    left: 5
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 11, left: 5, top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "کشور", style: TextStyle(
                                                color: Color(0xff818181),
                                                fontSize: 12 * fontvar,
                                                fontWeight: FontWeight.w400
                                            ),),
                                          ),
                                          custom.ExpansionTile4(
                                            key: expansionTileKeyCar,
                                            onExpansionChanged: (
                                                bool expanded) {
                                              print(expanded);
                                            },

                                            headerBackgroundColor: Colors.transparent,
                                            borderColor: Color(0xffD5D5D5),
                                            size: screenSize,
                                            iconColor: Color(0xffA2A2A2),
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              countryCode,
                                              style: TextStyle(
                                                  fontSize: 15.0 * fontvar,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff5c5c5c)),
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.ltr,
                                            ),
                                            children: <Widget>[
                                              Column(
                                                children: _buildExpandableContent(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    child: Container(

                                      margin: EdgeInsets.only(
                                          left: 16, right: 5, top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text("شهر", style: TextStyle(
                                              color: Color(0xff818181),
                                              fontSize: 12 * fontvar,
                                              fontWeight: FontWeight.w400
                                          ),),

                                          Container(
                                          height: 50*(screenSize.width)/375,
                                         child: TextFormField(

                                            controller: cityController,
                                            keyboardType: TextInputType.text,
                                            validator: (String value) {
                                              if (value.length == 0) {
                                                return
                                                  'شهر خود را وارد کنید';
                                              }
                                            },
                                            style: TextStyle(
                                                color: Color(0xff51565F),
                                                fontSize: 14 * fontvar,
                                                fontWeight: FontWeight.w500),
                                            decoration: new InputDecoration(
                                                enabledBorder: new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffD5D5D5),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xff6DC07B),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Color(
                                                            0xffED0A0A),
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14 * fontvar,
                                                    fontWeight: FontWeight
                                                        .w400),
                                                contentPadding: const EdgeInsets
                                                    .only(
                                                    top: 10,
                                                    right: 5,
                                                    bottom: 10,
                                                    left: 5
                                                )
                                            ),
                                          )),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("آدرس", style: TextStyle(
                                      color: Color(0xff818181),
                                      fontSize: 12 * fontvar,
                                      fontWeight: FontWeight.w400
                                  ),),
                                  TextFormField(

                                    controller: addressController,
                                    keyboardType: TextInputType.text,
                                    validator: (String value) {
                                      if (value.length == 0) {
                                        return
                                          'آدرس خود را وارد کنید';
                                      }
                                    },
                                    style: TextStyle(color: Color(0xff51565F),
                                        fontSize: 14 * fontvar,
                                        fontWeight: FontWeight.w500),
                                    decoration: new InputDecoration(
                                        enabledBorder: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffD5D5D5),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xff6DC07B),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffED0A0A),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffED0A0A),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        hintStyle: TextStyle(color: Colors.grey,
                                            fontSize: 14 * fontvar,
                                            fontWeight: FontWeight.w400),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10,
                                            right: 5,
                                            bottom: 10,
                                            left: 5
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("کد پستی", style: TextStyle(
                                      color: Color(0xff818181),
                                      fontSize: 12 * fontvar,
                                      fontWeight: FontWeight.w400
                                  ),),
                                  TextFormField(

                                    controller: codeController,
                                    keyboardType: TextInputType.number,
                                    validator: (String value) {
                                      if (value.length == 0) {
                                        return
                                          'کد پستی خود را وارد کنید';
                                      }
                                    },
                                    style: TextStyle(color: Color(0xff51565F),
                                        fontSize: 14 * fontvar,
                                        fontWeight: FontWeight.w500),
                                    decoration: new InputDecoration(
                                        enabledBorder: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffD5D5D5),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xff6DC07B),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffED0A0A),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffED0A0A),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))
                                        ),
                                        hintStyle: TextStyle(color: Colors.grey,
                                            fontSize: 14 * fontvar,
                                            fontWeight: FontWeight.w400),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10,
                                            right: 5,
                                            bottom: 10,
                                            left: 5
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Padding(padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 35),
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        color: showLoading2?Color(0xff6DC07B).withOpacity(0.7):Color(0xff6DC07B)
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),

                                    child:
                                    Padding(padding: EdgeInsets.symmetric(
                                      vertical: 5,), child: new Text(
                                      "انتقال به درگاه پرداخت",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15 * fontvar,
                                          color: Colors.white),
                                      maxLines: 2,
                                    ),),

                                  ),

                                  onTap:showLoading2?null: () async {
                                    if (_formKey.currentState.validate()) {
                                      await setData();
                                      await callApi();
                                    }
                                  },
                                ))),

                        (showLoading2)?
                        SpinKitCircle(
                          color: Colors.white,
                          size: 20*(screenSize.width)/375,
                        ):Container(width:0,height:0),
                      ],

                    )
                  ],
                  ),

                )
              ],
            ),
      ),


    );
  }


  _buildExpandableContent() {
    List<Widget> columnContent = [];

    for (int i = 0; i < _MyExpandedList.length; i++)
      columnContent.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Text(
                _MyExpandedList[i],
                style: TextStyle(
                  fontSize: 15.0 * fontvar,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5c5c5c),),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
            ),
            onTap: () async {
              setState(() {
                expansionTileKeyCar.currentState.handleTap();
                countryCode = _MyExpandedList[i];
              });
            },
          ),

          Divider(
            color: Color(0xffA2A2A2),
            endIndent: 15,
            height: 1,
            indent: 15,
          )
        ],
      ));

    return columnContent;
  }

  prepareData() async {
    setState(() {
      _MyExpandedList = [
        "آرژانتین",
        "آذربایجان",
        "آفریقای جنوبی",
        "آلمان",
        "اتریش",
        "اردن",
        "ارمنستان",
        "ازبکستان",
        "اسپانیا",
        "استرالیا",
        "اسلوونی",
        "افغانستان",
        "الجزایر",
        "امارات متحده عربی",
        "اندونزی",
        "اوکراین",
        "ایالات متحده امریکا",
        "ایتالیا",
        "ایرلند",
        "ایسلند",
        "بحرین",
        "برزیل",
        "بریتانیا (انگلستان)",
        "بلاروس",
        "بلژیک",
        "بلغارستان",
        "بنگلادش",
        "پاکستان",
        "پرتغال",
        "پرو",
        "تاجیکستان",
        "تایوان",
        "تایلند",
        "ترکمنستان",
        "ترکیه",
        "جمهوری چک",
       "جمهوری صربستان ",

        "چین",

        "دانمارک",
        "روسیه",
        "رومانی",
        "ژاپن",

        "سنگاپور",
        "سوئد",
        "سوئیس",
        "سوریه",

        "عراق",
        "عربستان سعودی",
        "عمان",


        "فرانسه",
        "فلسطین",
        "فیلیپین",
        "فنلاند",

        "قبرس",
        "قزاقستان",
        "قطر",

        "کانادا",
        "کره شمالی",
        "کره جنوبی",
        " کویت",

        " لبنان",
        "لهستان",
        "لیبی",

        "مالزی",
        "مجارستان",
        "مصر",
        "مکزیک",
        "مغولستان",

        "نروژ",
        "نیوزیلند",
        "نیجریه",

        "هلند",
        "هنگ کنگ",
        "هند",

        "یمن"
        "یونان",
      ];
      countryCode = _MyExpandedList[0];
    });


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userForign = prefs.getString('user_forign') ?? "";
    if (userForign == "") {
      User user = await getUsersq();
      phoneController.text = user.phone;
    } else {
      List<String> info = userForign.split("##");
      setState(() {
        _fnameController.text = info[0];
        _lnameController.text = info[1];
        emailController.text = info[2];
        phoneController.text = info[3];
        countryCode = info[4];
        cityController.text = info[5];
        addressController.text = info[6];
        codeController.text = info[7];
      });

      print(countryCode);
      print(info[4]);
      print(userForign);
    }
  }

  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String text =
        _fnameController.text + "##" +
            _lnameController.text + "##" +
            emailController.text + "##" +
            phoneController.text + "##" +
            countryCode + "##" +
            cityController.text + "##" +
            addressController.text + "##" +
            codeController.text + "##";

    prefs.setString("user_forign", text);
    // showSnakBar("اطلاعات شما ثبت شد.");
  }

  Future<User> getUsersq() async {
//     User user;
//     try {
//       var db = new userProvider();
//       await db.open();
//       user = await db.paginate();
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
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
        style: TextStyle(fontWeight: FontWeight.w400,
            fontSize: 15 * fontvar,
            fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }

  callApi()async {
    setState(() {
      showLoading2=true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');

print(    widget.orderId);
print(" widget.orderId");


    final response = await Provider.of<apiServices>(context, listen: false)
        .euroPay(
    widget.orderId,
    _fnameController.text,
    _lnameController.text,
    emailController.text ,
    phoneController.text,
    addressController.text ,
    codeController.text,
    countryCode ,
    cityController.text ,
    'Bearer ' + apiToken
    );
    print(response.bodyString);
    if (response.statusCode == 200) {
      if(response.bodyString.contains("error")) showSnakBar("لطفا مجددا تلاش کنید.");
      else {
        final post = json.decode(response.bodyString);
        print(post["calUrl"]);
        String calurl = post["calUrl"];
        Navigator.pop(context, calurl);
      }
  }
    else showSnakBar("لطفا مجددا تلاش کنید.");
    setState(() {
      showLoading2=false;
    });
}
}
