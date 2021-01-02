
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class deletegDialog extends StatefulWidget {
  State<StatefulWidget> createState() => deletegDialogState();
}

class deletegDialogState extends State<deletegDialog> {
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

    // TODO: implement build
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: screenSize.width,
        height: 250*(screenSize.height)/595,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenSize.width,
                height:  50*(screenSize.height)/595,
                decoration: BoxDecoration(
                    color: MyColors.vazn,
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size:  32*(screenSize.width)/375,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
             Expanded(child: Column(
               mainAxisAlignment: MainAxisAlignment.center,

               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: 10,
                     vertical: 15,
                   ),
                   child: Text(
                     'آیا میخواهید هدف خود را حذف کنید؟',
                     style: TextStyle(
                         color: MyColors.vazn,
                         fontSize: 16*fontvar,
                         fontWeight: FontWeight.w600),
                     textAlign: TextAlign.center,
                   ),
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     FlatButton(
                         shape: RoundedRectangleBorder(
                           side: BorderSide(color: MyColors.vazn, width: 1),
                           borderRadius: new BorderRadius.circular(15),
                         ),
                         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                         onPressed: () {
                           Navigator.pop(context, 'yes');
                         },
                         child: Text(
                           'بله',
                           style: TextStyle(
                               color: MyColors.vazn,
                               fontWeight: FontWeight.w500,
                               fontSize: 14*fontvar),
                         )),
                     SizedBox(
                       width: 10,
                     ),
                     FlatButton(
                         shape: RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(15),
                         ),
                         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                         color: MyColors.vazn,
                         onPressed: () {
                           Navigator.pop(context, 'no');
                         },
                         child: Text(
                           'خیر',
                           style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w500,
                               fontSize: 14*fontvar),
                         )),
                   ],
                 )
               ],
             ))
            ]),
      );
    });
  }
}
