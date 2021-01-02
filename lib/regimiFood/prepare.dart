
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
class Prepare extends StatefulWidget {
  final String order;
  ScrollController controller;
  Prepare( this.order,  this.controller);
  @override
  State<StatefulWidget> createState() => prepareState();
}

class prepareState extends State<Prepare> with AutomaticKeepAliveClientMixin<Prepare> {
  @override
  bool get wantKeepAlive => false;


  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    widget.controller.jumpTo(0);
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return      new ListView(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      children: <Widget>[
      Text('طرز تهیه', style: TextStyle(
        fontSize: 12*fontvar,
        fontWeight: FontWeight.w500,
        color: Color(0xff334856)
    ),),
        Text(widget.order,
          style: TextStyle(
            fontSize: 12*fontvar,
            fontWeight: FontWeight.w400,
            color: Color(0xffA2A2A2)
        ),),

      ],
      
      
    );
      
    

    
  }
}
