// import 'package:barika/utils/SizeConfig.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:barika/utils/colors.dart';
//
// class exitDialog extends StatefulWidget {
//   State<StatefulWidget> createState() => exitDialogState();
// }
//
// class exitDialogState extends State<exitDialog> {
//
//
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     fontvar = (bh) / 3.75;
//     if(fontvar>2)fontvar=1.7;
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     return StatefulBuilder(builder: (BuildContext context, StateSetter setState
//         /*You can rename this!*/) {
//     return   Container(
//
//       alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(10))
//
//             ),
//             width: screenSize.width,
//             height:  250*(screenSize.height)/595,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//
//                       Container(
//                         width: screenSize.width,
//                         height: 50*(screenSize.height)/595,
//                         decoration: BoxDecoration(
//                             color: MyColors.vazn,
//                             borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10))
//
//                         ),
//                         child:  IconButton(alignment: Alignment.topRight,icon: Icon(Icons.clear,color: Colors.white,size: 30,), onPressed: (){ Navigator.of(context).pop();}),
//
//
//
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15,),
//                     child:
//                     Text(
//
//                       'آیا میخواهید از حساب کاربری خود خارج شوید؟',
//                       style: TextStyle(
//
//                           color: MyColors.vazn,
//                           fontSize: 16*fontvar,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.center,
//                     ),
//
//                   ),
//                   Expanded(child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       FlatButton(
//
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                                 color: MyColors.vazn,
//                                 width: 1
//                             ),
//                             borderRadius: new BorderRadius.circular(15),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//
//                           onPressed: () {Navigator.pop(context, 'yes');
//                           },
//                           child: Text(
//                             'بله',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: MyColors.vazn,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14*fontvar),
//                           )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       FlatButton(
//                           shape: RoundedRectangleBorder(
//
//                             borderRadius: new BorderRadius.circular(15),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//                           color: MyColors.vazn,
//                           onPressed: () {
//                             Navigator.pop(context, 'no');
//
//                           },
//                           child: Text(
//                             'خیر',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14*fontvar),
//                           )),
//
//                     ],
//
//
//                   ))
//
//
//                 ]),
//
//
//
//
//           );
//
//
//
//     }
//
//     );
//
//
//   }
//     }
//
