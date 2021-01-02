
import 'dart:convert';
import 'package:barika_web/exercise/exerciseDetail.dart';
import 'package:barika_web/models/allExersice.dart';
import 'package:barika_web/models/subExercises.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';
class exerciseCat extends StatefulWidget {
  final String catId;
int etebar;
  exerciseCat({Key key, @required this.catId,this.etebar}) : super(key: key);

  @override
  State<StatefulWidget> createState() => exerciseCatState();
}

class exerciseCatState extends State<exerciseCat> with AutomaticKeepAliveClientMixin<exerciseCat> {


  @override
  bool get wantKeepAlive => true;
  List<subExercise> _subExercise = [];
  List<allExercise> _allCat = [];
  bool _isLoading = true;
  String _cid;
  bool _connection = true;
  ScrollController _listScrollController = new ScrollController();
  bool nextPage=true;
  int _currentPage = 1;
  int etebar;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
  Widget loadingView() {
    return new Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }
  Future<Null> _handleRefresh() async {
    await _getsubEcer(cid: _cid,refresh: true);
    return null;
  }


  Widget listIsEmpty() {
    return new Center(
      child: new Text('این دسته خالی است.'),
    );
  }


  void initState() {
    super.initState();
    etebar=widget.etebar;
    _subExercise.clear();
    _allCat.clear();
    _cid=widget.catId;
    _getsubEcer(cid: _cid);
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        print('scroll');
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
          _getsubEcer(page : _currentPage.toString(),cid:_cid);
        }
      }

    });

  }
   Future <Map> getProducts(String cid,String page) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String apiToken = prefs.getString('user_token');
   try{
     List<subExercise> subexercises =[];
     List<allExercise> cats =[];
     final response = await Provider.of<apiServices>(context,listen: false)
        .getSubExercises(
        {'category':cid,'page':page},
        'Bearer '+apiToken );
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);

      print(post.toString());
      post["data"].forEach((item) {
        subexercises.add(subExercise.fromJson(item));
      });
      post["children"].forEach((item) {
        cats.add(allExercise.fromJson(item));
      });
      print(subexercises.length);
    }
    else {
      print(response.statusCode.toString());
    }
   return {
     "exercises" : subexercises??[],
     "cats" : cats,
   };

   }catch(e){
     setState(() {
       _connection=false;
     });
     return {
       "exercises" : [],
       "cats" : [],
     };

   }
  }

  _getsubEcer({String cid, bool refresh : false,String page='1'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if( await checkConnectionInternet()) {
    var response = await getProducts(cid,page);
    setState(() {
//      etebar = prefs.getInt('etebar');
      if(refresh) {_subExercise.clear();_allCat.clear();_currentPage=1;nextPage=true;  print(_currentPage.toString());}
      List<subExercise> list=(response['exercises']);
      if(list.isEmpty){nextPage=false;print('hjh');}
      print((response['exercises']));
      _subExercise.addAll(response['exercises']);
      _allCat=(response['cats']);
      _connection=true;
      _isLoading=false;
    });}

    else{
      setState(() {
        _connection=false;
        _isLoading=false;
      });
    }

  }
  double fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;
    Size screenSize = MediaQuery.of(context).size;
    // if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.chevron_right, size: 32*(screenSize.width)/375,),
            onPressed: () {
              Navigator.of(context).pop();
            },
            alignment: Alignment.topLeft,
            color: Colors.white,
              padding: EdgeInsets.all(7)
          ),
        ],
        elevation: 4,
        title: Text('تمرین های ورزشی', style: TextStyle(
            color: Colors.white,
            fontSize: 16*fontvar,
            fontWeight: FontWeight.w600

        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,


      ),
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        child:
      !_connection && !_isLoading
          ? _errorConnection()
          :_subExercise.length == 0 && _allCat.length==0&& _isLoading
          ? loadingView()
          : _subExercise.length == 0 && _allCat.length==0
          ? listIsEmpty()
          :
      CustomScrollView(
          controller: _listScrollController,
          slivers: <Widget>[
            SliverGrid.count(

                childAspectRatio: 3.8,
                crossAxisCount: 2,
                children:
                makeRadios()

            ),
            SliverGrid.count(

                crossAxisCount:screenSize.width>600?3: 2,
                children:
                makeRadios2()

            ),]),
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
                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:exerciseCat(catId: _allCat[i].id,etebar: etebar,)),
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
    // if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    List<Widget> list = new List<Widget>();

    for (int index = 0; index < _subExercise.length; index++) {
      list.add(
          GestureDetector(
            child: Container(
                margin:
                EdgeInsets.only(right: 8, left: 8, bottom: 10),
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox.expand(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new ClipRRect(
                                borderRadius: new BorderRadius.vertical(
                                    bottom: new Radius.circular(0),
                                    top: new Radius.circular(15)),
                                child:  _subExercise[index].free==0 &&  etebar<0
                                    ?Stack(
                                  children: <Widget>[
                                    FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/images/placeholder.png'),
                                      image: NetworkImage(
                                          _subExercise[index].cover

                                      ),
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: screenSize.width>600
                                          ? 50*( screenSize.width )/375:90*( screenSize.width )/375,

                                    ),
                                    Container(
                                      color: Colors.green.withOpacity(0.6),
                                      child: Icon(Icons.lock_outline,color: Colors.white,size: 50*( screenSize.width )/375,),
                                      height:screenSize.width>600
                                          ? 50*( screenSize.width )/375
                                          : 90*( screenSize.width )/375,
                                      width: double.infinity,

                                    )
                                  ],
                                )
                                    :FadeInImage(
                                  placeholder: AssetImage(
                                      'assets/images/placeholder.png'),
                                  image: NetworkImage(
                                      _subExercise[index].cover

                                  ),
                                  fit: BoxFit.fill,
                                  height:  screenSize.width>600
                                      ? 50*( screenSize.width )/375: 90*( screenSize.width )/375,
                                  width: double.infinity,

                                ),
                              ),
//                              !( _subExercise[index].free==0 &&  etebar<0)?SvgPicture.asset('assets/icons/play.svg'):Container(height: 0,width: 0,)

                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              _subExercise[index].name,
                              style: TextStyle(
                                  color: Color(0xff334856),
                                  fontSize: 13*fontvar,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 4),
                            child: Row(
                              children: <Widget>[
                             Image.asset('assets/icons/time.png',
                                height: 15*( screenSize.width )/375,
                                  width: 15*( screenSize.width )/375,
                                ),

                                Flexible(child: Container(
                                  margin: EdgeInsets.only(right: 3,
                                  ),
                                  child: Text(
                                    "${_subExercise[index].description}",
                                    style: TextStyle(
                                        color: Color(0xffA2A2A2),
                                        fontSize: 12*fontvar,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                  ),
                                ))


                              ],

                            ),
                          ),
                        ],
                      ),
                    )
                )),
            onTap: () {
            _subExercise[index].free==0 &&  etebar<0?showSnakBar("شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید.")
                :

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Directionality(textDirection: TextDirection.rtl,
                          child: exerciseDetail(
                              singleId: _subExercise[index].id)),
                ),
              );
            },

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
      duration: new Duration(seconds: 2),  backgroundColor: MyColors.vazn,
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






