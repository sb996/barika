
import 'package:barika_web/models/store.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart'as intl;


class storeDialog extends StatefulWidget {
  store allStores;
  int value;
  String country;
  storeDialog({this.allStores,this.value,this.country});

  State<StatefulWidget> createState() => storeDialogState();
}

class storeDialogState extends State<storeDialog> {
  int water;
  store _allStores;
  int value;
  String country;
  @override
  void initState() {
    _allStores = widget.allStores;
    value=widget.value;
    country=widget.country;
    super.initState();
  }
  final formatter = new intl.NumberFormat("###,###");
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


      return Container(

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: screenSize.width,
          child: ListView(
    shrinkWrap: true,
                children: <Widget>[
                Container(
                  alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(

                          borderRadius:  BorderRadius.circular(8.0),
                          child: FadeInImage(
                            alignment: Alignment.centerRight,
                            placeholder:
                            AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(_allStores.cover),
                            fit: BoxFit.contain,
                            height: 90*(screenSize.width)/375,

                          ),
                        )),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      _allStores.name,
                      style: TextStyle(
                          color: Color(0xff334856),
                          fontSize: 14*fontvar,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 12, left: 12),
                    child: Text(
                      ' ${_allStores.description}',
                      style: TextStyle(
                          color: Color(0xff334856),
                          fontSize: 13*fontvar,
                          fontWeight: FontWeight.w400),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                   GestureDetector(
                        child: Container(
                          width: double.infinity,
                          decoration:BoxDecoration(
                              borderRadius:
                               BorderRadius.circular(5.0),
                              color: Colors.green
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                          margin: EdgeInsets.only(left: 8,right: 8,bottom: 7,top: 20),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset('assets/icons/store.png',width: 12*(screenSize.width)/375,height:12*(screenSize.width)/375,),
                              Padding(padding: EdgeInsets.only(top: 0,right:3 ,left: 1,),child:   Text(
      formatter.format(value) ,

                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12*fontvar,
                                    color: Colors.white),
                                maxLines: 2,
                              ),),
                               Text(
                                country=="98"?" تومان": ' یورو',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11*fontvar,
                                    color: Colors.white),
                                maxLines: 2,
                              ),
                            ],

                          ),

                        ),
                    onTap: (){goLucher();},
                    )


                  ],
              ),
      );
  }

  void goLucher() {

//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) =>
//            Directionality(
//                textDirection: TextDirection  .rtl, child: FirstPayment(userid: "51",diet:"یب" ,amount:"21" ,)),
//      ),
//    );

  Navigator.pop(context,"yess");
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) =>
//            Directionality(
//                textDirection: TextDirection.rtl, child: BackPayment(arg: "faile",)),
//      ),
//    );

//    Response response = await remote.Payment(
//        price,
//        "خرید رژیم چربی خون (ios)",
//        await Utils.getPhone(
//    ),
//    json.encode(
//    DietPayload.Diet(
//    user,
//    widget._name, "heart", "blood_fat", tempTee, cal)),
//    await Utils.getToken(
//    ));
//    if (response.isSuccessful) {
//    final res = json.decode(
//    response.bodyString);
//    if (await canLaunch(
//    res['pay_url'])) {
//    await launch(
//    res['pay_url'],forceSafariVC: false);
//    new DeepLinksUtil(
//    ).initUniLinks(
//    );
//    } else {
//    throw 'Could not launch';
//    }
//    } else
//    Fluttertoast.showToast(
//    msg: "خطایی رخ داده مجدد تلاش کنید",
//    toastLength: Toast.LENGTH_SHORT,
//    gravity: ToastGravity.BOTTOM,
//    timeInSecForIos: 1,
//    backgroundColor: Colors.red,
//    textColor: Colors.white,
//    fontSize: 16.0
//    );
//  }


  }
}
