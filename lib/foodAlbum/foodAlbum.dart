
import 'dart:convert';

import 'package:barika_web/foodAlbum/foodAlbumCat.dart';
import 'package:barika_web/models/allAlbums.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';


class foodAlbum extends StatefulWidget {

  String acountDate;
  foodAlbum({Key key, this.acountDate}) : super(key: key);
  @override
  State<StatefulWidget> createState() => foodAlbumState();
}

class foodAlbumState extends State<foodAlbum>{
  Color textColor=Color(0xff555555);
  List<allAbums> _allAlbum=[];
  ScrollController _listScrollController = new ScrollController();
  bool nextPage=true;
  int _currentPage = 1;
  bool _isLoading = true;
  bool _connection = true;
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
  String acountDate;
  String serverDate;
  int etebar=-1;
  void initState() {
    print("fooood");
    super.initState();
    _allAlbum.clear();
    _getAlbums();
    acountDate=widget.acountDate;

    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        print('scroll');
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
          _getAlbums(page : _currentPage.toString());
        }
      }

    });
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
   Future <Map> getProducts(String page) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String apiToken = prefs.getString('user_token');
   try{  List<allAbums> albums =[];
     final response = await Provider.of<apiServices>(context,listen: false)
        .getSupplement(
        {'type':'album','page':page},
        'Bearer '+apiToken);
    if (response.statusCode == 200) {


      final  post0 = json.decode(response.bodyString);
      final  post = post0["0"];
     serverDate =post0["server_date"];
     getEtebar();
print(post);

      post.forEach((item) {
        albums.add(allAbums.fromJson(item));
      });

    }
    else {
      print(response.statusCode.toString());
    }
   return {
     "albums" : albums
   };
   }catch(e){
     setState(() {
       _connection=false;
     });
     return {
       "albums" : []
     };
   }
  }
  _getAlbums({ bool refresh : false,String page='1'}) async {
    if( await checkConnectionInternet()) {
    var response = await getProducts(page);
    setState(() {
      if(refresh) {_allAlbum.clear();_currentPage=1;nextPage=true;  print(_currentPage.toString()+"page");}
      List<dynamic> list=(response['albums']);
      if(list.isEmpty){nextPage=false;print('hjh');}
      print((response['albums']));
      _allAlbum.addAll(response['albums']);
      print(_allAlbum.toString());
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
  Future<Null> _handleRefresh() async {
    await _getAlbums(refresh: true);
    return null;
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

    return  Scaffold(
      appBar: AppBar(
        title:   Text('آلبوم غذایی',style: TextStyle(
          color: Colors.white,
          fontWeight:FontWeight.w700 ,
          fontSize: 16*fontvar,
        ),textAlign: TextAlign.center,),
        actions: <Widget>[  IconButton(icon: Icon(Icons.chevron_right,size:32*(screenSize.width)/375,),
          onPressed: (){Navigator.of(context).pop();},
          alignment: Alignment.topLeft,
          color: Colors.white,
          splashColor: Colors.amber,
          padding: EdgeInsets.all(7),
        )],
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading:    Padding(padding: EdgeInsets.only(top: 12,bottom: 8),
            child:Image.asset('assets/icons/foodAlbum.png',height: 45*(screenSize.width)/375,width:56*(screenSize.width)/375,)),

      ),
      body:
      new RefreshIndicator(
        child:

            !_connection && !_isLoading
                ? _errorConnection()
                : _allAlbum.length == 0 && _isLoading
                ? loadingView()
                : _allAlbum.length == 0
                ? listIsEmpty()
                :    Container(
              margin: EdgeInsets.only(top:  10*(screenSize.width)/375,),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                }, child: GridView.builder(
                  itemCount: _allAlbum.length,
                  controller: _listScrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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

                                    new ClipRRect(
                                      borderRadius: new BorderRadius.vertical(
                                          bottom: new Radius.elliptical(
                                            110,
                                            20.0,
                                          ),
                                          top: new Radius.circular(15)),
                                      child: FadeInImage(
                                        placeholder: AssetImage(
                                            'assets/images/placeholder.png'),
                                        image: NetworkImage(_allAlbum[index].cover),
                                        fit: BoxFit.cover,
                                        height: 110*(screenSize.width)/375,
                                        width: screenSize.width/2,


                                      ),
                                    ),



                                    Padding(
                                      padding: EdgeInsets.only(top: 14),
                                      child: Text(
                                        _allAlbum[index].name,
                                        style: TextStyle(
                                            color: Color(0xff334856),
                                            fontSize: 14*fontvar,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          )),
                      onTap: ()
                      {


                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodAlbumCat(Catid: _allAlbum[index],etebar:etebar)),
                        ),
                      ); },

                    );

                  }),),
            ),

        onRefresh: _handleRefresh,
      ),
        );

  }
  void getEtebar() {

    if(serverDate!=null && acountDate !=null  && acountDate !=""){
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
