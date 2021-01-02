
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class regimDialog extends StatefulWidget {
  State<StatefulWidget> createState() => regimDialogState();
}

class regimDialogState extends State<regimDialog> {
@override
  void initState() {
  print("regimi");
  // TODO: implement initState
    super.initState();
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

  // TODO: implement build
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
    return   Container(

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

            ),
            width:screenSize.width,
            height: 350*(screenSize.width)/375,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      Container(
                        width: screenSize.width,
                        height:120*(screenSize.width)/375,
                        decoration: BoxDecoration(
                            color: MyColors.green,
                            borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))

                        ),
                        child:  IconButton(alignment: Alignment.topRight,icon: Icon(Icons.clear,color: Colors.white,size: 30,), onPressed: (){ Navigator.of(context).pop();}),

                      ),
                      Container(
                          width: 95*(screenSize.width)/375,
                          height:95*(screenSize.width)/375,
                          margin: EdgeInsets.only(top: 70*(screenSize.width)/375),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset('assets/icons/ic_dialog.png',
                              color:MyColors.green,width: 80*(screenSize.width)/375,height: 80*(screenSize.width)/375,),
                          )
                      )

                    ],


                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15,),
                    child:
                    Text(

                      'رژیم را برای چه کسی می خواهید دریافت کنید؟',
                      style: TextStyle(

                          color: MyColors.green,
                          fontSize: 16*fontvar,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),

                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[


                      Expanded(child:       FlatButton(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: MyColors.green,
                                width: 1
                            ),
                            borderRadius: new BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),

                          onPressed: () {
                            Navigator.pop(context, 'yes');

                          },
                          child: Text(
                            'دیگران',
                            style: TextStyle(

                                color: MyColors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 14*fontvar),
                          ))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child:  FlatButton(

                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: MyColors.green,
                                width: 1
                            ),
                            borderRadius: new BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          color: MyColors.green,
                          onPressed: () {Navigator.pop(context, 'no');
                          },
                          child: Text(
                            'خودم',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14*fontvar),
                          )),)

                    ],


                  ),)
                
                
                ]),
            
            
            
            
          );



    }

    );


  }
    }

