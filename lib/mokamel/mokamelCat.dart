
import 'dart:convert';

import 'package:barika_web/models/allSupplements.dart';
import 'package:barika_web/models/subSupplement.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';
import 'mokamelDetail.dart';


class mokamelCat extends StatefulWidget {
  @override
  final allSupplements supCat;
  int etebar;
  mokamelCat({Key key,this.supCat,this.etebar}) : super(key: key);

  State<StatefulWidget> createState() => mokamelCatState();
}

class mokamelCatState extends State<mokamelCat>{

  Color textColor=Color(0xff555555);
  List<subSupplement> _subSupplement = [];
  List<allSupplements> _allCat = [];
  bool _isLoading = true;
  String _cid;
  int _currentPage = 1;
  bool _connection = true;
  bool nextPage=true;
  int etebar;

  ScrollController _listScrollController = new ScrollController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Widget _errorConnection() {

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return SingleChildScrollView(
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
    etebar=widget.etebar;
    super.initState();
    _subSupplement.clear();
    _allCat.clear();
      _cid=widget.supCat.id;
    _getSupCat(cid: _cid);

    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
           _getSupCat(page : _currentPage.toString(),cid:_cid);
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
    await _getSupCat(cid:_cid,refresh: true);
    return null;
  }
  Future <Map> getProducts(String cid,String page) async {
    print('exersizeeeeeeeeeeeeeeeeecid${cid}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      List<subSupplement> subSupplements =[];
      List<allSupplements> cats =[];
      final response = await Provider.of<apiServices>(context,listen: false)
        .getSubSupplements(
        {'category':cid,'page':page},
        'Bearer '+ apiToken );
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);
      print(  post.toString());
      post["data"].forEach((item) {
        subSupplements.add(subSupplement.fromJson(item));
      });

      post["children"].forEach((item) {
        cats.add(allSupplements.fromJson(item));
      });

    }
    else {
      print(response.statusCode.toString());
    }
    return {
      "supplement" : subSupplements??[],
      "cats" : cats,
    };
    }catch(e){
      setState(() {
        _connection=false;
      });
      return {
        "supplement" : [],
        "cats" : [],
      };;
    }

  }
  _getSupCat({String cid, bool refresh : false,String page='1'}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if( await checkConnectionInternet()) {
    var response = await getProducts( cid,page);
    setState(() {
//      etebar = prefs.getInt('etebar');
      if(refresh){ _subSupplement.clear();_allCat.clear();_currentPage=1;nextPage=true;}
      List<subSupplement> list=(response['supplement']);
      if(list.isEmpty){nextPage=false;print('hjh');}
      print((response['supplement']));
      _subSupplement.addAll(response['supplement']);
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

    allSupplements supcat=widget.supCat;
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading:  CircleAvatar(
          radius: 25*(screenSize.width)/375,
          backgroundImage: NetworkImage(
              supcat.cover),
          backgroundColor: Colors.white,
        ),title:   Text(supcat.name,style: TextStyle(
        color: Colors.white,
        fontWeight:FontWeight.w700 ,
        fontSize: 16*fontvar,
      ),textAlign: TextAlign.right,
        maxLines: 1,),
        centerTitle: false,
        actions: [    IconButton(icon: Icon(Icons.chevron_right,size:32,),
          onPressed: (){Navigator.of(context).pop();},
          alignment: Alignment.centerLeft,
          color: Colors.white,
          splashColor: Colors.amber,
          // padding: EdgeInsets.all(7),

        ),],

      ),

     body: RefreshIndicator(
        key: _refreshIndicatorKey,
        child:

      !_connection && !_isLoading
          ? _errorConnection()
          :_subSupplement.length == 0 && _allCat.isEmpty && _isLoading
          ? loadingView()
          : _subSupplement.length == 0&& _allCat.isEmpty
          ? listIsEmpty()
          :CustomScrollView(
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


        onRefresh: _handleRefresh,
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
                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:mokamelCat(supCat: _allCat[i],etebar: etebar,)),
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


    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    List<Widget> list = new List<Widget>();

    for (int i = 0; i < _subSupplement.length; i++) {
      list.add(
        GestureDetector(
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new ClipRRect(
                              borderRadius: new BorderRadius.horizontal(
                                  right: Radius.circular(15),
                                  left: Radius.circular(0)),
                              child: _subSupplement[i].free==0 &&  etebar<0
                                  ?Stack(
                                children: <Widget>[
                                  FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    image: NetworkImage(_subSupplement[i].cover),
                                    fit: BoxFit.fill,
                                    height: 115*(screenSize.width)/375,
                                    width: 125*(screenSize.width)/375,
                                  ),
                                  Container(
                                    color: Colors.green.withOpacity(0.6),
                                    child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
                                    height: 115*(screenSize.width)/375,
                                    width: 125*(screenSize.width)/375,
                                  )
                                ],
                              )
                                  :FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/placeholder.png'),
                                image: NetworkImage(_subSupplement[i].cover),
                                fit: BoxFit.fill,
                                height: 115*(screenSize.width)/375,
                                width: 125*(screenSize.width)/375,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top: 8,right: 12),
                                    child: Text(_subSupplement[i].name,
                                      style: TextStyle(
                                          color: Color(0xff334856),
                                          fontSize: 14*fontvar,
                                          fontWeight: FontWeight.w500
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),



                                  Padding(padding: EdgeInsets.only(top: 8,right: 12),
                                    child: Text(_subSupplement[i].description,
                                      style: TextStyle(
                                          color: Color(0xff334856),
                                          fontSize: 11*fontvar,
                                          fontWeight: FontWeight.w400
                                      ),
                                      maxLines: 2,
                                    ),

                                  )
                                ],
                              ),
                            )

                          ],

                        ),


                      ),
                      onTap:() {
                      _subSupplement[i].free==0 &&  etebar<0
                          ?showSnakBar("شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید.")
                          :
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(textDirection: TextDirection.rtl, child:mokamelDetail(singleId: _subSupplement[i].id)),
                        ),
                      );},
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



  showSnakBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2), backgroundColor: MyColors.vazn,
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
