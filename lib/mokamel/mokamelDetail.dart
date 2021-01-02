import 'dart:convert';
import 'package:barika_web/models/subSupplementsSingle.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class mokamelDetail extends StatefulWidget {
  @override
  final String singleId;

  mokamelDetail({Key key, @required this.singleId}) : super(key: key);

  State<StatefulWidget> createState() => mokamelDetailState();
}

class mokamelDetailState extends State<mokamelDetail> {
  Color textColor = Color(0xff555555);
  subSupplementSingle _subsupplement;
  bool _isLoading = true;
  bool _connection = true;
  bool _access = false;
 Widget _accseesConnection() {
   Size size = MediaQuery.of(context).size;
   if(size.width>600)size=Size(600, size.height);
    return new SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:Container(
          child:  Center(
              child: new Text('دسترسی به محتوا مجاز نیست.')
          ),
          height: size.height,
        )
    );
  }
  Widget loadingView() {
    return new Center(
        child: SpinKitCircle(
      color: MyColors.vazn,
    ));
  }

  Future<Null> _handleRefresh() async {
    await _getSupp(widget.singleId);
    return null;
  }

  void initState() {
    super.initState();
    _getSupp(widget.singleId);
  }

  Future<Map> getProducts(String cid) async {
    print('exersizeeeeeeeeeeeeeeeeecid${cid}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
   try {
     subSupplementSingle subesup;
     final response = await Provider.of<apiServices>(context, listen: false)
         .getSupplementSinglePage(cid,
         'Bearer ' + apiToken);
     if (response.statusCode == 200) {
       final post = json.decode(response.bodyString);

       print(post.toString());
       subesup = (subSupplementSingle.fromJson(post));
     } else {
       print(response.statusCode.toString());
       final  posterror = json.decode(response.error.toString());
       print(posterror["errMsg"]+"defesfsef");
       if(posterror["errMsg"]=="illegal access")
         setState(() {
           _isLoading=false;
           _access=true;
         });
     }
     return {"supplement": subesup};
   } catch(e){
     return {"supplement": []};
     print(e);
     setState(() {
       _connection=false;
     });
   }
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
  _getSupp(String cid) async {
    if (await checkConnectionInternet()) {
      var response = await getProducts(cid);
      if(response!=null&&response['supplement']!=null){
      setState(() {
        _subsupplement = (response['supplement']);


        _isLoading = false;
        _connection = true;
      });
    } else {
      setState(() {
        _connection = false;
        _isLoading = false;
      });
    }
  }else {
      setState(() {
        _connection = false;
        _isLoading = false;
      });
    }}

  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size size = MediaQuery.of(context).size;
    if(size.width>600)size=Size(600, size.height);

    return Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
      child: !_connection && !_isLoading
          ? _errorConnection()
          : _isLoading
              ? loadingView()
              :      _access?_accseesConnection()
          :Container(
                  margin: EdgeInsets.only(top: 12, bottom: 0),
                  child: new ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    child: new ClipRRect(
                                      borderRadius: new BorderRadius.horizontal(
                                          right: Radius.circular(15),
                                          left: Radius.circular(15)),
                                      child: FadeInImage(
                                        placeholder: AssetImage(
                                            'assets/images/placeholder.png'),
                                        image: NetworkImage(_subsupplement.cover),
                                        fit: BoxFit.fill,
                                        height: 125*(size.width)/375,
                                        width: 135*(size.width)/375,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 8, right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${_subsupplement.name}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15*fontvar,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '${_subsupplement.company}',
                                          style: TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontSize: 12*fontvar,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          ' ',
                                          style: TextStyle(
                                              color: Color(0xffA2A2A2),
                                              fontSize: 12*fontvar,
                                              fontWeight: FontWeight.w400),
                                          maxLines: 2,
                                        )
                                      ],
                                    ),
                                  )),
                                  IconButton(
                                    icon: Icon(
                                      Icons.chevron_right,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    alignment: Alignment.topLeft,
                                    color: MyColors.green,
                                    splashColor: Colors.amber,
                                    // padding: EdgeInsets.only(top: 15, left: 7),
                                  ),
                                ],
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'عملکرد',
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      '${_subsupplement.operation}',
                                      style: TextStyle(
                                          color: Color(0xff7e7e7e),
                                          fontSize: 12*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),

                                    Text(
                                      'طریقه مصرف',
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                      Text('${_subsupplement.usage}',
                                      style: TextStyle(
                                          color: Color(0xff7e7e7e),
                                          fontSize: 12*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),

                                    Text(
                                      'ترکیبات',
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' ${_subsupplement.materials}',
                                      style: TextStyle(
                                          color: Color(0xff7e7e7e),
                                          fontSize: 12*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),

                                    Text(
                                      'تداخلات',
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' ${_subsupplement.interactions}',
                                      style: TextStyle(
                                          color: Color(0xff7e7e7e),
                                          fontSize: 12*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),

                                    Text(
                                      'موارد منع مصرف',
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' ${_subsupplement.prohibited}',
                                      style: TextStyle(
                                          color: Color(0xff7e7e7e),
                                          fontSize: 12*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'هشدار',
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' ${_subsupplement.warning}',
                                      style: TextStyle(
                                          color: Color(0xff7e7e7e),
                                          fontSize: 12*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              );
                      })),
      onRefresh: _handleRefresh,
    ));
  }
}
