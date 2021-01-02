import 'dart:convert';

import 'package:barika_web/models/peyment.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';
class PeymentHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PeymentHistoryState();
}

class PeymentHistoryState extends State<PeymentHistory> {
  String _type="";
  List<Peyment>_peyment=[];
  bool _isLoading = true;
  bool _connection = true;

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

                      await _getSup();
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
  Widget loadingView() {
    return  Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }
  Widget listIsEmpty() {
    return  Center(
      child: new Text('این دسته خالی است.'),
    );
  }
  void initState() {
    _getSup();
    super.initState();}

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

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 85,
            title: Text(
              'لیست تراکنش ها',
              style: TextStyle(
                  fontSize: 14*fontvar, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  size:  32*(screenSize.width)/375,
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
          body:  !_connection && !_isLoading
              ? _errorConnection()
              :  _peyment.length == 0 && _isLoading
              ? loadingView()
              : _peyment.length == 0
              ? listIsEmpty()
              : ListView.builder(
            itemCount: _peyment.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical:0),
                  child: Container(
                 child:GestureDetector(child: Card(
                  child: Row(
                    children: <Widget>[
                    Container(
                      height:  80*(screenSize.width)/375,
                      child:   VerticalDivider(
                        color: _peyment[index].status=="failed"
                            ?Colors.red
                            :Colors.green,
                        thickness: 4,
                      ),
                    ),
                      Expanded(child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_peyment[index].title
                                    ,style: TextStyle(fontSize: 12*fontvar)),
                                Text(
                                  _peyment[index].payment_type=="euro"
                                      ? _peyment[index].amount +" "+"یورو"
                                      : _peyment[index].amount +" "+"تومان",


                                  style: TextStyle(fontSize: 12*fontvar),)
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("کدرهگیری "+_peyment[index].code,style: TextStyle(fontSize: 12*fontvar)),
                                Text(_peyment[index].created_at,style: TextStyle(fontSize: 12*fontvar)),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          )
                        ],
                      ),)
                    ],
                  )
                ),
                  onTap:(){}),
                 margin: EdgeInsets.symmetric(vertical: 1,horizontal: 2),)
              );})
        ));
  }
  Future <Map> getProducts(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      List<Peyment> Peyments =[];
      final response = await Provider.of<apiServices>(context,listen: false)
          .getPayHistory('Bearer '+ apiToken );
      if (response.statusCode == 200) {

        final  post = json.decode(response.bodyString);

        print(post.toString());
        post["data"].forEach((item) {
          Peyments.add(Peyment.fromJson(item));
        });
        print(Peyments.length);
      }
      else {
        print(response.statusCode.toString());
      }
      return {
        "Peyments" : Peyments??[]
      };
    }
    catch(e){
      setState(() {
        _connection=false;
      });
      return {
        "Peyments" :[]
      };
    }
  }
  _getSup({ bool refresh : false,String page='1'})async {
    if( await checkConnectionInternet()) {
      var response = await getProducts(page);
      setState(() {
        if(refresh) {_peyment.clear();}

        _peyment.addAll(response['Peyments']);

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
}

