import 'dart:convert';
import 'package:barika_web/models/allRecipes.dart';
import 'package:barika_web/models/subRecipes.dart';
import 'package:barika_web/regimiFood/regimiFoodCat.dart';
import 'package:barika_web/regimiFood/regimiFoodDetail.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class regimiFoodList extends StatefulWidget {
  String acountDate;
  @override
  regimiFoodList({Key key,this.acountDate}) : super(key: key);

  State<StatefulWidget> createState() => regimiFoodListState();
}

class regimiFoodListState extends State<regimiFoodList> {
  Color textColor = Color(0xff555555);
  List<allRecipes> _allRecipes = [];
  ScrollController _listScrollController = new ScrollController();
  bool _isLoading = true;
  bool _connection = true;
  bool nextPage=true;
  int _currentPage = 1;
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
    return  Center(
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

   Future<Map> getProducts(String page) async {
    print('exersize');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      List<allRecipes> albums = [];
      final response = await Provider.of<apiServices>(context, listen: false)
        .getSupplement({
      'type': 'recipe','page':page
    }, 'Bearer '+apiToken);
    if (response.statusCode == 200) {


      final  post0 = json.decode(response.bodyString);
      final  post = post0["0"];
      serverDate =post0["server_date"];
      getEtebar();
      print(post);
      List allrecipe = post0['categories'];
      print(post.toString());
      allrecipe.forEach((item) {
        albums.add(allRecipes.fromJson(item));
      });


    } else {
      print(response.statusCode.toString());
    }


    return {"albums": albums??[]};
    }catch(e){
      return {"albums": []};
      setState(() {
        _connection=false;
      });
    }
  }

  _getRecipes({ bool refresh : false,String page='1'}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if( await checkConnectionInternet()) {
    var response = await getProducts(page);
    setState(() {

      if(refresh) {_allRecipes.clear();_currentPage=1;nextPage=true;  print(_currentPage.toString()+"page");}
      List<allRecipes> list=(response['albums']);
      if(list.isEmpty){nextPage=false;print('hjh');}
      print((response['albums']));
      _allRecipes.addAll(response['albums']);
      _isLoading = false;
      _connection=true;
    });}
    else{
      setState(() {
        _connection=false;
        _isLoading=false;
      });
    }
  }

  Future<Null> _handleRefresh() async {
    await _getRecipes(refresh: true);
    return null;
  }


  String acountDate;
  String serverDate;
  int etebar=-1;
  void initState() {
    print("regimi");
    super.initState();
    acountDate=widget.acountDate;
    _allRecipes.clear();
    _getRecipes();

    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        print('scroll');
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
          _getRecipes(page : _currentPage.toString());
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
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size size = MediaQuery.of(context).size;
    if(size.width>600)size=Size(600, size.height);

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return new Scaffold(
      appBar: AppBar(
        title:     Text(
          'دستور پخت غذاهای رژیمی',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16*fontvar,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[IconButton(
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
          padding: EdgeInsets.all(7),
        ),],
        centerTitle: true,
        leading:   Padding(
            padding: EdgeInsets.only(top: 12, bottom: 8),
            child:  Image.asset(
              'assets/icons/regimiFood.png',
              height: 45*(size.width)/375,
              width: 56*(size.width)/375,
            )),
        automaticallyImplyLeading: false,
      ),
        key: _scaffoldKey,
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
      child:

      !_connection && !_isLoading
      ? _errorConnection()
        : _allRecipes.length == 0 && _isLoading
          ? loadingView()
          : _allRecipes.length == 0
              ? listIsEmpty()
              :    Container(
                  child: new ListView.builder(
                      controller: _listScrollController,
                      itemCount: _allRecipes.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 240*(size.width)/375,
                          margin: EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 15, left: 3),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      _allRecipes[index].name,
                                      style: TextStyle(
                                          fontSize: 13*fontvar,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff5C5C5C)),
                                    ),
                                    FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: regimiFoodCat(
                                                          allRec: _allRecipes[
                                                              index],etebar:etebar)),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'مشاهده همه',
                                          style: TextStyle(
                                              fontSize: 11*fontvar,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff5C5C5C)),
                                        ))
                                  ],
                                ),
                              ),
                              items(_allRecipes[index].recipes)
                            ],
                          ),
                        );
                      })),
    onRefresh: _handleRefresh,
    ));
  }



  items(List recipes) {

    Size size = MediaQuery.of(context).size;
    if(size.width>600)size=Size(600, size.height);

    List<subRecipes> subRecipe = [];
    recipes.forEach((item) {
      subRecipe.add(subRecipes.fromJson(item));
    });

    return new Expanded(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  width: 200*(size.width)/375,
                  padding: EdgeInsets.only(bottom: 15),
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: Column(
                      children: <Widget>[
                        new ClipRRect(
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.circular(15),
                              bottom: Radius.circular(0)),
                          child:  subRecipe[index].free==0 &&  etebar<0
                              ?Stack(
                            children: <Widget>[
                              FadeInImage(
                                placeholder:
                                AssetImage('assets/images/placeholder.png'),
                                image: NetworkImage(subRecipe[index].cover),
                                fit: BoxFit.fitWidth,
                                width: 200*(size.width)/375,
                                height: 110*(size.width)/375,
                              ),
                              Container(
                                color: Colors.green.withOpacity(0.6),
                                child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
                                height: 110*(size.width)/375,
                                width: 200*(size.width)/375,
                              )

                            ],
                          ):FadeInImage(
                            placeholder:
                                AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(subRecipe[index].cover),
                            fit: BoxFit.fitWidth,
                            width: 200*(size.width)/375,
                            height: 110*(size.width)/375,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, right: 5),
                            child: Text(
                              subRecipe[index].name,
                              style: TextStyle(
                                  color: Color(0xff334856),
                                  fontSize: 13*fontvar,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                            )),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Flexible(child:  Text(
                              '${subRecipe[index].total_calorie} کالری برای یک نفر',
                              style: TextStyle(
                                  color: Color(0xffA8A8A8),
                                  fontSize: 10*fontvar,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                            ),
                        flex: 2,),
                            Flexible(child: Row(
                              children: <Widget>[
                            Padding(
                            padding: EdgeInsets.only(
                                right: 5),
                              child:  Image.asset(
                                  'assets/icons/btm_profile.png',
                                  height:13*(size.width)/375,
                                  width: 13*(size.width)/375,
                                )),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, left: 10, top: 2),
                                    child: Text(
                                      '${subRecipe[index].consumer} نفر',
                                      style: TextStyle(
                                          color: Color(0xffA2A2A2),
                                          fontSize: 9*fontvar,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                  ),
                                  flex: 1,),
                              ],
                            ))

                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                      )
                      ],
                    ),
                  ),
                ),
                onTap: () { subRecipe[index].free==0 &&  etebar<0?showSnakBar("شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید."):
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: regimiFoodDetail(catId: subRecipe[index].id)),
                    ),
                  );
                },
              );
            }));
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

  showSnakBar(String s) {
    _scaffoldKey.currentState.showSnackBar( SnackBar(
      duration:  Duration(seconds: 2),
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
