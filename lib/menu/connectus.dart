import 'dart:convert';

import 'package:barika_web/models/contact.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper.dart';

class connectUs extends StatefulWidget {
  @override

  connectUs({Key key}) : super(key: key);
  State<StatefulWidget> createState() => connectUsState();
}

class connectUsState extends State<connectUs> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String telegram="";
  String rubika="";
  String instagram="";
  String website="";
  String description="";

  @override
  void initState() {
    setData();
    super.initState();
    // _getUser();
  }

  ScrollController scrollController = new ScrollController();
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
      key: _scaffoldKey,

      appBar:  AppBar(
        title: Text(
          "ارتباط با ما",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16*fontvar,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              size:   32,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            alignment: Alignment.topLeft,
            color: Colors.white,
            splashColor: Colors.amber,
            padding: EdgeInsets.all(7),
          ) ,

        ],
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        controller: scrollController, slivers: <Widget>[
      SliverList(
      delegate: SliverChildListDelegate(<Widget>[


        Image.asset('assets/images/logogreen.png',
          fit: BoxFit.contain,
          width: 104*(screenSize.width)/375,
          height: 104*(screenSize.width)/375,),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child:
            Text(
              description,
              style: TextStyle(
                color: Color(0xff707070),
                fontWeight: FontWeight.w400,
                fontSize: 13*fontvar,
              ),
              textAlign: TextAlign.center,
            )),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: GestureDetector(
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical:2,horizontal: 25),
                child: Column(
                  children: [
                    Text(
                      'وبسایت باریکا',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14*fontvar,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      website==""?"https://barikaapp.com":website,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11*fontvar,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              shape:  RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(5),
              ) ,

              color: Color(0xff6DC07B),
              elevation: 5,
            ),



            onTap: () async {
              await openApp(website);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric( vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    'assets/icons/instagram.png',
                    fit: BoxFit.fill,
                    width: 35 * (screenSize.width) / 375,
                    height: 35 * (screenSize.width) / 375,
                  ),
                ),
                onTap: () async {
                  await openApp(instagram);
                },
              ),
              GestureDetector(
                // child: Container(
                //   margin: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  'assets/images/wh.png',
                  width: 45 * (screenSize.width) / 375,
                  height: 45 * (screenSize.width) / 375,
                ),
                // ),
                onTap: () async {
                  await openApp(rubika);
                },
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    'assets/icons/telegram.png',
                    fit: BoxFit.fill,
                    width: 35 * (screenSize.width) / 375,
                    height: 35 * (screenSize.width) / 375,
                  ),
                ),
                onTap: () async {
                  await  openApp(telegram);
                },
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    'assets/icons/site.png',
                    fit: BoxFit.fill,
                    width: 35 * (screenSize.width) / 375,
                    height: 35 * (screenSize.width) / 375,
                  ),
                ),
                onTap: () async {
                  await   openApp(website);
                },
              ),

            ],
          ),
        ),
      ],))])

    );
  }
  openApp(String url) async {

    if(url !=null && url!=""){
      if (await canLaunch(url)) {
        await launch(
          url,
          universalLinksOnly: true,
        );
      } else {
        throw 'There was a problem to open the url: $url';
      }}
  }



  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String contactus=prefs.getString("contactus");
    contact contactitem;
    if(contactus!=null){
      setState(() {
        contactitem= contact.fromJson(jsonDecode(contactus));
        website=contactitem.website;
        description=contactitem.description;
        telegram=contactitem.telegram;
        instagram=contactitem.instagram;
        rubika=contactitem.rubika;
      });
    }
    if(await checkConnectionInternet())
      await getInfo();



  }
  Future<void> getInfo() async {
    print("getEtebar");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken=prefs.getString("user_token");


    final response = await Provider.of<apiServices>(context,listen: false).contactUs('Bearer '+apiToken);
    if (response.statusCode == 200) {
      final  post = json.decode(response.bodyString);
      print(post);
      contact contactitem;
      contactitem=(contact.fromJson(post));
      prefs.setString("contactus", jsonEncode(contactitem.toMap()));

      if(description==""){
        setState(() {
          website=contactitem.website;
          description=contactitem.description;
          telegram=contactitem.telegram;
          instagram=contactitem.instagram;
          rubika=contactitem.rubika;
        });
      }

    }
    else {
      print(response.statusCode.toString());
    }



  }

}
