import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class Arzesh extends StatefulWidget {
  final List total;
  ScrollController controller;
  Arzesh( this.total,this.controller);
  @override
  State<StatefulWidget> createState() => ArzeshState();
}

class ArzeshState extends State<Arzesh> with AutomaticKeepAliveClientMixin<Arzesh> {
  @override
  bool get wantKeepAlive => false;
  Color lowGreen=Color(0xffE8FFDD);
  Color hGreen=Color(0xff6DC07B);

  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    widget.controller.jumpTo(0);
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;

    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);


    List total =widget.total;
    return      new ListView(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      children: <Widget>[
      Text('ارزش غذایی', style: TextStyle(
        fontSize: 12*fontvar,
        fontWeight: FontWeight.w500,
        color: Color(0xff334856)
    ),),
       Column(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(top: 15),
             padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
             decoration: BoxDecoration(
               color:lowGreen ,
               borderRadius: BorderRadius.vertical(top:Radius.circular(15))
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text('کالری برای یک نفر', style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color: Color(0xff5C5C5C)
                 ),),
                 Text(total[0], style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color: Color(0xff5C5C5C)
                 ),),
               ],
             ),
           ),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
             decoration: BoxDecoration(
               color:hGreen ,
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text('کربوهیدرات برای یک نفر', style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color: Colors.white
                 ),),
                 Text(total[1], style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color:  Colors.white
                 ),),
               ],
             ),
           ),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
             decoration: BoxDecoration(
               color:lowGreen ,
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text('پروتئین برای یک نفر', style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color: Color(0xff5C5C5C)
                 ),),
                 Text(total[2], style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color: Color(0xff5C5C5C)
                 ),),
               ],
             ),
           ),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
             decoration: BoxDecoration(
                 color:hGreen ,
                 borderRadius: BorderRadius.vertical(bottom:Radius.circular(15))
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text('چربی برای یک نفر', style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color: Colors.white
                 ),),
                 Text(total[3], style: TextStyle(
                     fontSize: 11*fontvar,
                     fontWeight: FontWeight.w400,
                     color:  Colors.white
                 ),),
               ],
             ),
           ),

         ],


       )

        
        
      ],
      
      
    );
      
    

    
  }
}
