//
//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_svg/svg.dart';
//import 'package:barika/models/store.dart';
//import 'package:barika/models/storeUnit.dart';
//import 'package:barika/services/apiServices.dart';
//import 'package:barika/store/storeDialog.dart';
//import 'package:barika/utils/colors.dart';
//import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//import '../helper.dart';
//import 'Firstpayment.dart';
//
//
//class storeScreen extends StatefulWidget {
//  @override
//  storeScreen({Key key}) : super(key: key);
//
//  State<StatefulWidget> createState() => storeScreenState();
//}
//
//class storeScreenState extends State<storeScreen> with AutomaticKeepAliveClientMixin<storeScreen> {
//  @override
//  bool get wantKeepAlive => true;
//  List<store> _allStores=[];
//  bool _isLoading = true;
//  bool _connection = true;
//  String _value="";
//  String _unit="";
//  List<storeUnit> _storeUnit = [];
//
//  Widget loadingView() {
//    return new Center(
//        child:SpinKitCircle(
//          color: MyColors.vazn,
//        )
//    );
//  }
//  Widget listIsEmpty() {
//    return new Center(
//      child: new Text('این دسته خالی است.'),
//    );
//  }
//  Widget _errorConnection() {
//    return new SingleChildScrollView(
//        physics: AlwaysScrollableScrollPhysics(),
//        child:Container(
//          child:  Center(
//              child: new Text('خطای اتصال به اینترنت')
//          ),
//          height: MediaQuery.of(context).size.height,
//        )
//    );
//  }
//
//  void initState() {
//    super.initState();
//    _allStores.clear();
//    _getAlbums();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return new Scaffold(
//        body:
//        new RefreshIndicator(
//          child:new Stack(
//
//            children: <Widget>[
//              Container(
//
//                alignment: Alignment.topCenter,
//                padding: EdgeInsets.only(top: 30,right: 12,left:12),
//                height: 200,
//                width: MediaQuery.of(context).size.width,
//                decoration: new BoxDecoration(
//                  gradient:LinearGradient(
//                      colors: [
//                        new Color(0xff56AB2F),
//                        new Color(0xff6DBA3E),
//                        new Color(0xff88CC4F),
//                        new Color(0xffA8E063),
//                      ],
//                    begin: Alignment.topLeft,
//                    end: Alignment.bottomRight,
//                    stops: [0.1, 0.6, 0.8, 0.9],
//                  ),
//                ),
//                child: Stack(
//                  fit: StackFit.expand,
//                  children: <Widget>[
//
//                    Column(
//                     children: <Widget>[
//                       Padding(padding: EdgeInsets.only(top: 12,bottom: 8),
//                         child:   Text('فروشگاه',
//                           style: TextStyle(
//                         color: Colors.white,
//                         fontWeight:FontWeight.w700 ,
//                         fontSize: 16,
//                       ),
//                           textAlign: TextAlign.center,),
//                           ),
//                      Text('با خرید اشتراک برنامه کینگ دایت بخش های هدف  گذاری و رژیم درمانیبرای شما فعال می گردد',style: TextStyle(
//                         color: Colors.white,
//                         fontWeight:FontWeight.w400 ,
//                         fontSize: 14,
//                       ),textAlign: TextAlign.center,),
//                      ],
//
//                   )
//
//                  ],
//                ),
//              ),
//
//              !_connection && !_isLoading
//                  ? _errorConnection()
//                  : _allStores.length == 0 && _isLoading
//                  ? loadingView()
//                  : _allStores.length == 0
//                  ? listIsEmpty()
//                  :   Container(
//              margin: EdgeInsets.only(top: 145),
//
//              child: NotificationListener<OverscrollIndicatorNotification>(
//                onNotification: (overscroll) {
//                  overscroll.disallowGlow();
//                }, child: ListView.builder(
//
//                  itemCount: _allStores.length,
//                  itemBuilder: (BuildContext context, int index) {
//                    return  GestureDetector(
//                     child:   new Container(
//                     height: 130,
//                     margin: EdgeInsets.only(right: 10,left: 10),
//                     alignment: Alignment.center,
//                     child: new Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: new Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.all(6),
//                             child: ClipRRect(
//
//                               borderRadius: new BorderRadius.circular(8.0),
//                               child: FadeInImage(
//                                 alignment: Alignment.centerRight,
//                               placeholder:
//                               AssetImage('assets/images/placeholder.png'),
//                               image: NetworkImage(_allStores[index].cover),
//                               fit: BoxFit.fill,
//                               height: 60,
//                               width: 75,
//
//                             ),
//                             )),
//
//
//                           Expanded(child:Column(
//
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               new Padding(
//                                 padding: EdgeInsets.only(top: 8,right: 5),
//                                 child: new Text(
//                                   _allStores[index].name,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 13,
//                                       color: Color(0xff5C5C5C)),
//                                 ),
//                               ),
//                               new Padding(
//                                 padding: EdgeInsets.only(top: 2,right: 5),
//                                 child: new Text(
//                                   _allStores[index].description,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 11,
//                                       color: Color(0xffA2A2A2)),
//
//                                   maxLines: 2,
//                                 ),
//                               ),
//                               Expanded(child:
//
//                               Align(
//                                   alignment: Alignment.bottomLeft,
//                                   child:
//                                   Padding(padding: EdgeInsets.only(left: 5),
//                                     child: Container(
//                                       decoration:BoxDecoration(
//                                      borderRadius:
//                                      new BorderRadius.circular(5.0),
//color: Colors.green
//
//                                      ),
//
//                                       padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
//                                       margin: EdgeInsets.only(left: 5,bottom: 7),
//                                       child: new Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           SvgPicture.asset('assets/icons/store.svg',width: 12,height:12,),
//                                           Padding(padding: EdgeInsets.only(top: 3,),child:  new Text(
//                                             _storeUnit[index].value.toString(),
//
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 12,
//                                                 color: Colors.white),
//                                             maxLines: 2,
//                                           ),),
//                                           new Text(
//                                             ' هزار تومان',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10,
//                                                 color: Colors.white),
//                                             maxLines: 2,
//                                           ),
//                                         ],
//
//                                       ),
//
//                                     ),)
//
//                               ))
//                             ],
//                           ))
//
//
//                         ],
//                       ),
//
//                       elevation: 7,
//                     ),
//                   ),
//                      onTap: (){   showDialog(context: context,
//                          builder: (BuildContext context) {
//                            return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 30),child:  Dialog(
//                                elevation: 15,
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(10),
//                                ),
//                                backgroundColor: Colors.transparent,
//                                child:  Directionality(textDirection: TextDirection.rtl, child: storeDialog( _allStores[index], _storeUnit[index].value.toString(),))
//                            ));
//                          }
//
//                      );},
//
//                   );
//
//
//                  }),),
//            )
//            ],
//
//          ),
//          onRefresh: (){print('dddd');},
//        ),
//      );
//
//    }
//
//  Future <Map> getProducts() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String apiToken = prefs.getString('user_token');
//    final response = await Provider.of<apiServices>(context,listen: false).getStoreInfo(
//        'Bearer '+apiToken);
//    if (response.statusCode == 200) {
//
//      final  post = json.decode(response.bodyString);
//      List<store> stores =[];
//
//      post.forEach((item) {
//        stores.add(store.fromJson(item));
//      });
//      return {
//        "stores" : stores
//      };}
//    else {
//      print(response.statusCode.toString());
//    }
//  }
//  _getAlbums({ bool refresh : false}) async {
//    if( await checkConnectionInternet()) {
//      var response = await getProducts();
//      List<storeUnit> _storeUnit1 = [];
//      setState(() {
//        if(refresh) _allStores.clear();
//        _allStores.addAll(response['stores']);
//        _allStores.forEach((item) {
//          item.price.forEach((prices) {
//            print(prices.toString());
//            _storeUnit1.add(storeUnit.fromJson(prices));
//
//          });
//        });
//
//        _storeUnit1.forEach((prices) {
//            print(prices.toString());
//            prices.unit=='toman'?
//            _storeUnit.add(prices):(){};
//          });
//        print(_allStores.toString());
//        _isLoading=false;
//        _connection=true;
//      });}
//    else{
//      setState(() {
//        _connection=false;
//        _isLoading=false;
//      });
//    }
//  }
//  Future<Null> _handleRefresh() async {
//    await _getAlbums(refresh: true);
//    return null;
//  }
//
////  Navigator.push(
////  context,
////  MaterialPageRoute(
////  builder: (context) => Directionality(textDirection: TextDirection.rtl, child:FirstPayment()),
////  ),
////  );
//}

//
//
// import 'dart:async';
// import 'dart:convert';
// import 'package:barika/store/forignFator.dart';
// import 'package:barika/utils/SizeConfig.dart';
// import 'package:cafebazaar_market/cafebazaar_market.dart';
//
// import 'package:intl/intl.dart'as intl;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:barika/home/questionnaire.dart';
// import 'package:barika/models/store.dart';
// import 'package:barika/models/user.dart';
// import 'package:barika/regims/regimList.dart';
// import 'package:barika/services/apiServices.dart';
// import 'package:barika/sqliteProvider/userProvider.dart';
// import 'package:barika/store/storeScreen.dart';
// import 'package:barika/utils/DeepLinksUtil.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../helper.dart';
// class FirstPayment extends StatefulWidget {
//   String amount;
//   String userid;
//   String diet;
//   String acount;
//   String acountname;
//   String apkType;
//
//   final name;
//   User id;
//   final returnVal;
//   final type2Str;
//   final logId;
//
//
//   FirstPayment({this.amount,this.userid,this.diet,this.acount,this.acountname,this.id,this.name,this.returnVal,this.type2Str,this.logId,this.apkType});
//
//   @override
//   State<StatefulWidget> createState() => FirstPaymentState();
// }
//
// class FirstPaymentState extends State<FirstPayment> with  WidgetsBindingObserver{
//   String _value="";
//   String _discount="";
//   String _country="";
//   String  _disAmount="";
//   String _value1="";
//   String _userid;
//   String diet;
//   String acount;
//   String _code="";
//   String apkType;
//   int time=0;
//   bool showLoading=false;
//   bool showLoading2=false;
//   final formatter = new intl.NumberFormat("###,###");
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   void initState() {
//
//     apkType=widget.apkType;
//
//     getContry();
//     WidgetsBinding.instance.addObserver(this);
//     print(widget.name);
//     _value=widget.amount.toString();
//     _value1=widget.amount.toString();
//     widget.userid==null
//         ? _getUser()
//         : _userid=widget.userid;
//     diet=widget.diet;
//     if(diet=="keep") diet="weight_fix";
//     acount=widget.acount;
//
//     super.initState();
//   }
//   Widget loadingView() {
//     return  Center(
//         child: SpinKitCircle(
//           color: MyColors.vazn,
//         ));
//   }
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
// //    print("01  "+widget.amount??"null");
// //    print("01  "+widget.userid??"null");
// //    print("01  "+widget.diet??"null");
// //    print("01  "+widget.name??"null");
// //    print("01  "+widget.name??"null");
// //    print("01  "+widget.acount??"null");
// //    print("01  "+widget.acountname??"null");
// //    print("01  "+widget.name??"null");
// //    print("01  "+widget.returnVal??"null");
// //    print("01  "+widget.type2Str??"null");
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     fontvar = (bh) / 3.75;
//     if(fontvar>2)fontvar=1.7;
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     return  Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: Color(0xffF5FAF2),
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 85,
//           title: Text(
//             'پرداخت',
//             style: TextStyle(
//                 fontSize: 14*fontvar, fontWeight: FontWeight.w500, color: Colors.white),
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.chevron_right,
//                 size: 32*(screenSize.width)/375,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               alignment: Alignment.topLeft,
//               color: Colors.white,
//               splashColor: Colors.amber,
//               padding: EdgeInsets.all(7),
//             ),
//           ],
//           centerTitle: true,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//                 color: MyColors.green
//             ),
//           ),
//         ),
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverList(
//                 delegate: SliverChildListDelegate(<Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     child: SvgPicture.asset(
//                       'assets/icons/wallet.svg',
//                       alignment: Alignment.center,
//                       width: 80*(screenSize.width)/375,
//                       height: 80*(screenSize.width)/375,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Text(
//                       " خرید "+getNsme(),
//                       style: TextStyle(
//                           color: Color(0xff5c5c5c),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16*fontvar),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(
//                         right: 30, left: 30, top: 23),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             "مبلغ فاکتور",
//                             style: TextStyle(
//                                 fontSize: 18 * fontvar,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xff5C5C5C)),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: Color(0xff6DC07B).withOpacity(0.21),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(10)),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 5),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     formatter.format(int.parse(_value)),
//                                     style: TextStyle(
//                                         color: Color(0xff5C5C5C),
//                                         fontSize: 26 * fontvar,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   Text(
//                                     _country == "98" ? " تومان" : "  یورو ",
//                                     style: TextStyle(
//                                         color: Color(0xff5C5C5C),
//                                         fontSize: 16 * fontvar,
//                                         fontWeight: FontWeight.w500),
//                                   )
//                                 ],
//                               )
//                             // width: 100*(screenSize.width)/375,
//                             // height: 50*(screenSize.width)/375,
//
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   // Container(
//                   //   alignment: Alignment.center,
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.white,
//                   //     borderRadius: BorderRadius.all(Radius.circular(12)),
//                   //   ),
//                   //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
//                   //   child: Text(
//                   //     _country=="98"
//                   //         ?formatter.format(int.parse(_value)) + "  تومان "
//                   //         :formatter.format(int.parse(_value)) + "  یورو ",
//                   //
//                   //
//                   //     textDirection: TextDirection.rtl,
//                   //     style: TextStyle(
//                   //         color: Color(0xff5c5c5c),
//                   //         fontSize: 14*fontvar,
//                   //         fontWeight: FontWeight.w500),
//                   //   ),
//                   //   width: 100*(screenSize.width)/375,
//                   //   height: 40*(screenSize.width)/375,
//                   // ),
//                   Container(
//                     height: 50 * (screenSize.width) / 375,
//                     margin: EdgeInsets.only(
//                         right: 30, left: 30, top: 23, bottom: 17),
//                     child: TextFormField(
//                       onChanged: (String val) {
//                         setState(() {
//                           _code = val;
//                         });
//                       },
//                       maxLines: 1,
//                       textAlign: TextAlign.right,
//                       textDirection: TextDirection.rtl,
//                       style: TextStyle(
//                           color: Color(0xff5c5c5c),
//                           fontSize: 14 * fontvar,
//                           fontWeight: FontWeight.w500),
//                       decoration: InputDecoration(
//                           suffixIcon: Container(
//                             alignment: Alignment.centerLeft,
//                             width: 50 * (screenSize.width) / 375,
//                             height: 50 * (screenSize.width) / 375,
//                             child: Stack(
//                                 alignment: Alignment.center,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       width: 50 * (screenSize.width) / 375,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.horizontal(
//                                             left: Radius.circular(10),
//                                             right: Radius.circular(0)),
//                                         color: time == 0
//                                             ? Color(0xff6DC07B)
//                                             : Colors.red,
//                                       ),
//                                       child: Text(
//                                         time == 0 ? 'اعمال' : "لغو",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 12 * fontvar,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                     onTap: ()async {
//                                       time == 0 ? await discount() : cansel();
//                                     },
//                                   ),
//                                   (showLoading)
//                                       ? SpinKitCircle(
//                                     color: Colors.white,
//                                     size: 20 * (screenSize.width) / 375,
//                                   )
//                                       : Container(width: 0, height: 0),
//                                 ]),
//                           ),
//                           prefixIcon: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: SvgPicture.asset(
//                               'assets/icons/gift.svg',
//                               height: 10 * (screenSize.width) / 375,
//                               width: 10 * (screenSize.width) / 375,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: MyColors.green, width: 1),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(10))),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: MyColors.green, width: 1),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(10))),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: MyColors.green, width: 1),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(10))),
//                           hintText:
//                           'در صورت داشتن کد تخفیف آن را وارد و سپس پرداخت کنید',
//                           hintStyle: TextStyle(
//                               color: Color(0xff828282),
//                               fontSize: 11 * fontvar,
//                               fontWeight: FontWeight.w400),
//                           contentPadding: const EdgeInsets.only(
//                               top: 10, right: 8, bottom: 10, left: 8)),
//                     ),
//                   ),
//                   // Container(
//                   //
//                   //       decoration: BoxDecoration(
//                   //         color: Colors.white,
//                   //         borderRadius: BorderRadius.all(Radius.circular(5)),
//                   //       ),
//                   //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   //       child: Row(
//                   //         crossAxisAlignment: CrossAxisAlignment.center,
//                   //
//                   //         children: <Widget>[
//                   //           Padding(
//                   //             padding: EdgeInsets.only(bottom: 5,left: 10,right: 5),
//                   //             child: Icon(
//                   //               Icons.card_giftcard,
//                   //               color: Color(0xffF15A23),
//                   //               size: 22*(screenSize.width)/375,
//                   //             ),
//                   //           ),
//                   //           Expanded(child:   TextField(
//                   //             onChanged: (String val){
//                   //               setState(() {
//                   //                 _code=val;
//                   //               });
//                   //             },
//                   //             maxLines: 1,
//                   //             textAlign: TextAlign.right,
//                   //             textDirection: TextDirection.rtl,
//                   //             style:
//                   //             TextStyle(fontSize: 13*fontvar, fontWeight: FontWeight.w400),
//                   //             decoration: InputDecoration(
//                   //               hintText: "کد تخفیف را وارد کنید...",
//                   //               border: InputBorder.none,
//                   //             ),
//                   //           ),),
//                   //
//                   //           Stack(
//                   //             alignment: Alignment.center,
//                   //             children: <Widget>[
//                   //               Padding(padding: EdgeInsets.symmetric(horizontal: 3),child:    SizedBox(
//                   //
//                   //                 height: 30*(screenSize.width)/375,
//                   //                 width: 60*(screenSize.width)/375,
//                   //                 child: RaisedButton(
//                   //                   onPressed: () {
//                   //                     time==0?  discount():cansel();
//                   //                   },
//                   //                   color:  time==0?Color(0xff6CBD45):Colors.red,
//                   //                   shape: RoundedRectangleBorder(
//                   //                     borderRadius: new BorderRadius.circular(18.0),
//                   //                   ),
//                   //                   child: Text(
//                   //                     time==0?'اعمال':"لغو",
//                   //                     style:
//                   //                     TextStyle(color: Colors.white, fontSize: 10*fontvar),
//                   //                   ),
//                   //                   padding: EdgeInsets.all(0),
//                   //                   elevation: 0,
//                   //                 ),
//                   //               ),),
//                   //               (showLoading)?
//                   //                 SpinKitCircle(
//                   //                   color: Colors.white,
//                   //                   size: 20*(screenSize.width)/375,
//                   //                 ):Container(width:0,height:0),
//                   //             ],
//                   //
//                   //           )
//                   //
//                   //         ],
//                   //       ),
//                   //       width: 100*(screenSize.width)/375,
//                   //       height: 50*(screenSize.width)/375,
//                   //
//                   //     ),
//                   //     Container(
//                   //
//                   //       decoration: BoxDecoration(
//                   //         color: Colors.white,
//                   //         borderRadius: BorderRadius.all(Radius.circular(5)),
//                   //       ),
//                   //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   //       child: Row(
//                   //         crossAxisAlignment: CrossAxisAlignment.center,
//                   //
//                   //         children: <Widget>[
//                   //           Padding(
//                   //             padding: EdgeInsets.only(bottom: 5,left: 10,right: 5),
//                   //             child:Radio(value: 1, groupValue: 1, onChanged: (int a){},
//                   //           )),
//                   //           Padding(padding: EdgeInsets.symmetric(horizontal: 3),
//                   //               child:Text('پرداخت آنلاین')   )
//                   //         ],
//                   //       ),
//                   //       width: 100*(screenSize.width)/375,
//                   //       height: 50*(screenSize.width)/375,
//                   //
//                   //     ),
//                   Stack(
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       Padding(padding: EdgeInsets.symmetric(horizontal: 3),child:    SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child:Padding(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
//                               child:     GestureDetector(
//                                 child: Container(
//                                   decoration:BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.circular(10.0),
//                                       color: Color(0xff6DC07B)
//                                   ),
//                                   padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
//                                   margin: EdgeInsets.only(left: 5,bottom: 7),
//                                   child:
//                                   Padding(padding: EdgeInsets.symmetric(vertical:5,),child:  new Text(
//                                     "تایید و پرداخت اینترنتی",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 15*fontvar,
//                                         color: Colors.white),
//                                     maxLines: 2,
//                                   ),),
//
//                                 ),
//
//                                 onTap:showLoading2?null: () async {
//                                   setState(() {
//                                     showLoading2=true;
//                                   });
//                                   await pay();
//                                 },
//                               )))),
//
//
//
//                       (showLoading2)?
//                       SpinKitCircle(
//                         color: Colors.white,
//                         size: 20*(screenSize.width)/375,
//                       ):Container(width:0,height:0),
//                     ],
//
//                   )
//
//                 ]))
//           ],
//         ));
//   }
//
//   _getUser() async {
//     var response = await getUser();
//     User user;
//     if (this.mounted) {
//       setState(() {
//         user = response;
//         _userid=user.uid;
//       });
//     }return user.uid;
//   }
//   static Future<User> getUser() async {
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
//   }
//   Future<void> discount() async {
//
//     if(_code.isEmpty){
//       showSnakBar("کد تخفیف را وارد کنید.");
//     }
//     else{
//
//       setState(() {
//         showLoading=true;
//       });
// //    "status": "failed",
// //    "discount": null,
// //    "finalAmount": "2000"
// //
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String apiToken = prefs.getString('user_token');
//       try {
//
//         String type3=diet==null?"account":"diet";
//
//         final response = await Provider.of<apiServices>(context, listen: false)
//             .Paydiscount(_code,_value,type3, 'Bearer ' + apiToken);
//         print(response.bodyString);
//
//         if (response.statusCode == 200) {
//
//           final post = json.decode(response.bodyString);
//           print(post["status"]);
//           print(post["finalAmount"]);
//           print(post["disAmount"]);
//           print(post["discount"]["code"]);
//           setState(() {
//             var value=post["finalAmount"];
//             _value=value.toString();
//             _disAmount=post["disAmount"]==null?null:post["disAmount"].toString();
//             _discount=post["discount"]["code"]==null?null:post["discount"]["code"].toString();
//
//           });
//
//           if(post["status"]=="failed"){
//             showSnakBar("کد نادرست است.");
//           }
//           else if(post["status"]=="success"){
//             setState(() {
//               time=1;
//             });
//             showSnakBar("با موفقیت اعمال شد.");
//           }
//           else if(post["status"]=="expired"){
//             showSnakBar("کد منقضی شده است.");
//
//           } else {
//             showSnakBar("خطا در دریافت اطلاعات");
//             print(response.statusCode.toString() + "error");
//           }
//         }} catch (e) {
//         showSnakBar("خطا در دریافت اطلاعات");
//         print(e.toString() + "catttttch");
//       }
//
//       setState(() {
//         showLoading=false;
//       });
// //
//     }}
//   Future<void> pay() async {
//
//     //
//     // _country="2";
//     // _value="5";
//     //
//
//     if(diet==null){
//       String orderid=await orderID("account",_userid,_value,account_id: acount,diet_type:"" );
//
//
//
//       if(_value!="0"){
//
//         if(_country!="98"){
//           String returnUrl = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   Directionality(
//                       textDirection: TextDirection.rtl, child: forignFator(orderId:orderid ,)),
//             ),
//           );
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
//               bool islunched=  await launch(returnUrl,
//                 forceSafariVC: false,
//                 enableJavaScript: true,
//               );
//               Timer(Duration(seconds: 2), () async {
//                 Navigator.of(context,rootNavigator:true).pop();
//                 await  DeepLinksUtil().initUniLinks(context);
//                 Navigator.pop(context); });
//             } else {
//               throw 'Could not launch';
//             }
//
//
//           }}
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
//
//
//           if (await canLaunch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}")) {
//             bool islunched= await launch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}", forceSafariVC: false, enableJavaScript: true,);
//
//             Timer(Duration(seconds: 2), () async {
//               Navigator.of(context,rootNavigator:true).pop();
//               await new DeepLinksUtil().initUniLinks(context);
//               Navigator.pop(context);});
//           } else {
//             throw 'Could not launch';
//           }}
//       }
//
//       else{await zpayacount();}
//     }
//     else if(widget.returnVal!=null){
//       String orderid=  await orderID("diet",_userid,_value,account_id: "",diet_type:"children" );
//       print(_userid);
//       print(widget.returnVal);
//       print(widget.type2Str);
//       print(widget.logId);
//
//       if(_value!="0"){
//         if (await canLaunch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}")) {
//           await launch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}",
// //    await canLaunch("https://api.barikaapp.com/api/payment/request/account?")) {
// //    await launch("https://api.barikaapp.com/api/payment/request/account?",
// //      headers: <String, String>{'user_id': '$_userid','amount': '100','account_id': '$acount',},
//             forceSafariVC: false,
//             enableJavaScript: true,
//           );
//           new DeepLinksUtil().initUniLinkdietChild(_userid,widget.id,widget.returnVal,widget.type2Str,widget.logId);
// //        Navigator.pop(context);
//           Navigator.pushReplacement(context ,MaterialPageRoute(
//             builder: (context) =>
//                 Directionality(
//                     textDirection: TextDirection
//                         .rtl, child: regimList(logId: widget.logId,user: "male",type: "children",type2: widget.type2Str,type1: widget.returnVal,userr: widget.id,)),
//           ),);
//         } else {
//           throw 'Could not launch';
//         }}
//       else{
//         await zpaychild();
//       }
//     }
//     else{
//       String orderid=   await orderID("diet",_userid,_value,account_id: "",diet_type:diet );
//       if(_value!="0"){
//         if (await canLaunch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}")) {
//           await launch("https://api.barikaapp.com/api/payment/request?order_id=${orderid}",
// //    await canLaunch("https://api.barikaapp.com/api/payment/request/account?")) {
// //    await launch("https://api.barikaapp.com/api/payment/request/account?",
// //      headers: <String, String>{'user_id': '$_userid','amount': '100','account_id': '$acount',},
//             forceSafariVC: false,
//             enableJavaScript: true,
//           );
//           DeepLinksUtil().initUniLinkdiet(_userid,widget.name,widget.id, diet);
// //        Navigator.pop(context);
//           Navigator.pushReplacement(context ,MaterialPageRoute(
//             builder: (context) =>
//                 Directionality(
//                     textDirection: TextDirection
//                         .rtl, child: regimList(user: widget.id.gender,type1:widget.name , userr: widget.id,type2:diet,type:widget.name,)),
//           ),);
//         } else {
//           throw 'Could not launch';
//         }}else{
//         await zpaydiet();
//       }
//     }
//     setState(() {
//       showLoading2=false;
//     });
//   }
//   showSnakBar(String s) {
//     _scaffoldKey.currentState.showSnackBar(new SnackBar(
//       duration: new Duration(seconds: 2),
//       backgroundColor: MyColors.vazn,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       content: Text(
//         s,
//         style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15*fontvar,fontFamily: "iransansDN"),
//         textDirection: TextDirection.rtl,
//       ),
//     ));
//   }
//   getNsme() {
//
//     if(widget.diet!=null) {
//       return "رژیم "+dietNameSelector(diet);
//     }
//     else
//       return widget.acountname;
//
//   }
//   cansel() {
//
//     setState(() {
//       _value=_value1;
//       time=0;
//     });
//   }
//
//   Future<void> zpayacount() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{
//       final response = await Provider.of<apiServices>(context,listen: false)
//           .freeAcount(_userid,acount,'Bearer '+ apiToken );
//       print(response.bodyString);
//       print(_userid);
//       print(acount);
//       if (response.statusCode == 200) {
//         final  post = json.decode(response.bodyString);
//         print(post);
//         if(post["msg"]=="success"){
//           Navigator.pop(context,"yess");
// //          Navigator.pushReplacement(context,MaterialPageRoute(
// //              builder: (context) =>
// //              Directionality(
// //                  textDirection: TextDirection
// //                      .rtl, child: storeScreen(resume: true,)),
// //    ),);
//
//
//         }
//       }
//       else {
//         print(response.statusCode.toString());
//         showSnakBar("خطا اتصال به اینترنت");
//       }
//
//     }
//     catch(e){
//       print(e.toString());
//       showSnakBar("خطا اتصال به اینترنت");
//     }
//
//   }
//
//   Future<void> zpaychild() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{
//       final response = await Provider.of<apiServices>(context,listen: false)
//           .freeDiet(_userid,diet,'Bearer '+ apiToken );
//       if (response.statusCode == 200) {
//         final  post = json.decode(response.bodyString);
//         if(post["msg"]=="success"){
//
//           Navigator.pushReplacement(context ,MaterialPageRoute(
//             builder: (context) =>
//                 Directionality(
//                     textDirection: TextDirection
//                         .rtl, child: regimList(logId: widget.logId,user: "male",type: "children",type2: widget.type2Str,type1: widget.returnVal,userr: widget.id,resume: true,)),
//           ),);
//         }
//       }
//       else {
//         print(response.statusCode.toString());
//         showSnakBar("خطا اتصال به اینترنت");
//       }
//
//     }
//     catch(e){
//       print(e.toString());
//       showSnakBar("خطا اتصال به اینترنت");
//     }
//
//   }
//
//   Future<void> zpaydiet() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{
//       final response = await Provider.of<apiServices>(context,listen: false)
//           .freeDiet(_userid,diet,'Bearer '+ apiToken );
//       if (response.statusCode == 200) {
//         final  post = json.decode(response.bodyString);
//         if(post["msg"]=="success"){
// //          typeId
//           var dietid=post["typeId"];
//
//           print(dietid.toString()+"iiiiiiiiiiiiiiiiiiiiiiiidddddddddd");
//
// //          Navigator.pushReplacement(context ,MaterialPageRoute(
// //            builder: (context) =>
// //                Directionality(
// //                    textDirection: TextDirection
// //                        .rtl, child:  regimList(user: widget.id.gender,type1:widget.name , userr: widget.id,type2:diet,type:widget.name,resume: true,)),
// //          ),);
// ////////in paeeeni
//           Navigator.pushReplacement(context,MaterialPageRoute(
//             builder: (context) =>
//                 Directionality(
//                     textDirection: TextDirection
//                         .rtl, child: questionnaire( uid: _userid,name: widget.name,id: widget.id,metype: diet,dietId:dietid.toString())),
//           ),);
//         }
//       }
//       else {
//         print(response.statusCode.toString());
//         showSnakBar("خطا اتصال به اینترنت");
//       }
//
//     }
//     catch(e){
//       print(e.toString());
//       showSnakBar("خطا اتصال به اینترنت");
//     }
//
//   }
//
//   Future<String> orderID(String type,String user_id,String amount,{String diet_type,String account_id}) async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{
//       final response = await Provider.of<apiServices>(context,listen: false)
//           .creatPay(type,amount,_discount,_disAmount,user_id,account_id,diet_type,'Bearer '+ apiToken );
//       // print(type);
//       // print(amount);
//       // print(_discount);
//       // print(_disAmount);
//       // print(user_id);
//       // print(account_id);
//       // print(diet_type);
//       // print(type);
//       // print(diet_type+"post[order]");
//       // print(_discount+"_discount");
//       // print(_disAmount+"_disAmount");
//       if (response.statusCode == 200) {
//         final  post = json.decode(response.bodyString);
//         print(diet_type+"post[order]");
//         print(post.toString());
//         if(post["msg"]=="success") {
//           print(post["order"]+"post[order]");
//           return post["order"];
//         }
//       } else {
//         print(response.statusCode.toString());
//
//         showSnakBar("خطا اتصال به اینترنت");}
//     } catch(e){
//       print(e.toString());
//
//       showSnakBar("خطا اتصال به اینترنت");
//     }
//
//
//   }
//
//   Future<void> getContry() async {
//
//     await CafebazaarMarket.initPay(rsaKey:"MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwDUtZBanwe4/WJSs/bhzpTv5EhOE5MKKYoM9EScJHAgc9UqwEjC6es/cjAo5/jQSX/baGZZr/DXTMEKLeP9+3ShWYf5BLAitwOesSkfPakAWUnP3XZRCcEp6AjQGKnsKXnwYh3D7GVzjDp9awATNQj4Z0OhQ3oxrzvvPoBnZ5l2kMFs8bHsy4GMLGUUEG6m2hHrkbcYVD2aKKpSrDf2gHmMZ7i+c47BxXFQk3QH2BUCAwEAAQ==");
//
//     Map<String,dynamic> result = await CafebazaarMarket.launchPurchaseFlow(
//         sku: "account1month", consumption: false,payload:"ourPayload");
//
//     print("result");
//     print(result);
//     print("result");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     setState(() {
//       _country=prefs.getString('country');
//     });
//
//   }
//
//   @override
//   dispose() async {
//     super.dispose();
//     await CafebazaarMarket.disposePayment();
//
//   }
// //
// //  static GlobalKey<NavigatorState> navigatorKey =
// //  new GlobalKey<NavigatorState>();
// //  @override
// //  void didChangeAppLifecycleState(AppLifecycleState state) {
// //    print(state.toString()+"AppLifecycleState");
// //    if (navigatorKey.currentContext==context&&state == AppLifecycleState.resumed) {
// //
// //      getUser();
// //      //do your stuff
// //    }
// //  }
//
//
//
//
// }
