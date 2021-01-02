import 'dart:ui' as prefix0;

import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Materials extends StatefulWidget {
  final List material;
  ScrollController controller;
  Materials(this.material,this.controller);

  @override
  State<StatefulWidget> createState() => MaterialsState();
}

class MaterialsState extends State<Materials>
    with AutomaticKeepAliveClientMixin<Materials> {
  @override
  bool get wantKeepAlive => false;

  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    if(widget.controller.position.pixels>0)widget.controller.jumpTo(0);
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    List mat = widget.material;
    int itemCount = mat.length + 1;
    return new ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == 0)
            return Padding(
              padding: EdgeInsets.only(right: 10, bottom: 10,top: 5),
              child: Text(
                'مواد لازم',
                style: TextStyle(
                    fontSize: 12*fontvar,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff334856)),
              ),
            );
          else
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          color: Color(0xffF15A23), shape: BoxShape.circle),
                      child: Text(
                        '${index}',
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14*fontvar),
                      ),
                    ),
                    Container(


                      child: Text(
                        mat[index - 1],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 11*fontvar,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffA2A2A2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
        });
  }
}
