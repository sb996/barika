import 'dart:convert';
import 'package:barika_web/models/subRecipesSingle.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';
import 'Materials.dart';
import 'arzesh.dart';
import 'prepare.dart';

class regimiFoodDetail extends StatefulWidget {
  @override
  final String catId;

  regimiFoodDetail({Key key, @required this.catId}) : super(key: key);

  State<StatefulWidget> createState() => regimiFoodDetailState();
}

class regimiFoodDetailState extends State<regimiFoodDetail>
    with SingleTickerProviderStateMixin {
  Color textColor = Color(0xff555555);
  TabController tabController;
  List<String> _material = [];
  List<String> _totalEnergi = [];
  String _order;
  ScrollController controller = new ScrollController();
  subRecipesSingle _subRecipesSingle;
  bool _access = false;
  Widget _accseesConnection() {
    return new SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:Container(
          child:  Center(
              child: new Text('دسترسی به محتوا مجاز نیست.')
          ),
          height: MediaQuery.of(context).size.height,
        )
    );
  }
  bool _isLoading = true;
  bool _connection = true;
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
                      await _getphoto(widget.catId);
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
      child:  CircularProgressIndicator(),
    );
  }

  Widget listIsEmpty() {
    return  Center(
      child:  Text('محصولی برای نمایش وجود ندارد'),
    );
  }

  Future<Map> getProducts(String cid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
   try{ final response = await Provider.of<apiServices>(context, listen: false)
        .getRecipesSinglePage(cid,
            'Bearer '+apiToken );
    if (response.statusCode == 200) {
      final post = json.decode(response.bodyString);
      subRecipesSingle RecipesSingle;

      RecipesSingle = (subRecipesSingle.fromJson(post));

      return {"RecipesSingle": RecipesSingle};
    } else {
      final  posterror = json.decode(response.error.toString());
      print(posterror["errMsg"]+"defesfsef");
      if(posterror["errMsg"]=="illegal access")
        setState(() {
          _isLoading=false;
          _access=true;
          print(_connection);
        });
      print(response.statusCode.toString());
      return {"RecipesSingle": []};
    }}catch(e){
     setState(() {
       _connection=false;
       print(_connection.toString()+"1");
     });

     return {"RecipesSingle": []};
   }
  }

  _getphoto(String cid) async {
    if( await checkConnectionInternet()) {
    var response = await getProducts(cid);
    if(response!=null){
    setState(() {
      _subRecipesSingle = (response['RecipesSingle']);
//      _material=_subRecipesSingle.data;
      _subRecipesSingle.data.forEach((item) {
        _material.add(item);
      });
      _totalEnergi.add(_subRecipesSingle.total_calorie);
      _totalEnergi.add(_subRecipesSingle.total_carb);
      _totalEnergi.add(_subRecipesSingle.total_protein);
      _totalEnergi.add(_subRecipesSingle.total_fat);
      _order = _subRecipesSingle.order;

      _isLoading = false;
      _connection=true;
    });}
    else{
      setState(() {
        _access=true;
        print(_connection.toString()+"2");
        _isLoading=false;
      });
    }
  } else{
      setState(() {
        _connection=false   ;    print(_connection.toString()+"3");
        _isLoading=false;
      });
    }}

  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: 3, vsync: this);
    _getphoto(widget.catId);
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

    return Scaffold(
      body:  !_connection && !_isLoading
          ? _errorConnection()
          :_isLoading
          ? loadingView()
          :   _access?_accseesConnection()
          : NestedScrollView(

        controller: controller,
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 240*(screenSize.width)/375,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          size: 32,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        alignment: Alignment.topLeft,
                        color: Colors.white,
                        splashColor: Colors.amber,
                        padding: EdgeInsets.only(top: 15, left: 7),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,

                              titlePadding: EdgeInsets.only(right: 5,left: 0,bottom: 15,top: 0),
                              title:Text(' ${_subRecipesSingle.name}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0*fontvar,
                                      fontWeight: FontWeight.w500)),

                        background: Stack(
                          fit: StackFit.expand,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/placeholder.png'),
                              image: NetworkImage(_subRecipesSingle.cover),
                              fit: BoxFit.cover,

                            ),
                            Container(
                              height: 4*(screenSize.width)/375,
                              // Add box decoration
                              decoration: BoxDecoration(
                                // Box decoration takes a gradient
                                gradient: LinearGradient(
                                  // Where the linear gradient begins and ends
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.1, 0.4, 0.7, 0.9],
                                  colors: [
                                    // Colors are easy thanks to Flutter's Colors class.
                                    Colors.black45,
                                    Colors.black26,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      new TabBar(controller: tabController,tabs: <Widget>[
                        new Container(
                            height: 70*(screenSize.width)/375,
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/materials.png',
                              height: 18*(screenSize.width)/375,
                              width: 18*(screenSize.width)/375,
                            ),
                            Flexible(child:    Text(
                              'مواد لازم',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        )),
                        new Container(
                            height: 70*(screenSize.width)/375,
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/order.png',
                              height: 18*(screenSize.width)/375,
                              width: 16*(screenSize.width)/375,
                            ),
                            Flexible(child:   Text(
                              'طرز تهیه',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        )),
                        new Container(
                            height: 70*(screenSize.width)/375,
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/arzesh.png',
                              height: 18*(screenSize.width)/375,
                              width: 13*(screenSize.width)/375,
                            ),
                          Flexible(child:   Text(
                            'ارزش غذایی',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13*fontvar,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),)
                          ],
                        )),
                      ]),
                    ),
                    pinned: true,
                    floating: false,
                  ),
                ];
              },

              body: TabBarView(controller: tabController, children: <Widget>[
                Materials(_material,controller),
                Prepare(_order,controller),
                Arzesh(_totalEnergi,controller),
              ]),
            ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    return new Container(
      color: MyColors.green,
      height: 80,

      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
//,"prev_weight":"null","week":"null"}