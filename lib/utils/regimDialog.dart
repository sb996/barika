import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'colors.dart';


class regimProfileDialog extends StatefulWidget {

  regimProfileDialog();

  State<StatefulWidget> createState() => regimProfileDialogState();
}

class regimProfileDialogState extends State<regimProfileDialog> {


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar=(bh)/3.75;
    if(fontvar>2)fontvar=1.7;
    var screenSize=MediaQuery.of(context).size;
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
    return  Container(

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))

      ),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,

      height:  300*(screenSize.height)/595,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height:150*(screenSize.width)/375,
                    padding: EdgeInsets.only(right: 5,left: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyColors.green,
                        borderRadius:  BorderRadius.only(topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))

                    ),
//                  child:  IconButton(alignment: Alignment.topRight,icon: Icon(Icons.clear,color: Colors.white,size: 30,), onPressed: (){ Navigator.of(context).pop();}),
                    child: Text(
                      "کاربر گرامی لطفا در وارد کردن اطلاعات خود دقت نمایید بعد از ثبت اطلاعات و دریافت رژیم مجاز به ویرایش اطلاعات خود نیستید.", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15*fontvar,
                        fontWeight: FontWeight.w600),textAlign: TextAlign.center,textDirection: TextDirection.rtl,)

                ),
                Container(
                    width: 60*(screenSize.width)/375,
                    height:60*(screenSize.width)/375,
                    margin: EdgeInsets.only(top: 130*(screenSize.width)/375),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset('assets/icons/ic_dialog.png',color:MyColors.green,width: 50*(screenSize.width)/365,height:50*(screenSize.width)/365,),
                    )
                )
              ],
            ),




            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                Expanded(child: FlatButton(
                    color: MyColors.green,
                      shape: RoundedRectangleBorder(

                        borderRadius: new BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),

                      onPressed: () {Navigator.pop(context, 'ok');
                      },
                      child: Text(
                        'ثبت اطلاعات',
                        style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.w500,
                            fontSize: 14*fontvar),
                      )),),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: MyColors.green,
                            width: 1
                        ),
                        borderRadius:  BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
             
                      onPressed: () async {

                        Navigator.pop(context, "edit");
                      },
                      child: Text(
                        'ویرایش اطلاعات',
                        style: TextStyle(
                            color: MyColors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 14*fontvar),
                      )),),
                  SizedBox(
                    width: 5,
                  ),
                ],


              ),

            )

          ]),




    );



    }

    );


  }

    }

