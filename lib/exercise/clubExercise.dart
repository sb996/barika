
import 'dart:convert';
import 'package:barika_web/exercise/exerciseCat.dart';
import 'package:barika_web/models/allExersice.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';
class clubExercise extends StatefulWidget {

  String acountDate;
  @override
  clubExercise({this.acountDate});

  @override
  State<StatefulWidget> createState() => clubExerciseState();
}

class clubExerciseState extends State<clubExercise> with AutomaticKeepAliveClientMixin<clubExercise> {
  @override
  bool get wantKeepAlive => true;
   List<allExercise> clubExercises=[];
  bool _isLoading = true;
  bool _connection = true;
  String acountDate;
  String serverDate;
  int etebar=-1;

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
  Widget listIsEmpty() {
    return new Center(
      child: new Text('این دسته خالی است.'),
    );
  }
  Future<Null> _handleRefresh() async {
    await _getExercise(refresh: true);
    return null;
  }
  List<allExercise> _allExercise=[] ;
  bool nextPage=true;
  int _currentPage = 1;
  ScrollController _listScrollController = new ScrollController();
  @override
  void initState() {
    acountDate=widget.acountDate;
    _getExercise();
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        print('scroll');
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
          _getExercise(page : _currentPage.toString());
        }
      }

    });
    // TODO: implement initState
    super.initState();
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
    return   RefreshIndicator(
      key: _refreshIndicatorKey,
        child:
        !_connection && !_isLoading
        ? _errorConnection()
        :clubExercises.length == 0 && _isLoading
    ? loadingView()
        : clubExercises.length == 0
    ? listIsEmpty()
        :
          Container(

            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              }, child: GridView.builder(
                itemCount: clubExercises.length,
                controller: _listScrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:(screenSize.width>600)
                      ?3: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                        height: 140*(screenSize.width)/375,
                        margin:
                        EdgeInsets.only(right: 8, left: 8, bottom: 10),
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child:SizedBox.expand(
                              child:  Column(
                                children: <Widget>[
                                   ClipRRect(
                                    borderRadius:  BorderRadius.vertical(
                                        bottom:  Radius.circular(0),
                                        top:  Radius.circular(15)),
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/images/placeholder.png'),
                                      image: NetworkImage(clubExercises[index].cover),
                                      fit: BoxFit.cover,
                                      height:  (screenSize.width>600)
                                          ? 70*(screenSize.width)/375
                                          :110*(screenSize.width)/375,
                                      width: screenSize.width/2,

                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: 14),
                                    child: Text(
                                      clubExercises[index].name,
                                      style: TextStyle(
                                          color: Color(0xff334856),
                                          fontSize: 15*fontvar,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(textDirection: TextDirection.rtl, child:exerciseCat(catId: clubExercises[index].id,etebar:etebar),
                        )),
                      );},

                  );

                }),),


    ),
    onRefresh: _handleRefresh,);

  }

  void clearList() {

    clubExercises.clear();

  }
  Future <Map> getProducts(String page) async {
    print('exersize');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    List<allExercise> exercises =[];
    try{

      var  post;
      final response = await Provider.of<apiServices>(context,listen: false)
          .getExercise(
          {'type':'exercise','page':page},
          'Bearer '+apiToken );
      if (response.statusCode == 200) {
        final  post0 = json.decode(response.bodyString);
        final  post = post0["0"];
        serverDate =post0["server_date"];
        getEtebar();
        print(post.toString());
        post.forEach((item) {
          exercises.add(allExercise.fromJson(item));
        });
        print(exercises.length);
      }
      else {
        print(response.statusCode.toString());
      }

      return {
        "exercises" : exercises??[]
      };
    }catch(e){
      setState(() {
        _connection=false;
        return {
          "exercises" : exercises??[]
        };
      });

    }
  }

  _getExercise({ bool refresh : false,String page='1'}) async {
    if( await checkConnectionInternet()) {

      var response = await getProducts(page);
      setState(() {
        if(refresh) {clearList();_currentPage=1;nextPage=true;  print(_currentPage.toString()+"page");}
        List<allExercise> list=(response['exercises']);
        if(list.isEmpty){nextPage=false;print('hjh');}
        print((response['exercises']));

        list.forEach((item) {
          if(item.type=="exercise-gym")
            clubExercises.add(item);
          else if(item.type=="exercise")
            clubExercises.add(item);
        });

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
  void getEtebar() {

    if(serverDate!=null && acountDate !=null&& acountDate!=""){
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


