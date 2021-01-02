import 'dart:convert';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:barika_web/models/DbDailyDiet.dart';
import 'package:barika_web/models/DietChild.dart';
import 'package:barika_web/models/diets.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/profile/addprofileScreen.dart';
import 'package:barika_web/profile/editprofileScreen.dart';
import 'package:barika_web/profile/profileScreen.dart';
import 'package:barika_web/regims/dailyRegim.dart';
import 'package:barika_web/regims/dailyRegimChilds.dart';
import 'package:barika_web/regims/regimDialog.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/test_state_builder/diet_store.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:barika_web/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../helper.dart';


class regimList extends StatefulWidget {
  @override
  String type;
  String user;
  int logId;
  User userr;
  String type1;
  String type2;
  bool resume;

  regimList(
      {Key key,
      this.type,
      this.user,
      this.logId,
      this.type2,
      this.userr,
      this.type1,
      this.resume})
      : super(key: key);

  State<StatefulWidget> createState() => regimListState();
}

class regimListState extends State<regimList> with WidgetsBindingObserver {

  List<bool> _DbAllDietsListExist = [];
  int day = 1;
  Color textColor = Color(0xff555555);
  List<DbAllDiets> _DbAllDietsList = [];
  bool _isLoading = true;
  bool _isLoading2 = false;
  String type = "";

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int logId;
  String serverDate;

  Widget loadingView() {
    return Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void initState() {
    logId = widget.logId;
    serverDate = getDateToday();
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    type = widget.type;




    super.initState();
  }

  var fontvar = 1.0;
  Size screenSize=Size(600,600);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

     screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);


    return WillPopScope(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                type == null ? 'رژیم های من' : "رژیم " + dietNameSelector(type),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16 * fontvar,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size: 32 ,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop("ff");
                  },
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  splashColor: Colors.amber,
                  padding: EdgeInsets.all(7),
                ),
              ],
            ),
            body: StateBuilder<dietStore>(
              observe: () => RM.get<dietStore>(),
              builder: (_, reactiveModel) {
                return reactiveModel.whenConnectionState(
                  onIdle: (){print("onIdle reactiveModel");
                  return Container();
                  },
                  onWaiting: () {print("onWaiting reactiveModel");
                  return loadingView();},
                  onData: (store){print("onData reactiveModel");
                  _DbAllDietsList=[];
                  if(type!=null){
                  store.DbAllDietsList.forEach((element) {
                    if(element.type.contains(type))
                       _DbAllDietsList.add(element);
                  });
                  }
                  else _DbAllDietsList=store.DbAllDietsList;
                   addExist();
                  return widgetTest();},
                  onError: (_)  {print("onError reactiveModel" );
                  return Text("error");},
                );
              },
            ),),
        onWillPop: () {
          Navigator.pop(context, 'ff');
        });
  }

  widgetTest() {



    print(_DbAllDietsList.length);
               return  Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        (_DbAllDietsList.length != 0 )
                            ? Expanded(
                   child: ListView.builder(
                       itemCount: _DbAllDietsList.length,
                       itemBuilder: (BuildContextcontext,
                           int index) {


                           final difference = DateTime.parse(serverDate).difference(DateTime.parse(
                             _DbAllDietsList[index].created_at)).inDays;
                         day = int.parse(difference.toString()) + 1;
                           return
                                 GestureDetector(
                           child: Container(height: 110 *
                               (screenSize.width) / 375,
                               margin: EdgeInsets.only(
                                   right: 10, left: 10),
                               alignment: Alignment.center,
                             child: Stack(children: <Widget>[
                             Card(
                             shape:
                             RoundedRectangleBorder(
                                 borderRadius:
                                 BorderRadius.circular(
                                 10.0),
                           ),
                           child:
                           Row(
                             crossAxisAlignment:
                             CrossAxisAlignment.center,
                             mainAxisAlignment:
                             MainAxisAlignment.start,
                             children: <Widget>[
                               Regims(
                                   dietNameSelector(
                                       _DbAllDietsList[index]
                                           .type),
                                   dietIconSelector(
                                       _DbAllDietsList[index]
                                           .type),
                                   dietColorSelector(
                                       _DbAllDietsList[index]
                                           .type),
                                   allexpiredDate(
                                       _DbAllDietsList[index])
                               ),
                               Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment
                                     .start,
                                 mainAxisAlignment:
                                 MainAxisAlignment
                                     .center,
                                 children: <Widget>[
                                   Text(
                                     "رژیم " +
                                         _DbAllDietsList[index]
                                             .name,
                                     style: TextStyle(
                                         fontWeight: FontWeight
                                             .w500,
                                         fontSize: 13 *
                                             fontvar,
                                         color: Colors
                                             .black),
                                   ),
                                   Container(
                                     decoration: BoxDecoration(
                                       borderRadius: new BorderRadius
                                           .circular(
                                           5.0),
                                     ),
                                     padding: EdgeInsets
                                         .symmetric(
                                         horizontal: 5,
                                         vertical: 5),
                                     child: Text(
                                       "تاریخ شروع " +
                                           dateToJalali(
                                               _DbAllDietsList[index]
                                                   .created_at,
                                               1),
                                       style: TextStyle(
                                           fontWeight: FontWeight
                                               .w500,
                                           fontSize: 10 *
                                               fontvar,
                                           color: Color(
                                               0xff5C5C5C)),
                                       maxLines: 1,
                                     ),
                                   ),
                                   _DbAllDietsList[index]
                                       .day != 0
                                       ? Container(
                                     decoration: BoxDecoration(
                                       borderRadius: new BorderRadius
                                           .circular(
                                           5.0),
                                     ),
                                     padding: EdgeInsets
                                         .symmetric(
                                         horizontal: 5,
                                         vertical: 1),
                                     child: Text(
                                       "تاریخ انقضاء " +
                                           dateToJalali(
                                               _DbAllDietsList[index]
                                                   .created_at,
                                               _DbAllDietsList[index]
                                                   .day),
                                       style: TextStyle(
                                           fontWeight: FontWeight
                                               .w500,
                                           fontSize: 10 *
                                               fontvar,
                                           color: Color(
                                               0xff5C5C5C)),
                                       maxLines: 1,
                                     ),
                                   )
                                       : Container(),
                                 ],
                               ),
                               Expanded(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment
                                         .end,
                                     mainAxisAlignment: MainAxisAlignment
                                         .end,
                                     children: <
                                         Widget>[
                                       _DbAllDietsList[index]
                                           .day == 0
                                           ? Container(
                                         width: 0,
                                         height: 0,)
                                           : !expiredDate(
                                           _DbAllDietsList[index])
                                           ? FittedBox(
                                         child: Container(
                                           margin: EdgeInsets
                                               .only(
                                               bottom: 8,
                                               left: 8),
                                           padding: EdgeInsets
                                               .symmetric(
                                               vertical: 4,
                                               horizontal: 10),
                                           decoration: BoxDecoration(
                                               color: dietColorSelector(
                                                   _DbAllDietsList[index]
                                                       .type)
                                                   .withOpacity(
                                                   .8),
                                               borderRadius: BorderRadius
                                                   .all(
                                                   Radius
                                                       .circular(
                                                       8))),

                                           child: Text(
                                             "روز " +
                                                 day
                                                     .toString() +
                                                 " ام رژیم",
                                             style: TextStyle(
                                                 fontWeight: FontWeight
                                                     .w500,
                                                 fontSize: 11 *
                                                     fontvar,
                                                 color: Colors
                                                     .white),
                                             textAlign: TextAlign
                                                 .center,
                                             textDirection: TextDirection
                                                 .rtl,
                                           ),
                                         ),
                                         fit: BoxFit
                                             .fitWidth,
                                       )
                                           : FittedBox(
                                         child: Container(
                                           margin: EdgeInsets
                                               .only(
                                               bottom: 8,
                                               left: 8),
                                           padding: EdgeInsets
                                               .symmetric(
                                               vertical: 4,
                                               horizontal: 10),
                                           decoration: BoxDecoration(
                                               color: allexpiredDate(
                                                   _DbAllDietsList[index])
                                                   ? Color(
                                                   0xffB7B3B7)
                                                   : Color(
                                                   0xffE30026),
                                               borderRadius: BorderRadius
                                                   .all(
                                                   Radius
                                                       .circular(
                                                       8))),

                                           child: Text(
                                             "منقضی شده",
                                             style: TextStyle(
                                                 fontWeight: FontWeight
                                                     .w500,
                                                 fontSize: 11 *
                                                     fontvar,
                                                 color: Colors
                                                     .white),
                                             textAlign: TextAlign
                                                 .center,
                                             textDirection: TextDirection
                                                 .rtl,
                                           ),
                                         ),
                                         fit: BoxFit
                                             .fitWidth,
                                       )
                                     ],
                                   ))
                             ],
                           ),
                           elevation:
                           7,
                         ),
                               tamdidDate(_DbAllDietsList[index]) && !allexpiredDate(_DbAllDietsList[index])
                                   ? _DbAllDietsListExist
                                   .length > 0 &&
                                   !_DbAllDietsListExist[index]
                                   ? Container(
                                   alignment:
                                   Alignment.topLeft,
                                   child: tamdidDate(
                                       _DbAllDietsList[index])
                                       ?
                                   GestureDetector(
                                     child: Container(
                                       margin: EdgeInsets
                                           .only(bottom: 8,
                                           left: 8,
                                           top: 8),
                                       width: 105 *
                                           (screenSize
                                               .width) / 375,
                                       height: 35 *
                                           (screenSize
                                               .width) / 375,
                                       decoration: BoxDecoration(
                                           color: Colors
                                               .green
                                               .withOpacity(
                                               .8),
                                           borderRadius: BorderRadius
                                               .all(Radius
                                               .circular(
                                               8))),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment
                                             .center,
                                         children: <Widget>[
                                           Padding(
                                             padding: EdgeInsets
                                                 .only(
                                                 right: 5),
                                             child: Text(
                                               "ادامه رژیم",
                                               style: TextStyle(
                                                   fontSize: 12 *
                                                       fontvar,
                                                   fontWeight: FontWeight
                                                       .w500,
                                                   color: Colors
                                                       .white),
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                     onTap: ()  async {
                                       await Navigator
                                           .push(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) =>
                                               Directionality(
                                                   textDirection: TextDirection
                                                       .rtl,
                                                   child: editprofileScreen(
                                                     regim: type,
                                                     userSend:User.fromJsonDiet(_DbAllDietsList[index].userInfo) ,
                                                     dietId: _DbAllDietsList[index].id.toString(),
                                                   )),
                                         ),
                                       );
                                     },
                                   )
                                       : Container(
                                     margin: EdgeInsets.only(
                                         bottom: 8,
                                         left: 8,
                                         top: 8),
                                     width: 105 *
                                         (screenSize.width) /
                                         375,
                                     height: 35 *
                                         (screenSize.width) /
                                         375,
                                   ),
                                   margin: EdgeInsets.all(4),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius
                                         .circular(10.0),
                                     // color: Colors.white.withOpacity(0.4),
                                   )
                               )
                                   : Container(
                                   alignment:
                                   Alignment.topLeft,
                                   child: tamdidDate(_DbAllDietsList[index])
                                       ? Container(
                                     margin: EdgeInsets.only(
                                         bottom: 8,
                                         left: 8,
                                         top: 8),
                                     width: 105 *
                                         (screenSize.width) /
                                         375,
                                     height: 35 *
                                         (screenSize.width) /
                                         375,
                                     decoration: BoxDecoration(
                                         color: Colors.green
                                             .withOpacity(
                                             .8),
                                         borderRadius: BorderRadius
                                             .all(
                                             Radius.circular(
                                                 8))),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment
                                           .center,
                                       children: <Widget>[

                                         Icon(
                                           Icons
                                               .check_circle_outline,
                                           size: 17 *
                                               (screenSize
                                                   .width) /
                                               375,
                                           color: Colors
                                               .white,
                                         ),

                                         Padding(
                                           padding: EdgeInsets
                                               .only(
                                               right: 2,
                                               top: 2),
                                           child: Text(
                                             "تمدید شد",
                                             style: TextStyle(
                                                 fontSize: 12 *
                                                     fontvar,
                                                 fontWeight: FontWeight
                                                     .w500,
                                                 color: Colors
                                                     .white),
                                           ),
                                         )
                                       ],
                                     ),
                                   )
                                       : Container(
                                     margin: EdgeInsets.only(
                                         bottom: 8,
                                         left: 8,
                                         top: 8),
                                     width: 105 *
                                         (screenSize.width) /
                                         375,
                                     height: 35 *
                                         (screenSize.width) /
                                         375,
                                   ),
                                   margin: EdgeInsets.all(4),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius
                                         .circular(10.0),
                                     // color: Colors.white.withOpacity(0.4),
                                   )
                               )
                                   : Container(
                                 width: 0, height: 0,)




])
                         ),
                                   onTap: (){

                                      bool child=_DbAllDietsList[index].detail["advertise"]!=null;

                                      Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) =>
                                               Directionality(textDirection: TextDirection.rtl,
                                                   child:
                                                   child ?
                                                   dailyRegimChild(
                                                       _DbAllDietsList[index])
                                                       : dailyRegim(
                                                       _DbAllDietsList[index],
                                                       serverDate))));

                                   },



                         );}))
                            : Center(
                               child: Column(
                               children: <Widget>[
                               Image.asset(
                               "assets/icons/delivery.png"),
                           Padding(
                             padding: EdgeInsets
                                 .symmetric(
                                 vertical: 20,
                                 horizontal: 18),
                             child: Text(
                               type == null
                                   ? "شما هنوز رژیمی دریافت نکرده اید."
                                   : "شما هنوز هیچ رژیمی دریافت نکرده اید برای دریافت رژیم روی دکمه دریافت رژیم کلیک کنید",
                               style: TextStyle(
                                   color: Color(
                                       0xff5c5c5c),
                                   fontWeight:
                                   FontWeight
                                       .w400,
                                   fontSize:
                                   16 * fontvar),
                               textAlign:
                               TextAlign.center,
                             ),
                           )
                           ],
                         )
                       ),
                        type == null
                            ? SizedBox()
                            : Container(
                            padding: EdgeInsets.only(
                                right: 15,
                                left: 15,
                                bottom: 10,
                                top: 10),
                            child: Stack(
                              alignment:
                              Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                  screenSize.width,
                                  child: RaisedButton(
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius
                                            .circular(10),
                                      ),
                                      padding: EdgeInsets
                                          .symmetric(
                                          horizontal:
                                          5,
                                          vertical:
                                          8),
                                      color: MyColors
                                          .green,
                                      onPressed:
                                          ()  async {
//
                                            String returnVal =
                                            await showDialog(context: context, builder: (BuildContextcontext) {
                                                  return Padding(
                                                      padding: EdgeInsets.all(0),
                                                      child: Dialog(
                                                          elevation: 15,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius
                                                                .circular(
                                                                10),
                                                          ),
                                                          backgroundColor: Colors
                                                              .transparent,
                                                          child: regimDialog()));
                                                });


                                            if (returnVal == 'yes') {
                                              dateCall.saveMe("other");

                                              String d =
                                              await Navigator
                                                  .push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Directionality(
                                                          textDirection: TextDirection
                                                              .rtl,
                                                          child:
                                                          addprofileScreen(
                                                              regim: type)),
                                                ),
                                              );

                                              if (d != null)
                                                getRegims();
                                            } else if (returnVal ==
                                                "no") {
                                              dateCall.saveMe("me");

                                              User me=await getUser();

                                              if ((type.contains(
                                                  "pregnancy") ||
                                                  type.contains(
                                                      "lactation")) &&
                                                  me.gender == "male")
                                                showSnakBar(
                                                    "دریافت این رژیم برای شما امکان پذیر نیست");
                                              else {
                                                String d =
                                                await Navigator
                                                    .push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Directionality(
                                                            textDirection: TextDirection
                                                                .rtl,
                                                            child: profileScreen(
                                                              regim: type,
                                                            )),
                                                  ),
                                                );
                                                if (d !=
                                                    null)
                                                  getRegims();
                                              }
                                            }
                                          },
                                      child: Text(
                                        'دریافت رژیم ' +
                                            dietNameSelector(
                                                type),
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontWeight:
                                            FontWeight
                                                .w400,
                                            fontSize: 16 *
                                                fontvar),
                                      )),
                                ),
                              ],
                            )),
                      ],
                    );

  }
  addExist()  {
    List<bool> alldietdbexist = [];
    for (int i = 0; i < _DbAllDietsList.length; i++) {


      bool e =  searchByExtend(_DbAllDietsList[i].id);
      alldietdbexist.add(e);

      if (_DbAllDietsList.length - 1 == i) {
        _DbAllDietsListExist = alldietdbexist;
        // _isLoading = false;
      }
    }
    if (_DbAllDietsList.length == 0) _isLoading = false;
  }
  bool searchByExtend(int id)  {
    List<String>result=[];
    _DbAllDietsList.forEach((element) {
      if(element.extended_id==id.toString()){
        result.add("value");
      }
    });
    if(result.length>0)
      return true;
    else
    return false;
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

  Widget Regims(String name, String image, Color color, bool ex) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);
    if (ex) color = Color(0xffB7B3B7);
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Container(
                child: RawMaterialButton(
                  onPressed: () {},
                  child: Image.network(
                    image,
                    height: 26 * (screenSize.width) / 375,
                    width: 25 * (screenSize.width) / 375,

                  ),
                  shape: CircleBorder(
                      side: BorderSide(
                          color: color, width: 8 * (screenSize.width) / 375)),
                  elevation: 0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  color: Colors.white,
                )),
            width: 60 * (screenSize.width) / 375,
            padding: EdgeInsets.all(2),
            height: 60 * (screenSize.width) / 375,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 9 * fontvar),
          )
        ],
      ),
    );
  }


























//   Future<List<DbAllDiets>> _getAllDiets() async {
//     List<DbAllDiets> alldiet = [];
//     try {
//       var db = new allDietProvider();
//       await db.open();
//       type == null
//           ? alldiet = await db.paginate()
//           : alldiet = await db.getbyid(type);
// //      await db.close();
//       return alldiet;
//     } catch (e) {
//       return [];
//     }
//   }

  Future getRegims() async {
    List<DbAllDiets> alldietdb = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    serverDate = prefs.getString("date") ?? getDateToday();
    // serverDate= "2020-12-01 22:39:36";
    // print("prefs.getString(date)"+serverDate);


    // alldietdb = await _getAllDiets();
    if (alldietdb == null) {
      alldietdb = [];
    }


    _DbAllDietsList = alldietdb;

  }



  String dateToJalali(String datestr, int day) {
    DateTime now = DateTime.parse(datestr);
    var custom = new DateTime(
      now.year,
      now.month,
      now.day + day - 1,
    );
    datestr = intl.DateFormat('yyyy-MM-dd').format(custom);
//  String date='${custom.year.toString()}-${custom.month.toString()}-${custom.day.toString()}';

    var persianDateee = PersianDateTime.fromGregorian(
        gregorianDateTime: datestr ?? '1996-09-17');
    return persianDateee.toJalaali(format: 'YYYY/MM/DD');
  }

  getName(String type) {
    if (type.contains("weight_loss"))
      return "weight_loss";
    else if (type.contains("keep"))
      return "keep";
    else if (type.contains("weight_gain"))
      return "weight_gain";
    else if (type.contains("vegetarian"))
      return "vegetarian";
    else if (type.contains("athletes"))
      return "athletes";
    else if (type.contains("lactation"))
      return "lactation";
    else if (type.contains("pregnancy"))
      return "pregnancy";
    else if (type.contains("children"))
      return "children";
    else
      return "";
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (logId != null) {
        await getProductss2();
      } else if (widget.type2 != null) {
        await getProductss();
      }

      //do your stuff
    }
  }


  Future<void> getProductss2() async {
    print("isGetProductss2");
    setState(() {
      _isLoading2 = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    print(apiToken);
    try {
      final response =
      await Provider.of<apiServices>(this.context, listen: false)
          .getChildrenDiet(widget.userr.uid, widget.type1, widget.type2,
          logId, 'Bearer ' + apiToken);


      if (response.statusCode == 200) {
        final post = json.decode(response.bodyString);

        List<dynamic> ListPost = post['diet'];
        var ListUser = post['user'];
        DietChild dietChild;
        User user;
        if (ListPost.isNotEmpty) {
          ListPost.forEach((item) {
            dietChild = DietChild.fromJson(item);
          });
          user = User.fromJson(ListUser);

          if (post == null || post.isEmpty) {

          }

          var diet = {
            'id': widget.logId,
            'day': int.parse(dietChild.days),
            'type': "children",
            'type': dietChild.type,
            'Date': intl.DateFormat('yyyy-MM-dd')
                .format((DateTime.parse(post['date']['date']))),
            'user_id': widget.userr.uid,
            'name': user.name,
            'me': dateCall.getMe(),
            'extended_id': post['extended_id'],
          };

          DbAllDiets allDiet = DbAllDiets.fromJson(diet);
          // int id = await _saveAllDiets(allDiet);

          var dietdaily = {
            // 'id_allDiet': id,
            'id_allDiet': 5,
            'breakfast': dietChild.advertise,
            'lunch': dietChild.details,
            'dinner': dietChild.type,
            'snack': dietChild.type2,
            'day': 0,
          };

          DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);

          // print(await _saveDilyDiets(dailyDiet));
        } else {
//        showSnackBar();}
        }
      } else {
//      showSnackBar();
        print(response.statusCode.toString());
        print(response.error.toString());
      }
    } catch (e) {
      print(e.toString());
//      showSnackBar();
    }

    if (mounted) {
      setState(() {
        _isLoading2 = false;
        logId = null;
      });
    }
  }

//   Future<int> _saveAllDiets(DbAllDiets diets) async {
//     try {
//       var db = new allDietProvider();
//       await db.open();
//       DbAllDiets id = await db.insert(diets);
// //      await db.close();
//       return id.id;
//     } catch (e) {
//       return 0;
//     }
//   }

//   Future<bool> _saveDilyDiets(DbDailyDiet diets) async {
//     try {
//       var db = new DailyDietProvider();
//       await db.open();
//       await db.insert(diets);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

  Future<Map> getProductss() async {
    print("isGetProductss");
    setState(() {
      _isLoading2 = true;
    });
    List<diets> allDiets = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try {
      final response = await Provider.of<apiServices>(
          this.context, listen: false)
          .getUserInfoDiet2("0", 'Bearer ' + apiToken);

      if (response.statusCode == 200) {
        final post = json.decode(response.bodyString);

        List ListPost = post['diets'];

        if (ListPost == null || ListPost.isEmpty) {

        } else {
          ListPost.forEach((item) {
            allDiets.add(diets.fromJson(item));
          });

          User _user = widget.userr;


          for (int index = 0; index < allDiets.length; index++) {
            bool _condi = true;

            if (allDiets[index].detail.runtimeType.toString() ==
                "List<dynamic>") {
              List<dynamic> _ll = allDiets[index].detail;
              if (_ll.isEmpty) {
                _condi = false;
              }
            }
            if (allDiets[index].detail.toString() == "") _condi = false;
            if (allDiets[index].detail.toString() == null) _condi = false;
            if (ListPost[index]["advertise"] == null) _condi = false;

            if (_condi) {
              if (allDiets[index].regimName == "pregnancy") {
                // User user = await searchuser(allDiets[index].userInfo["uid"]);
                // user.prev_weight = allDiets[index].userInfo["prev_weight"];
                // user.week = allDiets[index].userInfo["week"];
                // user.id == null
                //     ? await updateDbByUid(user)
                //     : await updateDb(user);
              }

              String daysStr = allDiets[index].detail['days'] == null
                  ? "0"
                  : allDiets[index].detail['days'].toString();
              List allamount = allDiets[index].detail['breakfasts'];
              int id = 0;

              var diet = {
                'id': allDiets[index].id,
                'day': int.parse(daysStr),
                'type': allDiets[index].regimName.toString(),
                'Date': intl.DateFormat('yyyy-MM-dd')
                    .format((DateTime.parse(allDiets[index].created_at))),
                'user_id': allDiets[index].userInfo["uid"].toString(),
                'name': allDiets[index].userInfo["name"].toString(),
                'advertice': ListPost[index]["advertise"],
                'ghol': ListPost[index]["ghol"].toString(),
                'me': dateCall.getMe(),
                'extended_id': ListPost[index]["extended_id"],
              };

              DbAllDiets allDiet = DbAllDiets.fromJson(diet);
              // id = await _saveAllDiets(allDiet);


              List<DbDailyDiet> DbDailyDietList = [];
              DbDailyDietList =
              await addtoDailyList(allamount, index, id, allDiets);

              // print(await _saveAllDilyDiets(DbDailyDietList));
            } else {
              print(response.statusCode.toString());
            }
          }
        }
        if (mounted) {
          setState(() {
            _isLoading2 = false;
          });
        }
        return {"albums": diets};
      }
    } catch (e) {
      print("isGetProductssCatch$e");
    }
  }

//   Future<bool> _saveAllDilyDiets(List<DbDailyDiet> diets) async {
//     try {
//       var db = new DailyDietProvider();
//       await db.open();
//       await db.insertAll2(diets);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

  Future<List<DbDailyDiet>> addtoDailyList(List allamount, int index, int id,
      List<diets> allDiets) async {
    List<DbDailyDiet> DbDailyDietList = [];
    List nameb = [];
    List units = [];
    List values = [];
    List allBreakFast = [];
    List alldinner = [];
    List alllunch = [];
    List allsnacks = [];

    for (int i = 0; i < allamount.length; i++) {
      allBreakFast = [];
      alldinner = [];
      alllunch = [];
      allsnacks = [];

      List breakFast = allDiets[index].detail['breakfasts'];
      values = [];
      units = (breakFast[i]["details"]);

      for (int y = 0; y < units.length; y++)
        values.add({
          "value": breakFast[i]["details"][y]["value"],
          "name": breakFast[i]["details"][y]["detail"]["name"],
          "units": breakFast[i]["details"][y]["detail"]["unit"]
        });

      allBreakFast.add(jsonEncode({
        "id": breakFast[i]["id"],
        "name": breakFast[i]["title"]["name"],
        "value": values
      }));

      List Lunch = allDiets[index].detail['launches'];

      values = [];
      nameb.add(Lunch[i]["title"]["name"]);
      units = (Lunch[i]["details"]);

      for (int y = 0; y < units.length; y++)
        values.add({
          "value": Lunch[i]["details"][y]["value"],
          "name": Lunch[i]["details"][y]["detail"]["name"],
          "units": Lunch[i]["details"][y]["detail"]["unit"]
        });

      alllunch.add(jsonEncode({
        "id": Lunch[i]["id"],
        "name": Lunch[i]["title"]["name"],
        "value": values
      }));

      List dinners = allDiets[index].detail['dinners'];
      values = [];
      nameb.add(dinners[i]["title"]["name"]);
      units = (dinners[i]["details"]);

      for (int y = 0; y < units.length; y++)
        values.add({
          "value": dinners[i]["details"][y]["value"],
          "name": dinners[i]["details"][y]["detail"]["name"],
          "units": dinners[i]["details"][y]["detail"]["unit"]
        });

      alldinner.add(jsonEncode({
        "id": dinners[i]["id"],
        "name": dinners[i]["title"]["name"],
        "value": values
      }));

      List smacks = allDiets[index].detail['snacks'];

      values = [];
      nameb.add(smacks[i]["title"]["name"]);
      units = (smacks[i]["details"]);

      for (int y = 0; y < units.length; y++)
        values.add(jsonEncode({
          "value": smacks[i]["details"][y]["value"],
          "name": smacks[i]["details"][y]["detail"]["name"],
          "units": smacks[i]["details"][y]["detail"]["unit"]
        }));

      allsnacks.add(jsonEncode({
        "id": smacks[i]["id"],
        "name": smacks[i]["title"]["name"],
        "value": values
      }));

      var dietdaily = {
        'id_allDiet': id,
        'breakfast': allBreakFast[0],
        'lunch': alllunch[0],
        'dinner': alldinner[0],
        'snack': allsnacks[0],
        'day': i + 1,
      };

      DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
      DbDailyDietList.add(dailyDiet);
    }

    return DbDailyDietList;
  }
//
//   Future<User> updateDb(User user) async {
//     try {
//       var db = new userProvider();
//       await db.open();
//       print(await db.update(user));
// //      await db.close();
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//   Future<User> updateDbaccount(User user) async {
//     try {
//       var db = new userProvider();
//       await db.open();
//       print(await db.updateuid(user));
//       print("update user in store");
// //      await db.close();
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }

  tamdidDate(DbAllDiets dbAllDietsList) {
    if (dbAllDietsList.day != 0) {
      DateTime initdate = DateTime.parse(dbAllDietsList.created_at);
      var expireddate = new DateTime(
        initdate.year,
        initdate.month,
        initdate.day + dbAllDietsList.day,
      );
      DateTime now = DateTime.parse(serverDate);

      if (expireddate
          .difference(now)
          .inDays <= 0)
        return true;
      else
        return false;
    } else
      return false;
  }

  expiredDate(DbAllDiets dbAllDietsList) {
    if (dbAllDietsList.day != 0) {
      DateTime initdate = DateTime.parse(dbAllDietsList.created_at);
      var expireddate = new DateTime(
        initdate.year,
        initdate.month,
        initdate.day + dbAllDietsList.day + 1,
      );
      DateTime now = DateTime.parse(serverDate);

      if (expireddate
          .difference(now)
          .inDays <= 0)
        return true;
      else
        return false;
    } else
      return false;
  }

  allexpiredDate(DbAllDiets dbAllDietsList) {
    if (dbAllDietsList.day != 0) {
      DateTime initdate = DateTime.parse(dbAllDietsList.created_at);
      var expireddate = new DateTime(
        initdate.year,
        initdate.month,
        initdate.day + dbAllDietsList.day + 8,
      );
      DateTime now = DateTime.parse(serverDate);

      if (expireddate
          .difference(now)
          .inDays <= 0)
        return true;
      else
        return false;
    } else
      return false;
  }

//   Future<String> getUser() async {
//     User user;
//     try {
//       var db = new userProvider();
//       await db.open();
//       user = await db.paginate();
// //      await db.close();
//       return user.gender;
//     } catch (e) {
//       return null;
//     }
//   }



//   Future<User> searchuser(String uid) async {
//     try {
//       User user;
//       var db = new userProvider();
//       await db.open();
//       user = await db.getbyid(uid);
// //      await db.close();
//       return user;
//     } catch (e) {
//       return null;
//     }
//   }

  // Future<User> updateDbByUid(User user) async {
  //   try {
  //     var db = new userProvider();
  //     await db.open();
  //     print(await db.updateByUid2(user));
  //   } catch (e) {
  //     return null;
  //   }
  // }


  // Future<bool> searchByExtend(int id) async {
  //   try {
  //     var db = new allDietProvider();
  //     await db.open();
  //     bool exist = await db.searchByExten(id);
  //     return exist;
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // Future<void> setInfo() async {
  //   // if (dateCall.getUpdateRegim() == null ||
  //   //     dateCall.getUpdateRegim() == "tamam") await checkRegims();
  // }


  // Future<bool> _checkDaily(int allid) async {
//     try {
//       var db = new DailyDietProvider();
//       await db.open();
//       bool a = await db.getbyIdddd(allid);
// //      await db.close();
//       return a;
//     } catch (e) {
//       return false;
//     }
//   }
  Future<User> getUser() async {

    User us;
    final reactiveModel = Injector.getAsReactive<userStore>();
    await reactiveModel.setState((store) async => await store.getNotNull(context),
      onData: (context, userSt ) {
        print("userStuserStuserSt");
        print(userSt.user);
        print("userStuserStuserSt");

        if (userSt.user != null){
          us= userSt.user;
        }
        else
          showSnakBar("خطا در برقراری ارتباط");
      },

      onError: (context, error) {
        showSnakBar("خطا در برقراری ارتباط");
      },
    );
    print("us");
    print(us);
    return us;

  }
  updateaccount() async {
    print("updateaccount");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');

  try{
  final response = await Provider.of<apiServices>(this.context, listen: false)
      .getUserInfo(
  'Bearer '+apiToken);
  if (response.statusCode == 200) {
//      print('${response.bodyString}SSSSSSSSSSSSSSSSSSSSSSSS');
  final post = json.decode(response.bodyString);
  print(post);
  List<User> users=[];
  users.add(User.fromJson(post['success']));
  print(users[0].toMap().toString()+"fromjson");
  // await updateDbaccount(users[0]);

  }
  }catch(e){

  }}}