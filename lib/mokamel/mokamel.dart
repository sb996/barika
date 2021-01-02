import 'dart:convert';
import 'package:barika_web/models/allSupplements.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import '../helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mokamelCat.dart';


class mokamel extends StatefulWidget {
  String acountDate;
  @override
  mokamel({Key key,this.acountDate}) : super(key: key);

  State<StatefulWidget> createState() => mokamelState();
}

class mokamelState extends State<mokamel>{
  Color textColor=Color(0xff555555);
  List<allSupplements> _allsup =[];
  ScrollController _listScrollController = new ScrollController();
  bool nextPage=true;
  int _currentPage = 1;
  bool _isLoading = true;
  bool _connection = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Widget _errorConnection() {

    Size screenSize = MediaQuery.of(context).size;
    // if(screenSize.width>600)screenSize=Size(600, screenSize.height);

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
  String acountDate;
  String serverDate;
  int etebar=-1;
  void initState() {
    super.initState();
    acountDate=widget.acountDate;
    _allsup.clear();
    _getSup();
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        print('scroll');
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
          _getSup(page : _currentPage.toString());
        }
      }

    });
  }
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
  Future<Null> _handleRefresh() async {
    await _getSup(refresh: true);
    return null;
  }


  Future <Map> getProducts(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    List<allSupplements> supplements =[];
   try{

     final response = await Provider.of<apiServices>(context,listen: false)
        .getSupplement(
        {'type':'supplement','page':page},
        'Bearer '+ apiToken );
    if (response.statusCode == 200) {

      final  post0 = json.decode(response.bodyString);
      final  post = post0["0"];
      serverDate =post0["server_date"];
      getEtebar();
      post.forEach((item) {
        supplements.add(allSupplements.fromJson(item));
      });
      print(supplements.length);
    }
    else {
      print(response.statusCode.toString());
    }
   return {
     "supplements" : supplements
   };
   }
    catch(e){
      return {
        "supplements" : supplements
      };
     setState(() {
       _connection=false;
     });

    }
  }
  _getSup({ bool refresh : false,String page='1'})async {
    if( await checkConnectionInternet()) {
    var response = await getProducts(page);
    if(mounted) {setState(() {
      if(refresh) {_allsup.clear();_currentPage=1;nextPage=true;  print(_currentPage.toString()+"page");}
      List<allSupplements> list=(response['supplements']);
      if(list.isEmpty){nextPage=false;print('hjh');}
      print((response['supplements']));
      _allsup.addAll(response['supplements']);
      _isLoading=false;
      _connection=true;
    });}}
    else{
      if(mounted) {  setState(() {
        _connection=false;
        _isLoading=false;
      });}
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

    Size size = MediaQuery.of(context).size;
    // if(size.width>600)size=Size(600, size.height);
    print("size.width"+size.width.toString());
    return  Scaffold(
      appBar: AppBar(
        leading:    Padding(padding: EdgeInsets.only(top: 12,bottom: 8),
    child: Image.asset('assets/icons/mokamel.png',
          height: 25*(size.width)/375,
          width:30*(size.width)/375 ,
    fit: BoxFit.fill,
    )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[ IconButton(icon: Icon(Icons.chevron_right,size:32,),
          onPressed: (){Navigator.of(context).pop();},
          alignment: Alignment.centerLeft,
          color: Colors.white,
          splashColor: Colors.amber,
          // padding: EdgeInsets.all(7),

        ),],
        title:       Text('مکمل غذایی',style: TextStyle(
          color: Colors.white,
          fontWeight:FontWeight.w700 ,
          fontSize: 16*fontvar,
        ),textAlign: TextAlign.center,) ,
      ),


        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child:
//                Container(
//                  alignment: Alignment.topCenter,
//                  height: 80,
//                  margin: EdgeInsets.only(top: 0),
//                  width: MediaQuery.of(context).size.width,
//                  decoration: new BoxDecoration(
//                    gradient:LinearGradient(
//                      colors: [
//                        new Color(0xff63B337),
//                        new Color(0xff6DB93D),
//                        new Color(0xff95D357),
//                        new Color(0xffA8E063),
//                      ],
//                      begin: Alignment.centerLeft,
//                      end: Alignment.bottomRight,
//                      stops: [0.1, 0.4, 0.8, 0.9],
//                    ),
//                  ),
//                ),
          !_connection && !_isLoading
              ? _errorConnection()
              :  _allsup.length == 0 && _isLoading
                    ? loadingView()
                    : _allsup.length == 0
                    ? listIsEmpty()
                    :     Container(
                  child: GridView.builder(
                      itemCount: _allsup.length,
                      controller: _listScrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:size.width>600? 3:2,
                          childAspectRatio: size.width>600? 1.2: 0.9
                          // childAspectRatio: size.width>600? 1.2: 0.9
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child:Container(
                            margin:
                            EdgeInsets.only(right:8, left:8, bottom: 10),
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top:size.width>600
                                      ?(((size.width/3.5)*(1.8/3))/2)
                                      :(((size.width/2)*(1.8/3))/2)),
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    borderRadius:  BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                        // has the effect of softening the shadow
                                        spreadRadius: 1.0,
                                        // has the effect of extending the shadow
                                        offset: Offset(
                                          0.0, // horizontal, move right 10
                                          0.0, // vertical, move down 10
                                        ),
                                      )
                                    ],

                                  ),
                                  height:size.width>600
                        ?(size.width/1.5)*(1.6/3)
                        :(size.width/2)*(1.6/3),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: Text(
                                      _allsup[index].name,
                                      style: TextStyle(
                                          color: Color(0xff334856),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                  ),),
                                Container(
                                    alignment: Alignment.center,
                                    width:size.width>600
                                        ? (size.width/3.5)*(1.8/3)
                                        : (size.width/2)*(1.8/3),

                                    height:size.width>600
                                        ?(size.width/3.5)*(1.8/3)
                                        :(size.width/2)*(1.8/3),
                                    margin:EdgeInsets.only(top: 10),
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,

                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5.0,
                                          // has the effect of softening the shadow
                                          spreadRadius: 1.0,
                                          // has the effect of extending the shadow
                                          offset: Offset(
                                            0.0,
                                            // horizontal, move right 10
                                            0.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),

                                    child:
                                    ClipOval(
                                      child: FadeInImage(
                                        placeholder: AssetImage(
                                            'assets/images/placeholder.png'),
                                        image: NetworkImage(_allsup[index].cover,),
                                        fit: BoxFit.cover,
                                        width:(size.width/2)*(1.8/3),
                                        height:(size.width/2)*(1.8/3),
                                      ),


                                    )
                                )
                              ],
                            ),
                          ),
                          onTap: (){ Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Directionality(textDirection: TextDirection.rtl, child:mokamelCat(supCat: _allsup[index],etebar:etebar)),
                            ),
                          );},

                        );

                      }),),


            onRefresh: _handleRefresh,
          ));

  }
  void getEtebar() {

    if(serverDate!=null && acountDate !=null && acountDate !=""){
      var persianDateee = PersianDateTime(jalaaliDateTime: acountDate);
      var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
      DateTime datetoday = DateTime.parse(serverDate);
      DateTime dateacount= DateTime.parse(dateEtebarstr);
      print(dateacount
          .difference(datetoday)
          .inDays
          .toString()+"fffffffffffffffffff");
      etebar =dateacount.difference(datetoday).inDays;
    }

  }
}
