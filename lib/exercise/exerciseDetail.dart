import 'dart:convert';

import 'package:barika_web/models/subExercisesSingle.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../helper.dart';
class exerciseDetail extends StatefulWidget {
  final String singleId;
  exerciseDetail({Key key, @required this.singleId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => exerciseDetailState();
}

class exerciseDetailState extends State<exerciseDetail> with AutomaticKeepAliveClientMixin<exerciseDetail> {
  @override
  VideoPlayerController _controller;
  bool get wantKeepAlive => true;
  subExercisesSingle _subExercise;
  bool _isLoading = true;
  bool _connection = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Widget _errorConnection() {

    Size screenSize = MediaQuery.of(context).size;
    // if(screenSize.width>600)screenSize=Size(600, screenSize.height);

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
  Widget loadingView() {
    return new Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }
  String sath ="";
  String sathName="";
  Future<Null> _handleRefresh() async {
    await _getphoto(cid: widget.singleId,refresh: true);
    return null;
  }
  bool _access = false;
  Widget _accseesConnection() {


    Size screenSize = MediaQuery.of(context).size;
    // if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return new SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:Container(
          child:  Center(
              child: new Text('دسترسی به محتوا مجاز نیست.')
          ),
          height: screenSize.height,
        )
    );
  }
  void initState() {
    super.initState();
    _getphoto(cid: widget.singleId);

  }

   Future <Map> getProducts(String cid) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String apiToken = prefs.getString('user_token');
    try{
      subExercisesSingle subexercises ;
      final response = await Provider.of<apiServices>(context,listen: false)
        .getSubExercisesSinglePage(
        cid,
        'Bearer '+apiToken );
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);

      print(post.toString());
      subexercises=(subExercisesSingle.fromJson(post));

   }
    else {  final  posterror = json.decode(response.error.toString());
    print(posterror["errMsg"]+"defesfsef");
    if(posterror["errMsg"]=="illegal access")
      setState(() {
        _isLoading=false;
        _access=true;
      });
    print(response.statusCode.toString());

    }
    return {
      "exercises" : subexercises
    };
    }

    catch(e){
      setState(() {
        _connection=false;
      });
      return {
        "exercises" : []
      };
    }
  }

  _getphoto({String cid, bool refresh : false}) async {
    if( await checkConnectionInternet()) {
    var response = await getProducts(cid);
    if(response!=null){
    setState(() {

      _subExercise=(response['exercises']);
      print(_subExercise.name);
      print(_subExercise.energy);
      print(_subExercise.description);
      print(_subExercise.met);
      print(_subExercise.hardness);
      sath=_subExercise.hardness;
      _connection=true;
      _isLoading=false;
    });
    if(_subExercise.type=="video"){
    _controller = VideoPlayerController.network(
      _subExercise.link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
    _controller.setVolume(5);
    _controller.setLooping(true);}
    }else {
      setState(() {
        _connection = false;
        _isLoading = false;
      });
    }}else {
  setState(() {
  _connection = false;
  _isLoading = false;
  });}

  }

  double fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    // if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return  Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[

        IconButton(icon: Icon(Icons.chevron_right,size:32),
                  onPressed: (){ Navigator.of(context).pop();},
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  splashColor: Colors.amber,


      ),]),
        body: new RefreshIndicator(
          key: _refreshIndicatorKey,
        child:
        !_connection && !_isLoading
        ? _errorConnection()
        :_isLoading
          ? loadingView()
          :    _access?_accseesConnection()
            :new CustomScrollView(
        slivers: <Widget>[
          SliverList(


              delegate: SliverChildListDelegate(<Widget>[
      Container(
        width: screenSize.width,
        padding: EdgeInsets.only(top: 12) ,
        child:
                _subExercise.type=="gif"?
                Container(
                  height:screenSize.width>600?150*(screenSize.width)/375: 280*(screenSize.width)/375,
                  width: screenSize.width,
                  padding: EdgeInsets.only(top: 12) ,
                  margin: EdgeInsets.only(top: 30),
                  child: FadeInImage.assetNetwork(
                    fadeInCurve: Curves.easeIn ,
                    fadeInDuration: Duration(milliseconds: 200),
                    fadeOutCurve: Curves.easeOut,
                    fadeOutDuration: Duration(milliseconds: 200),
                    placeholder: 'assets/images/placeholder.png',
                    image:_subExercise.link,
                    width: screenSize.width,
                    fit: BoxFit.contain,
                    // height: 280*(screenSize.width)/375,
                    alignment: Alignment.topCenter,
                  ),
//                  FadeInImage(
//                  placeholder: AssetImage(
//                      'assets/images/placeholder.png'),
//                  image: NetworkImage(_subExercise.link),
//
//                  fit: BoxFit.scaleDown,
//                  height: 280*(screenSize.width)/375,
//                  alignment: Alignment.topCenter,
//                )

                )
                    :_subExercise.type=="video"?
                _controller.value.initialized
                    ? AspectRatio(

                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),

                )
                    : loadingView() :Container(),
),

                Padding(padding: EdgeInsets.only(right: 12,top: 12),
                    child:Text(
                      _subExercise.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15*fontvar,
                          fontWeight: FontWeight.w600),
                    ),
                    ),
                Padding(
                  padding: EdgeInsets.only(right: 12,top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/icons/time.png',
                        height: 15*(screenSize.width)/375,
                        width: 15*(screenSize.width)/375,),
                  Padding(
                    padding: EdgeInsets.only(right: 12,top: 4),
                    child:  Text(
                        ' دقیقه تمرین ${_subExercise.met} کالری ',
                        style: TextStyle(
                            color: Color(0xffA2A2A2),
                            fontSize: 12*fontvar,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                      ),),
                    ],

                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(top: 4,right:12 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'سطح',
                        style: TextStyle(
                            color: Color(0xffA2A2A2),
                            fontSize: 13*fontvar,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                      ),
                      Container(
                        height: 10*(screenSize.width)/375,
                        width: 10*(screenSize.width)/375,
                        decoration: BoxDecoration(
                          color: setSath(),
                          shape: BoxShape.circle,
                        ),

                        margin: EdgeInsets.only(right: 4,left: 4,bottom: 4),
                      ),
                      Text(
                        sathName,
                        style: TextStyle(
                            color: Color(0xffA2A2A2),
                            fontSize: 14*fontvar,
                            fontWeight: FontWeight.w400),

                      ),
                    ],

                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(right: 12,top: 4,left: 4,bottom: 20),
                  child:  Text(
                      _subExercise.description,
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 16*fontvar,
                        fontWeight: FontWeight.w400),

                  ),),

              ]))
        ],


      ),
          onRefresh: _handleRefresh,)
    );}

 Color setSath() {
   switch (sath) {
     case "easy":
       {
         sathName="آسان";
         return Colors.green;
       }
       break;
     case "middle":
       {
         sathName="متوسط";
         return Colors.yellow;
       }
       break;
     case "hard":
       {
         sathName="دشوار";
         return Colors.red;
       }
       break;
 }

}
  @override
  void dispose() {
    super.dispose();
    if(_subExercise!=null&&_subExercise.type=="video")
    _controller.dispose();
  }

}



