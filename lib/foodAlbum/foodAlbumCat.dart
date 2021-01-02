
import 'dart:convert';

import 'package:barika_web/foodAlbum/foodAlbumDetail.dart';
import 'package:barika_web/models/allAlbums.dart';
import 'package:barika_web/models/subAlbums.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';


class foodAlbumCat extends StatefulWidget {
  @override
  allAbums Catid;
  int etebar;
  foodAlbumCat({Key key,this.Catid,this.etebar}) : super(key: key);

  State<StatefulWidget> createState() => foodAlbumCatState();
}

class foodAlbumCatState extends State<foodAlbumCat>{
  Color textColor=Color(0xff555555);
  List<subAbum> _subAlbums = [];
  List<allAbums> _allCat = [];
  static  String _cid='';
  bool _isLoading = true;
  bool _connection = true;
  bool nextPage=true;
  int _currentPage = 1;
  ScrollController _listScrollController = new ScrollController();

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
  int etebar;
  void initState() {
    super.initState();
    etebar=widget.etebar;
    _subAlbums.clear();
    _allCat.clear();
    _cid=widget.Catid.id;
    _getAlbumCat(cid: _cid);
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

//      if(maxScroll - currentScroll <= 200) {
      if(maxScroll == currentScroll) {
        if(! _isLoading && nextPage) {
          print(_currentPage.toString()+nextPage.toString());
          _currentPage=_currentPage+1;
          _getAlbumCat(page : _currentPage.toString(),cid:_cid);
        }
      }

    });
  }

  Future <Map> getProducts(String cid,String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try{
      List<subAbum> subAlbums =[];
      List<allAbums> cats =[];
      final response = await Provider.of<apiServices>(context,listen: false)
          .getSubAlbum(
          {'category':cid,'page':page},
          'Bearer '+apiToken);
      if (response.statusCode == 200) {

        final  post = json.decode(response.bodyString);
        print(post);

        post["data"].forEach((item) {
          subAlbums.add(subAbum.fromJson(item));
        });

        post["children"].forEach((item) {
          cats.add(allAbums.fromJson(item));
        });

      }
      else {
        print(response.statusCode.toString());
      }

      return {
        "subAlbum" : subAlbums,
        "cats" : cats,
      };
    }
    catch(e){
      return {
        "subAlbum" : [],
        "cats" : [],
      };

      print(e.toString());
      setState(() {
        _connection=false;
      });
    }
  }

  _getAlbumCat({String cid, bool refresh : false,String page='1'}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();



    if( await checkConnectionInternet()) {
      var response = await getProducts( cid,page);
      print(response);
      setState(() {
//        etebar = prefs.getInt('etebar');
        if(refresh){ _subAlbums.clear();_allCat.clear();_currentPage=1;nextPage=true;}
        List<subAbum> list=(response['subAlbum']);
        if(list.isEmpty){nextPage=false;print('hjh');}
        print((response['subAlbum']));
        _subAlbums.addAll(response['subAlbum']);
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

  Widget loadingView() {
    return new Center(
        child:SpinKitCircle(
          color: MyColors.vazn,
        )
    );
  }

  Future<Null> _handleRefresh() async {
    await _getAlbumCat(cid: _cid,refresh: true);
    return null;
  }


  Widget listIsEmpty() {
    return new Center(
      child: new Text('این دسته خالی است.'),
    );
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

    allAbums Catid=widget.Catid;
    return new Scaffold(
      key: _scaffoldKey,
      appBar:  PreferredSize(child: Container(
        padding: EdgeInsets.only(top:25 ),
        alignment: Alignment.topCenter,
        height:  100*(screenSize.width)/375,
        width: screenSize.width,
        decoration: new BoxDecoration(
          color: MyColors.green
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            IconButton(icon: Icon(Icons.chevron_right,size: 32*(screenSize.width)/375,),
              onPressed: (){Navigator.of(context).pop();},
              alignment: Alignment.topLeft,
              color: Colors.white,
              splashColor: Colors.amber,
              padding: EdgeInsets.only(top: 15,left: 7),
            )
            ,
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 5),
                    child: CircleAvatar(
                      radius:  25*(screenSize.width)/375,
                      backgroundImage: NetworkImage(
                          Catid.cover),
                      backgroundColor: Colors.white,
                    )),
                Text(Catid.name,style: TextStyle(
                  color: Colors.white,
                  fontWeight:FontWeight.w700 ,
                  fontSize: 16*fontvar,
                ),textAlign: TextAlign.right,),
              ],

            )

          ],
        ),
      ), preferredSize:Size.fromHeight( 60*(screenSize.width)/375),),
      body:
      RefreshIndicator(
        child:
        !_connection && !_isLoading
            ? _errorConnection()
            : _subAlbums.length == 0 &&_allCat.length==0&& _isLoading
            ? loadingView()
            : _subAlbums.length == 0&&_allCat.length==0
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

                  crossAxisCount: 2,
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
                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodAlbumCat(Catid: _allCat[i],etebar: etebar,)),
              ),
            );}  ,
            child:  Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),

                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: MyColors.green),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child:Text(_allCat[i].name,style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.w400 ,
                  fontSize: 12*fontvar,
                ),)),
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

    for (int i = 0; i < _subAlbums.length; i++) {
      list.add(GestureDetector(
          child: Container(
              height:  140*(screenSize.width)/375,
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
                          child:_subAlbums[i].free==0 &&  etebar<0
                              ?Stack(
                            children: <Widget>[
                              FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/placeholder.png'),
                                image:NetworkImage(_subAlbums[i].cover),
                                fit: BoxFit.cover,

                                height: 110*(screenSize.width)/375,
                                width: screenSize.width/2,


                              ),
                              Container(
                                height: 110*(screenSize.width)/375,
                                color: Colors.green.withOpacity(0.6),
                                child: Icon(Icons.lock_outline,color: Colors.white,size: 50*(screenSize.width)/375,),
                                width: screenSize.width/2,
                              )
                            ],
                          )
                              : FadeInImage(
                            placeholder: AssetImage(
                                'assets/images/placeholder.png'),
                            image:NetworkImage(_subAlbums[i].cover),
                            fit: BoxFit.cover,

                            height: 110*(screenSize.width)/375,
                            width: screenSize.width/2,


                          )
                              
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Text(
                            _subAlbums[i].name,
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
          onTap:(){ _subAlbums[i].free==0 &&  etebar<0
              ? showSnakBar("شما اکانت فعالی ندارید. برای خرید اکانت به فروشگاه بروید.")
            :Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodAlbumDetail(Catid: _subAlbums[i].id)),
            ),
          );}
      ));


      return list;}

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
