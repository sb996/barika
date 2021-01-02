
import 'dart:convert';
import 'package:barika_web/foodAlbum/unitAlbumDialog.dart';
import 'package:barika_web/models/subAlbumSingle.dart';
import 'package:barika_web/models/unitSubAlbums.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';


class foodAlbumDetail extends StatefulWidget {
  @override
  String Catid;
  foodAlbumDetail({Key key,this.Catid}) : super(key: key);

  State<StatefulWidget> createState() => foodAlbumDetailState();
}

class foodAlbumDetailState extends State<foodAlbumDetail>{
  Color textColor=Color(0xff555555);
  List<unitSubAlbums> _unitsubAlbums = [];
  subAlbumSingle _subAlbums;
  bool _isLoading = true;
  bool _connection = true;
  bool _access = false;
  Widget _accseesConnection() {
    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
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
  Widget _errorConnection() {
    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    return new SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:Container(
          child:  Center(
              child: new Text('خطای اتصال به اینترنت')
          ),
          height: screenSize.height,
        )
    );
  }

  void initState() {
    super.initState();
    _getAlbum(widget.Catid);
  }
  Future<Null> _handleRefresh() async {
    await _getAlbum(widget.Catid);
    return null;
  }

   Future <Map> getProducts(String cid) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String apiToken = prefs.getString('user_token');

   try{ final response = await Provider.of<apiServices>(context,listen: false)
        .getAlbumSinglePage(
        cid,
        'Bearer '+apiToken );
   subAlbumSingle subAlbums ;
    if (response.statusCode == 200) {

      final  post = json.decode(response.bodyString);
      subAlbums=subAlbumSingle.fromJson(post);
      print(subAlbums.toString()+"edf");

     }
    else {
      final  posterror = json.decode(response.error.toString());
      print(posterror["errMsg"]+"defesfsef");
      if(posterror["errMsg"]=="illegal access")
      setState(() {
        _isLoading=false;
        _access=true;
      });
      print(response.statusCode.toString());
    }
   return {
     "subAlbum" : subAlbums
   };
   }
    catch(e){
      return {
        "subAlbum" : []
      };
     print(e.toString());
     setState(() {
       _connection=false;
     });
    }
  }

  _getAlbum(String cid) async {
    if( await checkConnectionInternet()) {
    var response = await getProducts( cid);
    if(response!=null){
    setState(() {
      _subAlbums=response['subAlbum'];
      _subAlbums.units.forEach((item) {
        _unitsubAlbums.add(unitSubAlbums.fromJson(item));
      });

      _isLoading=false;
      _connection=true;
    });
    }else {
      setState(() {
        _connection = false;
        _isLoading = false;
      });
    }}else {
      setState(() {
        _connection = false;
        _isLoading = false;
      });
    }

  }

  Widget loadingView() {
    return new Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }


  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return new Scaffold(

      body: RefreshIndicator(
        child:
        !_connection && !_isLoading
        ? _errorConnection()
        :_isLoading
          ? loadingView():
        _access?_accseesConnection()
          :CustomScrollView(slivers: <Widget>[
            SliverList(
        delegate: SliverChildListDelegate(<Widget>[

          Container(
            alignment: Alignment.bottomCenter,
            height: 330*(screenSize.width)/375,
            child: Stack(

            alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[


                FadeInImage(
                  placeholder: AssetImage(
                      'assets/images/placeholder.png'),
                  image: NetworkImage(_subAlbums.cover),
                  fit: BoxFit.cover,
                  height: 330*(screenSize.width)/375,
                ),

                Container(
                  padding: EdgeInsets.only(right: 12),
                  alignment: Alignment.centerRight,
                  height: 50*(screenSize.width)/375,
                  width: screenSize.width,
                  color: Color(0xBF6CBD45),
                  child: Text(_subAlbums.name,style: TextStyle(
                    fontSize: 18*fontvar,
                    color: Colors.white,
                    fontWeight:FontWeight.w600
                  ),
                  maxLines: 1,),
                ),


                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: screenSize.width,
                      height: 50*(screenSize.width)/375,
                      padding: EdgeInsets.only(bottom: 10),
                      color: Colors.green,
                      child:  IconButton(icon: Icon(Icons.chevron_right,size:32*(screenSize.width)/375,),
                    onPressed: (){ Navigator.of(context).pop(true);},
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    splashColor: Colors.amber,
                    padding: EdgeInsets.only(top: 20,left: 7,right: 7),
                  )),
                ),


              ],

            ),


          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: Text('واحدهای تعریف شده',style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff252525),
            fontSize: 16*fontvar
          ),),
          ),
          Container(
              height: 140*(screenSize.width)/375,

              child:  new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _unitsubAlbums.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 130*(screenSize.width)/375,
                    margin:
                    EdgeInsets.only(
                        right: 1, left: 1, bottom: 10),
                    child: GestureDetector(
                      onTap: (){   showDialog(context: context,
                          builder: (BuildContext context) {
                            return Padding(padding: EdgeInsets.symmetric(horizontal: 0,vertical: 30),child:  Dialog(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.transparent,
                                child:   unitAlbumDialog(_unitsubAlbums[index])
                            ));
                          }

                      );},

                      child:   Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              alignment:
                              AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                new ClipRRect(
                                  borderRadius: new BorderRadius
                                      .vertical(
                                      bottom: new Radius
                                          .elliptical(
                                        110,
                                        20.0,
                                      ),
                                      top: new Radius.circular(
                                          15)),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/images/placeholder.png'),
                                    image: NetworkImage(_unitsubAlbums[index].cover),
                                    fit: BoxFit.fill,
                                    height: 80*(screenSize.width)/375,
                                    width: 130*(screenSize.width)/375,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                _unitsubAlbums[index].name,
                                style: TextStyle(
                                    color: Color(0xff334856),
                                    fontSize: 13*fontvar,
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                    )  );

              }),

          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            child: Text(_subAlbums.description,style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff252525),
                fontSize: 13*fontvar
            ),),
          ),
        ]
    ))
    ]
        ),
        onRefresh: _handleRefresh,
      )
    );

  }




}
