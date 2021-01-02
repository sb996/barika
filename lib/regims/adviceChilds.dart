
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class adviceChilds extends StatefulWidget {
  String advertise;


  adviceChilds(this.advertise);

  @override
  State<StatefulWidget> createState() => adviceChildsState();
}

class adviceChildsState extends State<adviceChilds> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String advertise;
  String details;

  List<List<String>> allList = [];
  List<String> titlesList;
  List<String> detailsList;

  bool _isLoading=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advertise=widget.advertise;
    getTitle();
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
        backgroundColor: Color(0xffF5FAF2),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar:AppBar(
          title: Text(
            'توصیه ها',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16*fontvar,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[

    Container(
      alignment: Alignment.center,
      child:         IconButton(
        icon: Icon(
          Icons.chevron_right,
          size: 32*(screenSize.width)/375,
        ),
        onPressed: () {
          Navigator.pop(context, 'yes');
        },
        alignment: Alignment.topLeft,
        color: Colors.white,
        splashColor: Colors.amber,
        padding: EdgeInsets.all(7),
      ),

    )
          ],
        ),



        body:_isLoading?Container()
            :  new ListView.builder(
                    itemCount:titlesList.length,
                    itemBuilder: (context, index) {


                   return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    elevation: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 8),
                                            padding: EdgeInsets.only(top: 3),
                                            alignment: Alignment.center,
                                            width: 22*(screenSize.width)/375,
                                            height: 22*(screenSize.width)/375,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF15A23),
                                                shape: BoxShape.circle),
                                            child: Text(
                                              (index+1).toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14*fontvar),
                                            ),
                                          ),
                                          Container(
                                              child: Flexible(
                                                child: Text(
                                                  titlesList[index],
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 12*fontvar,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff777777),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                              }));



  }

  getTitle() async {

    setState(() {

      titlesList = advertise.toString().split("#");
      for (int i = 0; i < titlesList.length; i++)
        if (titlesList[i] == "") titlesList.removeAt(i);
      print(titlesList.length);
      titlesList.forEach((item) {
        print(allList.length);
        allList.add(item.split("-"));
        print(allList.length);
        _isLoading=false;
      });
    });
  }



}

class MyExpandedList {
  final String title;
  var contents;

  MyExpandedList(this.title, this.contents);
}
