
import 'package:barika_web/models/cereals.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class unitConvertDialog extends StatefulWidget {
  List <cereals>cerealsList ;
  unitConvertDialog({this.cerealsList});

  State<StatefulWidget> createState() => unitConvertDialogState();
}

class unitConvertDialogState extends State<unitConvertDialog> {
  List <cereals>_cereals =[];
  @override
  void initState() {
    _cereals=widget.cerealsList;
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

      return Container(

          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: screenSize.width,
          child: Stack(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cereals.length,
                  itemBuilder: (context, index) {
                    return  ListTile(
                        onTap: (){
                          Navigator.pop(context,_cereals[index]);
                        },
                        hoverColor: Colors.green.withOpacity(0.3),
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          child:  Text(_cereals[index].name, style: TextStyle(
                              fontSize: 12*fontvar, fontWeight: FontWeight.w400
                          ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ));
                  }


              ),
             Align(
               child:  Image.asset( 'assets/icons/vscroll.png',width: 20,height: 25, ),alignment: Alignment.centerLeft,
             )
            ],
          )
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
