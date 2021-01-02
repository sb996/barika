import 'dart:convert';
import 'package:barika_web/models/allRecipes.dart';
import 'package:barika_web/models/subRecipes.dart';
import 'package:barika_web/regimiFood/regimiFoodDetail.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class regimiFoodCat extends StatefulWidget {
  @override
  allRecipes allRec;
  int etebar;
  regimiFoodCat({Key key,this.allRec ,this.etebar}) : super(key: key);

  State<StatefulWidget> createState() => regimiFoodCatState();
}

class regimiFoodCatState extends State<regimiFoodCat> {
  Color textColor = Color(0xff555555);
  List<subRecipes> subRecipe=[];
  List<allRecipes> _allCat = [];
  bool _isLoading = true;
  bool _connection = true;
  bool nextPage=true;
  int _currentPage = 1;
  ScrollController _listScrollController = new ScrollController();
  int etebar;
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
  Widget loadingView() {
    return new Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }
  Future<Null> _handleRefresh() async {
    await _getphoto( cid:widget.allRec.id,refresh: true);

    return null;
  }
  Widget listIsEmpty() {
    return new Center(
      child: new Text('این دسته خالی است.'),
    );
  }

  Future <Map> getProducts(String cid,String page) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      List<subRecipes> subRecip =[];
      List<allRecipes> cats =[];
      final response = await Provider.of<apiServices>(context,listen: false)
        .getSubRecipes(
        {'category':cid,'page':page},
        'Bearer '+apiToken);
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);

      post["data"].forEach((item) {
        print(item.toString()+"km");
        subRecip.add(subRecipes.fromJson(item));
        print(subRecip.length.toString()+"km");
      });
      post["children"].forEach((item) {
        print(item.toString()+"km");
        cats.add(allRecipes.fromJson2(item));
        print(cats.length.toString()+"km");
      });
print(subRecip.length.toString()+"deslkfl");
print("deslkfl");
     }
    else {
      print(response.statusCode.toString());
    }
    return {
      "supplement" : subRecip,
      "cats" : cats,
    };
    }

    catch(e){
      return {
        "supplement" : [],
        "cats" : [],
      };
      setState(() {
        _connection=false;
      });
    }
  }

  _getphoto({String cid, bool refresh : false,String page='1'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if( await checkConnectionInternet()) {
      var response = await getProducts(cid,page);
      print((response['supplement']).toString()+"jknkn");
      setState(() {
        if(refresh){ subRecipe.clear();_allCat.clear();_currentPage=1;nextPage=true;  print(_currentPage.toString());}
        List<subRecipes> list=(response['supplement']);
        if(list.isEmpty){nextPage=false;print('hjh');}
        print((response['supplement']));
        subRecipe.addAll(response['supplement']);
        _allCat=(response['cats']);
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

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      etebar=widget.etebar;
      _getphoto(cid:widget.allRec.id);
      _listScrollController.addListener(() {
        double maxScroll = _listScrollController.position.maxScrollExtent;
        double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
        if(maxScroll == currentScroll) {
          print('scroll');
          if(! _isLoading && nextPage) {
            print(_currentPage.toString()+nextPage.toString());
            _currentPage=_currentPage+1;
            _getphoto(page : _currentPage.toString(),cid:widget.allRec.id);
          }
        }

      });

    }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

    return new Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(top: 25),
            alignment: Alignment.topCenter,
            height:  100*(screenSize.width)/375,
            width: screenSize.width,
            decoration: new BoxDecoration(
             color: MyColors.green
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size:  32,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  splashColor: Colors.amber,
                  padding: EdgeInsets.only(top: 15, left: 7),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: CircleAvatar(
                          radius:  25*(screenSize.width)/375,
                          backgroundImage: NetworkImage(
                              widget.allRec.cover),

                          backgroundColor: Colors.white,
                        )),
                    Text(
                      widget.allRec.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16*fontvar,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight( 60*(screenSize.width)/375,),
        ),
        body:new RefreshIndicator(
          key: _refreshIndicatorKey,
          child:
        !_connection && !_isLoading
            ? _errorConnection()
            :subRecipe.length == 0 &&   _allCat.length==0 &&_isLoading
            ? loadingView()
            : subRecipe.length == 0&&   _allCat.length==0
            ? listIsEmpty()
            :  CustomScrollView(
            controller: _listScrollController,
            slivers: <Widget>[
              SliverGrid.count(

                  childAspectRatio: 3.8,
                  crossAxisCount: 2,
                  children:
                  makeRadios()

              ),
              SliverList(

                  delegate: SliverChildListDelegate(
                      makeRadios2()
                  )
              )]),

          onRefresh:
            _handleRefresh

        ),
      );
    }
  List<Widget> makeRadios() {
    List<Widget> list = new List<Widget>();

    for (int i = 0; i < _allCat.length; i++) {
      list.add(
          GestureDetector(
            onTap:(){ Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:regimiFoodCat(allRec: _allCat[i],etebar: etebar,)),
              ),
            );}    ,
            child:  Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),

                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: MyColors.green),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child:Text(_allCat[i].name)),
          )


      );
    }
    return list;

//      Container(
//      child: GridView.builder(
//          itemCount: units.length,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 2,
//            childAspectRatio: 3.5,
//          ),
//          itemBuilder: (BuildContext context, int index) {
//            return list[index];
//          }),
//    );
  }
  List<Widget> makeRadios2() {
    List<Widget> list = new List<Widget>();


    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    for (int index = 0; index < subRecipe.length; index++) {
      list.add(
          GestureDetector(
            child: Container(
              height:  120*(screenSize.width)/375,
              child: Card(

                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     ClipRRect(
                      borderRadius: new BorderRadius.horizontal(
                          right: Radius.circular(15),
                          left: Radius.circular(0)),
                      child:  subRecipe[index].free==0 &&  etebar<0
                          ?Stack(
                        children: <Widget>[
                          FadeInImage(
                            placeholder:
                            AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(subRecipe[index].cover),
                            fit: BoxFit.cover,
                            height:  115*(screenSize.width)/375,
                            width:  95*(screenSize.width)/375,
                          ),
                          Container(
                            color: Colors.green.withOpacity(0.6),
                            child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
                            height:  115*(screenSize.width)/375,
                            width:  95*(screenSize.width)/375,
                          )
                        ],
                      ):FadeInImage(
                        placeholder:
                        AssetImage('assets/images/placeholder.png'),
                        image: NetworkImage(subRecipe[index].cover),
                        fit: BoxFit.cover,
                          height:  115*(screenSize.width)/375,
                          width:  95*(screenSize.width)/375,
                      ),
                    ),
                    Expanded(
                      child: Container(

                        child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8, right: 6),
                            child: Text(
                              subRecipe[index].name,
                              style: TextStyle(
                                  color: Color(0xff334856),
                                  fontSize: 13*fontvar,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3, right: 6),
                            child: Text(
                              subRecipe[index].description,
                              style: TextStyle(
                                  color: Color(0xff334856),
                                  fontSize: 11*fontvar,
                                  fontWeight: FontWeight.w400),
                              maxLines: 2,
                            ),
                          ),

                          Expanded(
                            child: Container(

                                alignment: Alignment.bottomCenter,
                                padding:
                                EdgeInsets.only(top: 8, right: 6,bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[



                                Expanded(flex:1,child: Row(
                                  children: <Widget>[      Image.asset(
                                          'assets/icons/btm_profile.png',
                                          height:15*(screenSize.width)/375,
                                          width: 15*(screenSize.width)/375,
                                        ),
                                    Flexible(child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 2, left: 5, top: 2),
                                          child: Text(
                                            '${subRecipe[index].consumer} نفر',
                                            style: TextStyle(
                                                color: Color(0xffA2A2A2),
                                                fontSize: 9*fontvar,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                          ),
                                        ),),
                                  ],
                                )),
                                    Expanded(flex:3,child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/calories.png',
                                    height:15*(screenSize.width)/375,
                                    width: 15*(screenSize.width)/375,),
                                  Flexible(child:   Padding(
                                    padding: EdgeInsets.only(
                                        right: 2, left: 5, top: 2),
                                    child: Text(
                                      '${subRecipe[index].total_calorie} کالری برای یک نفر',
                                      style: TextStyle(
                                          color: Color(0xffA2A2A2),
                                          fontSize: 9*fontvar,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                  ))
                                ],
                                )),

                                       Expanded(flex:2,child: Row(
                                         mainAxisAlignment: MainAxisAlignment.end,
                                         children: <Widget>[
                                           Image.asset(
                                             'assets/icons/clock.png',
                                             height:15*(screenSize.width)/375,
                                             width: 15*(screenSize.width)/375,
                                           ),
                                           Expanded(child:Padding(
                                             padding: EdgeInsets.only(
                                                 right: 2, left: 0, top: 2),
                                             child: Text(
                                               '${subRecipe[index].time}',
                                               style: TextStyle(
                                                   color: Color(0xffA2A2A2),
                                                   fontSize: 9*fontvar,
                                                   fontWeight: FontWeight.w500),
                                               maxLines: 1,
                                             ),
                                           )),
                                         ],
                                       ))

                                  ],
                                )),
                          )
                        ],
                      ),)
                    )
                  ],
                ),
              ),
            ),
            onTap:() {
            subRecipe[index].free==0 &&  etebar<0?showSnakBar("شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید."):


              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:regimiFoodDetail(catId:  subRecipe[index].id)),
              ),
            );},


      ));
    }
    return list;

//      Container(
//      child: GridView.builder(
//          itemCount: units.length,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 2,
//            childAspectRatio: 3.5,
//          ),
//          itemBuilder: (BuildContext context, int index) {
//            return list[index];
//          }),
//    );
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

}

