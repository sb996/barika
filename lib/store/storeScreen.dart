
import 'dart:convert';
import 'package:barika_web/models/store.dart';
import 'package:barika_web/models/storeUnit.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/store/storeDialog.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart'as intl;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';
import 'Firstpayment.dart';


class storeScreen extends StatefulWidget {
  bool resume;
  bool menu;
  User user;
  @override
  storeScreen({Key key,this.resume,this.menu,this.user}) : super(key: key);

  State<StatefulWidget> createState() => storeScreenState();
}

class storeScreenState extends State<storeScreen> with  WidgetsBindingObserver, AutomaticKeepAliveClientMixin<storeScreen>  {
  @override
  bool get wantKeepAlive => true;
  List<store> _allStores=[];
  bool _isLoading = true;
  bool _isLoading2 = false;
  bool _connection = true;
  bool _menu = true;
  String _value="";
  String _unit="";
  String _userContry="";
  User _user;
  String _apkType="صثذ";
  // List<storeUnit> _storeUnit = [];
  final formatter = new intl.NumberFormat("###,###");
  Widget loadingView() {
    return  Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }
  Widget listIsEmpty() {
    return  Center(
      child:  Text('این دسته خالی است.'),
    );
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Widget _errorConnection() {

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return  SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:Container(
          child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('مشکلی در برقراری ارتباط با سرور پیش آمده است لطفا وضعیت اینترنت خود را بررسی کنید و مجددا تلاش کنید',textAlign: TextAlign.center,),
                  FlatButton(
                    onPressed: () async {
                      _refreshIndicatorKey.currentState.show();
                      await _handleRefresh();
                    },
                    color: MyColors.vazn,
                    child: Text('تلاش مجدد',textAlign: TextAlign.center,style: TextStyle(

                        color: Colors.white
                    ),),
                  )
                ],
              )
          ),
          height: screenSize.height,
        )
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _menu=widget.menu??false;
    _user=widget.user;
    _allStores.clear();
    _getAlbums();

//    if(widget.resume!=null && widget.resume ){
//      getUser();
//    }

  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {

    if (state == AppLifecycleState.resumed) {
     await getUser(resu:"resume");
      //do your stuff
    }
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
    return
      WillPopScope(
        onWillPop:   () async {
      if(_menu&&_user!=null) Navigator.pop(context, _user);
      else Navigator.pop(context, 'yes');
      return false;
    },
    child: Scaffold(
        key: _scaffoldKey,
        body:
         RefreshIndicator(
          key: _refreshIndicatorKey,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20,right: 12,left:12),
                height: 200*(screenSize.width)/375,
                width:MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                color: MyColors.green
                ),
                child:


                    Column(
                     children: <Widget>[
                       Stack(


                         children: <Widget>[
                       Padding(padding: EdgeInsets.only(top: 15,bottom: 8),
                         child:  Center(
                           child:  Text('فروشگاه',
                             style: TextStyle(
                               color: Colors.white,
                               fontWeight:FontWeight.w700 ,
                               fontSize: 16*fontvar,
                             ),
                             textAlign: TextAlign.center,),
                         )
                           ),
                  _menu
                      ?     Align(
                         alignment: Alignment.centerLeft,
                         child:     IconButton(
                           icon: Icon(
                             Icons.chevron_right,
                             size: 32*(screenSize.width)/375,
                           ),
                           onPressed: () {
                             if(_menu) Navigator.pop(context, _user);
                             else Navigator.pop(context, 'yes');
                           },
                           alignment: Alignment.topLeft,
                           color: Colors.white,
                           splashColor: Colors.amber,
                           padding: EdgeInsets.all(7),
                         ) ,

                       )
                      :Container(
                    height: 0,width: 0,
                  )

      ]),
                      Text('با خرید اشتراک برنامه باریکا بخش های تعیین هدف، مکمل های غذایی، حرکات ورزشی و دستور پخت غذاهای رژیمی برای شما فعال خواهد شد.',style: TextStyle(
                         color: Colors.white,
                         fontWeight:FontWeight.w400 ,
                         fontSize: 14*fontvar,
                       ),textAlign: TextAlign.center,),
                      ],

                ),
              ),

              !_connection && !_isLoading
                            ? _errorConnection()
                            : _allStores.length == 0 && _isLoading
                            ? loadingView()
                            : _allStores.length == 0
                            ? listIsEmpty()
                            :  _isLoading || _isLoading2
                            ? loadingView()
                            : Container(
                            margin: EdgeInsets.only(top: 145*(screenSize.width)/375),

                    child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    },
                    child:ListView.builder(
                            itemCount: _allStores.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  GestureDetector(
                                child:   new Container(
                                  height: 130*(screenSize.width)/375,
                                  margin: EdgeInsets.only(right: 10,left: 10),
                                  alignment: Alignment.center,
                                  child: new Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.all(6),
                                            child: ClipRRect(

                                              borderRadius: new BorderRadius.circular(8.0),
                                              child: FadeInImage(
                                                alignment: Alignment.centerRight,
                                                placeholder:
                                                AssetImage('assets/images/placeholder.png'),
                                                image: NetworkImage(_allStores[index].cover),
                                                fit: BoxFit.fill,
                                                height: 60*(screenSize.width)/375,
                                                width: 75*(screenSize.width)/375,

                                              ),
                                            )),


                                        Expanded(child:Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            new Padding(
                                              padding: EdgeInsets.only(top: 8,right: 5),
                                              child: new Text(
                                                _allStores[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13*fontvar,
                                                    color: Color(0xff5C5C5C)),
                                              ),
                                            ),
                                            new Padding(
                                              padding: EdgeInsets.only(top: 2,right: 5),
                                              child: new Text(
                                                _allStores[index].description,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11*fontvar,
                                                    color: Color(0xffA2A2A2)),

                                                maxLines: 2,
                                              ),
                                            ),
                                            Expanded(child:

                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child:
                                                Padding(padding: EdgeInsets.only(left: 5),
                                                  child: Container(
                                                    decoration:BoxDecoration(
                                                        borderRadius:
                                                         BorderRadius.circular(5.0),
                                                        color: Color(0xff6DC07B)

                                                    ),

                                                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                    margin: EdgeInsets.only(left: 5,bottom: 7),
                                                    child:  Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Image.asset('assets/icons/store.png',width: 12*(screenSize.width)/375,height:12*(screenSize.width)/375,),
                                                        Padding(padding: EdgeInsets.only(top: 3,),child:  Text(
                                                            _userContry=="98"
                                                                ? formatter.format(_allStores[index].pricetoman)
                                                                : formatter.format(int.parse(_allStores[index].price_euro)),


                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12*fontvar,
                                                              color: Colors.white),
                                                          maxLines: 2,
                                                        ),),
                                                         Text(
                                                           _userContry=="98"?' تومان':" یورو",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 10*fontvar,
                                                              color: Colors.white),
                                                          maxLines: 2,
                                                        ),
                                                      ],

                                                    ),

                                                  ),)

                                            ))
                                          ],
                                        ))


                                      ],
                                    ),

                                    elevation: 7,
                                  ),
                                ),
                                onTap: () async {

                                  String returnVAl=await showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 30),child:  Dialog(
                                          elevation: 15,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          child:  Directionality(textDirection: TextDirection.rtl,
                                              child: storeDialog(
                                                allStores: _allStores[index] ,
                                                value:_userContry=="98"?_allStores[index].pricetoman:int.parse(_allStores[index].price_euro) ,
                                                country: _userContry,
                                              )

                                      )
                                      ));});
                                  print(returnVAl);
                                  if(returnVAl=="yess"){
                                    String returnVal2=await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Directionality(
                                                textDirection: TextDirection.rtl, child: FirstPayment(country: _userContry,amount:  _userContry=="98"?_allStores[index].pricetoman.toString():_allStores[index].price_euro,acount: _allStores[index].id,acountname:  _allStores[index].name,sku:_allStores[index].sku,apkType: _apkType,
                                            ),
                                      ),
                                    ));

                                    if(returnVal2=="yess"){
                                    await getUser();
                                    }


                                  }





                                  },

                              );


                            }),

                    )

              )]),

        onRefresh: _handleRefresh,
      )));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  Future <Map> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    final response = await Provider.of<apiServices>(context,listen: false).getStoreInfo2(
        'Bearer '+apiToken);
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);
      print(post['user']);

      User users;
      users=(User.fromJson(post['user']));
      if (this.mounted){setState(() {
        _user=users;
        _userContry=users.country;
      });}
      await updateDb(users);

      if( prefs.getString("country")==null) {

        print("dfdfdfdfdfdfdfdfdfdfdfd");
        await prefs.setString('country', _user.country);}

      List<store> stores =[];

      post["data"].forEach((item) {
        print(store.fromJson(item).sku);
        if(_apkType=="bazaar") {
          if (store.fromJson(item).sku!=null&&store.fromJson(item).sku!="")
            stores.add(store.fromJson(item));}
        else{
          stores.add(store.fromJson(item));
        }

      });



      return {
        "stores" : stores
      };}
    else {
      print(response.statusCode.toString());
    }
  }

  _getAlbums({ bool refresh : false}) async {
    if( await checkConnectionInternet()) {
      var response = await getProducts();
      List<storeUnit> _storeUnit1 = [];
      if (this.mounted){ setState(() {
        _allStores.clear();
        _allStores.addAll(response['stores']);
        _allStores.forEach((item) {
          print(item.id);
          item.price.forEach((prices) {
            _storeUnit1.add(storeUnit.fromJson(prices));
          });
        });

//        _storeUnit1.forEach((prices) {
//
//            prices.unit=='toman'?
//            _storeUnit.add(prices):(){};
//          });

        _isLoading=false;
        _connection=true;
      });}}
    else{
      if (this.mounted){ setState(() {
        _connection=false;
        _isLoading=false;
      });}
    }
  }
   Future<Null> _handleRefresh() async {
    await _getAlbums(refresh: true);
    // _refreshIndicatorKey.currentState.deactivate();
    return null;
  }
   Future<User> updateDb(User user) async {
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
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15*fontvar,fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }
   Future getUser({String resu}) async {
    if(mounted) {
      setState(() {
        _isLoading2 = true;
      });}


    print('USErrR');
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
        await updateDb(users[0]);

        String result;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(users[0].account);
        print("acount");

        if(mounted) { setState(() {
          _user=users[0];
          _isLoading2 = false;
        });}
        if(resu==null)
        showSnakBar("با موفقیت اعمال شد.");
        return true;

      } else {
        print(response.statusCode.toString());
        if(mounted) {setState(() {
          _isLoading2 = false;
        });}
        showSnakBar("خطا در دریافت اطلاعات");
        return false;
      }
    }catch(e){
      print(e.toString());
      if(mounted) { setState(() {
        _isLoading2 = false;
      });}
      showSnakBar("خطا در دریافت اطلاعات");
      return false;

    }





  }


}
