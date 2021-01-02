import 'dart:html';
import 'dart:math';
import 'package:barika_web/UiFake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class swapDiet extends StatefulWidget {


  String url;

  swapDiet({Key key,this.url}) : super(key: key);

  @override
  swapDietState createState() => new swapDietState();
}

class swapDietState extends State<swapDiet> {
  int counter=0;
  String baseUrl;
  String randId="";
  @override
  void initState() {

    baseUrl=widget.url;
    print(baseUrl);
    randId=generateRandomString(3);

    ui.platformViewRegistry.registerViewFactory(randId, (int viewId) {
      element = IFrameElement();


      element.onLoad.forEach((elementtt) async {
        counter++;

          if (counter ==2) {
            element.remove();
            mpop();
          }});

      element.src =baseUrl;
      element.style.border = 'none';
      return element;
    });

    super.initState();

  }
  IFrameElement element;
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  void dispose() {

    // element.remove();
    // TODO: implement dispose
    super.dispose();
  }
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);




    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(30 * (screenSize.width) / 375),
      //     child: Container(
      //       color: MyColors.green,
      //       padding: EdgeInsets.only(top: 20 * (screenSize.width) / 375),
      //       child: IconButton(
      //         icon: Icon(
      //           Icons.chevron_right,
      //           size: 32 * (screenSize.width) / 375,
      //         ),
      //         onPressed: () {
      //           Navigator.pop(context, 'yes');
      //         },
      //         alignment: Alignment.topLeft,
      //         color: Colors.white,
      //         splashColor: Colors.amber,
      //         padding: EdgeInsets.all(7),
      //       ),
      //     )
      // ),

        body: Builder(builder: (BuildContext context) {
          return
            HtmlElementView(
              key: UniqueKey(),
              viewType: randId,
            );

        }));
  }

  void mpop() {
    Navigator.pop(context,"sd");
  }}


