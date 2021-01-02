//import 'package:barika/utils/SizeConfig.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:barika/utils/colors.dart';
//
//
//class unitConvert extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => unitConvertState();
//}
//
//class unitConvertState extends State<unitConvert> {
//  List<DropdownMenuItem<String>> _dropDownMenuItems1 = [];
//  List<DropdownMenuItem<String>> _dropDownMenuItems2 = [];
//
//  List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> _uinits) {
//    List<DropdownMenuItem<String>> items = new List();
//    for (String unit in _uinits) {
//      items.add(new DropdownMenuItem(
//          value: unit,
//          child: Center(
//            child: new Text(unit, style: TextStyle(
//                fontSize: 12, fontWeight: FontWeight.w400
//            ),
//              textAlign: TextAlign.center,
//              maxLines: 1,
//            ),
//          )
//      ));
//    }
//    return items;
//  }
//
//  String _currectUnit1;
//  String _currectUnit2;
//
//
//  void changedDropDownItem1(String selectedCity) {
//    setState(() {
//      _currectUnit1 = selectedCity;
//      zarib1 = _zarib[_units.indexOf(selectedCity)];
//      print(_units.indexOf(selectedCity));
//      if (amount != null && zarib1 != null && zarib2 != null && amount != "")
//        result = (double.parse(amount) / zarib1 * zarib2).toStringAsFixed(1);
//    });
//  }
//
//  void changedDropDownItem2(String selectedCity) {
//    setState(() {
//      _currectUnit2 = selectedCity;
//      zarib2 = _zarib[_units.indexOf(selectedCity)];
//      if (amount != null && zarib1 != null && zarib2 != null && amount != "")
//        result = (double.parse(amount) / zarib1 * zarib2).toStringAsFixed(1);
//    });
//  }
//
//  @override
//  void initState() {
//    _dropDownMenuItems1 = getDropDownMenuItems(_units);
//    _dropDownMenuItems2 = getDropDownMenuItems(_units);
//    _currectUnit1 = _units[0];
//    _currectUnit2 = _units[0];
//    zarib1=_zarib[0];
//    zarib2=_zarib[0];
//    // TODO: implement initState
//    super.initState();
//  }
//
//  List <String>_units = [
//    "برنج پخته(قاشق غذا خوری سرخالی)",
//    "ماکارونی پخته(قاشق غذا خوری سرخالی)",
//    "لواش نازک(برش 10 * 10)",
//    "تنوری نازک(برش 10 * 10)",
//    "بربری(برش 10 * 10)",
//    "سنگک(برش 10 * 10)",
//    "نان تست(برش 10 * 10)",
//    "نان باگت بدون خمیر( سانتی متر)",
//    "سیب زمینی آبپز(گرم)",
//    "بیسکویت ساقه طلایی (عدد)",
//  ];
//
//
//  List _zarib = [
//    4, 3, 4, 3, 1, 1, 1, 7, 90, 3
//  ];
//  int zarib1;
//  int zarib2;
//
//  String result;
//  String amount;
//  Color textColor = Color(0xff555555);
//  int _selected;
//  int _selected2;
//
//  void onChanged(int value) {
//    setState(() {
//      _selected = value;
//      zarib1 = _zarib[value];
//      print(value);
//      if (amount != null && zarib1 != null && zarib2 != null && amount != "")
//        result = (double.parse(amount) / zarib1 * zarib2).toStringAsFixed(1);
//    });
//    print('Value = $value');
//  }
//
//  void onChanged2(int value) {
//    setState(() {
//      _selected2 = value;
//      zarib2 = _zarib[value];
//      if (amount != null && zarib1 != null && zarib2 != null && amount != "")
//        result = (double.parse(amount) / zarib1 * zarib2).toStringAsFixed(1);
//    });
//    print('Value = $value');
//  }
//
//  var fontvar=1.0;
//  @override
//  Widget build(BuildContext context) {
//    SizeConfig().init(context);
//    var bh=SizeConfig.safeBlockHorizontal;
//    var bv=SizeConfig.safeBlockVertical;
//    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
//    fontvar=(bh)/3.75;
//    return Scaffold(
//        appBar: new PreferredSize(
//          preferredSize: Size.fromHeight(80),
//          child: new Container(
//              padding: EdgeInsets.only(top: 10),
//              decoration: new BoxDecoration(
//                gradient: LinearGradient(
//                  colors: [
//                    new Color(0xff56AB2F),
//                    new Color(0xff6DBA3E),
//                    new Color(0xff88CC4F),
//                    new Color(0xffA8E063),
//                  ],
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  stops: [0.1, 0.6, 0.8, 0.9],
//                ),
//              ),
//              child: new SafeArea(
//                child: Stack(
//                  fit: StackFit.expand,
//                  children: <Widget>[
//                    Padding(
//                        padding: EdgeInsets.only(top: 12, bottom: 8),
//                        child:Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//
//                            Text(
//                              'تبدیل واحد مواد نشاسته ای به یکدیگر',
//                              style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.w700,
//                                fontSize: 16*fontvar,
//                              ),
//                              textAlign: TextAlign.center,
//                            ),
//                            Text(
//                              '( انواع نان، برنج، ماكاروني و سيب زميني )',
//                              style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.w400,
//                                fontSize: 14*fontvar,
//                              ),
//                              textAlign: TextAlign.center,
//                            ),
//                          ],
//                        )
//                    ),
//                    IconButton(
//                      icon: Icon(
//                        Icons.chevron_right,
//                        size: 32,
//                      ),
//                      onPressed: () {
//                        Navigator.pop(context, 'yes');
//                      },
//                      alignment: Alignment.topLeft,
//                      color: Colors.white,
//                      splashColor: Colors.amber,
//                      padding: EdgeInsets.all(7),
//                    ),
//
////                        IconButton(
////                          icon: Icon(
////                            Icons.search,
////                            size: 28,
////                          ),
////                          onPressed: () {},
////                          alignment: Alignment.topRight,
////                          color: Colors.white,
////                          splashColor: Colors.amber,
////                          padding: EdgeInsets.all(10),
////
//
//                  ],
//                ),
//              )),
//        ),
//
//        body:  CustomScrollView(slivers: <Widget>[
//          SliverList(
//              delegate: SliverChildListDelegate(<Widget>[
//                Container(
//                  margin: EdgeInsets.only(top: 15, right: 12, left: 12),
//                  child: Column(
//                    children: <Widget>[
//
//
//                      Padding(padding: EdgeInsets.only(
//                        top: 10,
//                      ),
//                        child: Text(
//                          "غذای نشاسته ای مورد نظر را انتخاب کنید.", style: TextStyle(
//                            color: textColor,
//                            fontWeight: FontWeight.w500,
//                            fontSize: 13*fontvar
//                        ),),),
//
//                      Container(
//                        width: MediaQuery.of(context).size.width,
//                        padding: EdgeInsets.only(right: 5),
//                        margin: EdgeInsets.only(right: 12,left: 12, top: 15),
//                        child: DropdownButtonHideUnderline(
//
//                          child: new DropdownButton<String>(
//
//                            value: _currectUnit1,
//                            items: _dropDownMenuItems1,
//                            onChanged: changedDropDownItem1,
//                          ),),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            border: Border.all(
//                                width: 1,
//                                color: Colors.green
//                            )
//                        ),
//                      ),
//
//                      Container(
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width/2,
//                        height: 52,
//                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                        child: TextField(
//                          maxLines: 1,
//
//                          onChanged: (String value) {
//                            setState(() {
//                              amount = value;
//                              if (amount != null && zarib1 != null && zarib2 != null &&
//                                  amount != "") result = (double.parse(amount) /
//                                  zarib1 * zarib2).toStringAsFixed(1);
//                            });
//                          },
//
//                          textAlign: TextAlign.center,
//                          keyboardType: TextInputType.number,
//                          decoration: new InputDecoration(
//                            focusColor: Colors.white,
//                            fillColor: Colors.white,
//                            contentPadding: EdgeInsets.all(0),
//                            border: new OutlineInputBorder(
//                                borderSide:
//                                new BorderSide(color: MyColors.green, width: 1),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10))),
//                            enabledBorder: new OutlineInputBorder(
//                                borderSide:
//                                new BorderSide(color: MyColors.green, width: 1),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10))),
//                            focusedBorder: new OutlineInputBorder(
//                                borderSide:
//                                new BorderSide(color: MyColors.green, width: 1),
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(10))),
//                            hintText: 'مقدار را وارد کنید',
//                            hintStyle: TextStyle(
//                                color: Colors.black26,
//                                fontSize: 14*fontvar,
//                                fontWeight: FontWeight.w500),
//                          ),
//                        ),
//                      ),
//
//                      Text("تبدیل شود به :", style: TextStyle(
//                          color: textColor,
//                          fontWeight: FontWeight.w500,
//                          fontSize: 13*fontvar
//                      ),),
//
//                      Container(
//
//                        width: MediaQuery.of(context).size.width,
//                        padding: EdgeInsets.only(right: 5),
//                        margin: EdgeInsets.only(right: 12,left: 12, top: 15,bottom: 15),
//                        child: DropdownButtonHideUnderline(
//
//                          child: new DropdownButton<String>(
//
//
//                            value: _currectUnit2,
//                            items: _dropDownMenuItems2,
//                            onChanged: changedDropDownItem2,
//                          ),),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            border: Border.all(
//                                width: 1,
//                                color: Colors.green
//                            )
//                        ),
//                      ),
//
//                      Text("نتیجه :", style: TextStyle(
//                          color: textColor,
//                          fontWeight: FontWeight.w500,
//                          fontSize: 13*fontvar
//                      ),),
//                      Container(
//                        alignment: Alignment.center,
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width/2,
//                        height: 45,
//                        margin: EdgeInsets.only(top: 3, left: 2),
//                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            border: Border.all(
//                                color: MyColors.green, width: 1
//                            )
//                        ),
//                        child: Text(
//                          result ?? "",
//                          style: TextStyle(
//                            color: textColor,
//                            fontSize: 14*fontvar,
//
//                          ),
//                        ),
//                      ),
//
//
////              Expanded(child:
////              Column(
////                children: <Widget>[
////                  Text("واحد 1  ", style: TextStyle(
////                      color: textColor,
////                      fontWeight: FontWeight.w500,
////                      fontSize: 13
////                  ),),
////                 Container(
////                   width: MediaQuery.of(context).size.width,
////                   height: 52,
////                   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
////                     child:  TextField(
////                       maxLines: 1,
////
////                       onChanged: (String value){
////                         setState(() {
////                           amount=value;
////                           if(amount!=null&&zarib1!=null&&zarib2!=null&&amount!="")    result=(double.parse(amount)/zarib1*zarib2).toStringAsFixed(1);
////                         });
////
////                       },
////
////                       textAlign: TextAlign.center,
////                       keyboardType: TextInputType.number,
////                       decoration: new InputDecoration(
////                           focusColor: Colors.white,
////                           fillColor: Colors.white,
////                           contentPadding: EdgeInsets.all(0),
////                           border: new OutlineInputBorder(
////                               borderSide:
////                               new BorderSide(color: MyColors.green, width: 1),
////                               borderRadius:
////                               BorderRadius.all(Radius.circular(10))),
////                           enabledBorder: new OutlineInputBorder(
////                               borderSide:
////                               new BorderSide(color: MyColors.green, width: 1),
////                               borderRadius:
////                               BorderRadius.all(Radius.circular(10))),
////                           focusedBorder: new OutlineInputBorder(
////                               borderSide:
////                               new BorderSide(color: MyColors.green, width: 1),
////                               borderRadius:
////                               BorderRadius.all(Radius.circular(10))),
////                           hintText: 'مقدار را وارد کنید',
////                           hintStyle: const TextStyle(
////                               color: Colors.black26,
////                               fontSize: 14,
////                               fontWeight: FontWeight.w500),
////                       ),
////                     ),
////                 ),
////
////
////
////
////
////                  Text("تبدیل از", style: TextStyle(
////                      color: Colors.grey,
////                      fontWeight: FontWeight.w500,
////                      fontSize: 13
////                  )),
////                  Expanded(child:  ListView.builder(
////                      itemCount: _units.length,
////                      itemBuilder: (BuildContext context, int index) {
////                        return GestureDetector(
////                          child: Container(
////                            child: Row(
////                              mainAxisAlignment: MainAxisAlignment.start,
////                              crossAxisAlignment: CrossAxisAlignment.start,
////                              children: <Widget>[
////                                Radio(
////                                  onChanged: (int val){
////                                    onChanged(val);
////
////                                  },
////                                  activeColor: MyColors.vazn,
////                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
////                                  value: index,
////                                  groupValue: _selected,
////                                ),
////                                Flexible(child:
////                                Padding(padding: EdgeInsets.only(top: 11),
////                                  child: Text(_units[index],style: TextStyle(
////                                      fontSize: 13,
////                                      fontWeight: FontWeight.w400
////                                  ),
////                                    textAlign: TextAlign.right,
////                                  ),
////
////                                ))
////
////
////                              ],
////                            ),
////                            margin: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
////                          ),
////                          onTap: (){
////                            onChanged(index);
////                          },
////
////                        );
////                      }))
////
////
////                ],
////              )),
////              Expanded(child:
////              Column(
////                children: <Widget>[
////                  Text("واحد 2  ", style: TextStyle(
////                      color: textColor,
////                      fontWeight: FontWeight.w500,
////                      fontSize: 13
////                  ),),
////
////                  Container(
////                    alignment: Alignment.center,
////                    width: MediaQuery.of(context).size.width,
////                   height: 45,
////                   margin: EdgeInsets.only(top: 3,left: 2),
////                   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
////                    decoration: BoxDecoration(
////                      borderRadius: BorderRadius.all(Radius.circular(10)),
////                      border: Border.all(
////                          color: MyColors.green, width: 1
////                      )
////                    ),
////                    child: Text(
////                      result??"",
////                      style: TextStyle(
////                        color: textColor,
////                        fontSize: 14,
////
////                      ),
////                    ),
////                  ),
////                  Text("تبدیل به", style: TextStyle(
////                      color: Colors.grey,
////                      fontWeight: FontWeight.w500,
////                      fontSize: 13
////                  )),
////                  Expanded(child:  ListView.builder(
////                      itemCount: _units.length,
////                      itemBuilder: (BuildContext context, int index) {
////                        return GestureDetector(
////                          child: Container(
////                            child: Row(
////                              mainAxisAlignment: MainAxisAlignment.start,
////                              crossAxisAlignment: CrossAxisAlignment.start,
////                              children: <Widget>[
////                                Radio(
////                                  onChanged: (int val){
////                                    onChanged2(val);
////                                  },
////                                  activeColor: MyColors.vazn,
////                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
////                                  value: index,
////                                  groupValue: _selected2,
////                                ),
////                                Flexible(child:
////                                Padding(padding: EdgeInsets.only(top: 11),
////                                child: Text(_units[index],style: TextStyle(
////                                    fontSize: 13,
////                                    fontWeight: FontWeight.w400
////                                ),
////                                  textAlign: TextAlign.right,
////                                ),
////
////                                ))
////
////
////                              ],
////                            ),
////                            margin: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
////                          ),
////                          onTap: (){
////                            onChanged2(index);
////                          },
////
////                        );
////                      }))
////
////
////                ],
////              )),
//                    ],
//                  ),
//                )
//
//              ]))]));
//  }
//}
