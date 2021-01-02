import 'dart:convert';

import 'package:barika_web/models/faq.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class questionScreen extends StatefulWidget {
  State<StatefulWidget> createState() => questionScreenState();
}

class questionScreenState extends State<questionScreen> {
  var fontvar=1.0;
  bool _isLoading = true;
  bool _isLoading2 = false;
  bool _connection = true;
  List<faq> _allfaq=[];
  Widget loadingView() {
    return new Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }
  Widget listIsEmpty() {
    return new Center(
      child: new Text('این دسته خالی است.'),
    );
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Widget _errorConnection() {

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return new SingleChildScrollView(
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);


    return new Scaffold(

        body:
        new RefreshIndicator(
          key: _refreshIndicatorKey,
          child:new Stack(

              children: <Widget>[
          Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 30),
          height:200*(screenSize.width)/375,
            width:  MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
        color: MyColors.green),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  size: 32*(screenSize.width)/375,
                ),
                onPressed: () {Navigator.pop(context);},
                alignment: Alignment.topLeft,
                color: Colors.white,
                splashColor: Colors.amber,
                padding: EdgeInsets.all(7),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      'سوالات متداول',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16*fontvar,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

                FutureBuilder(
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.done)
                      {
                        print(snapshot.toString());
                        return  !_connection && !_isLoading
                            ? _errorConnection()
                            : _allfaq.length == 0 && _isLoading
                            ? loadingView()
                            : _allfaq.length == 0
                            ? listIsEmpty()
                            :  _isLoading || _isLoading2
                            ? loadingView()
                            :  Container(
            margin: EdgeInsets.only(top: 85,right: 15,left: 15),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              }, child:   Card(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              elevation: 10,
              child:ListView.builder(

                itemCount: _allfaq.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    new Container(
                      padding: EdgeInsets.only(right: 12,left:12,bottom:10,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top:3,left: 5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          spreadRadius: 1)
                                    ],
                                    color:Color(0xffF15A23) ,
                                    shape: BoxShape.circle
                                ),

                                height:10*(screenSize.width)/375,
                                width: 10*(screenSize.width)/375,
                              ),
                              Flexible(
                                  child:Text(_allfaq[index].question,
                                    style: TextStyle(
                                      color:Color(0xff5C5C5C) ,
                                      fontSize: 11*fontvar,
                                      fontWeight: FontWeight.w500,

                                    ),)
                              )
                            ],
                          ),

                          Text(_allfaq[index].answer,    style: TextStyle(
                              color:Color(0xff5C5C5C) ,
                              fontSize: 11*fontvar,
                              fontWeight: FontWeight.w400,

                            ),),


                        ],


                      ),
                    );



                }),),
          ),
        );

                      }
                      else return loadingView();
                    },
                    future: _getAlbums()),
              ]),

          onRefresh: _handleRefresh,
        ));



  }
  Future<Null> _handleRefresh() async {
    await _getAlbums2(refresh: true);
    return null;
  }
  _getAlbums({ bool refresh : false}) async {
    if( await checkConnectionInternet()) {
      var response = await getProducts();
//        setState(() {
      _allfaq.clear();
      _allfaq.addAll(response['stores']);
      _isLoading=false;
      _connection=true;
    }
    else{
//      setState(() {
      _connection=false;
      _isLoading=false;
//      });
    }
  }
  _getAlbums2({ bool refresh : false}) async {
    if( await checkConnectionInternet()) {
      var response = await getProducts();
        setState(() {
      _allfaq.clear();
      _allfaq.addAll(response['stores']);
      _isLoading=false;
      _connection=true;
    });}
    else{
      setState(() {
      _connection=false;
      _isLoading=false;
      });
    }
  }
  Future <Map> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    final response = await Provider.of<apiServices>(context,listen: false).getFAQ(
        'Bearer '+apiToken);
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);
      print(post);
      List<faq> stores =[];

      post.forEach((item) {
        stores.add(faq.fromJson(item));
      });
      return {
        "stores" : stores
      };}
    else {
      print(response.statusCode.toString());
    }
  }
}
