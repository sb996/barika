
import 'package:barika_web/models/DbDailyInfo.dart';

import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class waterDialog extends StatefulWidget {
  State<StatefulWidget> createState() => waterDialogState();
}

class waterDialogState extends State<waterDialog> {
  int water = 0;
  DbDailyInfo dailyInfo;
  String date;

  @override
  void initState() {
    // TODO: implement initState
    date = dateCall.getDate().toString();
    _getDailyInfo();
    super.initState();
  }
  var fontvar=1.0;
  bool showLoading=false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;
    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    print(screenSize.height.toString() + "hhh");
    // TODO: implement build
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: screenSize.width,
          height: 400 / 595 * screenSize.height,
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                if (index == 0)
                  return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.only(top: 15),
                      width: screenSize.width,
                      height: 150 / 375 * screenSize.width,
                      decoration: BoxDecoration(
                          color: Color(0xff24AEFC),
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/icons/water.png',
                            width: 40 / 375 * screenSize.width,
                            height: 40 / 375 * screenSize.width,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' مقدار آب مصرف شده امروز ${water} لیوان  ',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16*fontvar,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            'مقدار آب مناسب روزانه 6 تا 8 لیوان است',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ));
                else if (index == 1)
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (water > 0) {
                              water = water - 1;
                            }
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          size: 25 / 375 * screenSize.width,
                          color: Colors.white,
                        ),
                        shape: new CircleBorder(),
                        elevation: 5.0,
                        fillColor: Color(0xffFF3939),
                        padding: const EdgeInsets.all(15),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset(
                        'assets/icons/water.png',
                        width: 60 / 375 * screenSize.width,
                        height: 60 / 375 * screenSize.width * 2,
                        color: Color(0xff0D8EF1),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            water = water + 1;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 25 / 375 * screenSize.width,
                          color: Colors.white,
                        ),
                        shape: new CircleBorder(),
                        elevation: 5.0,
                        fillColor: Color(0xff2A56C6),
                        padding: const EdgeInsets.all(15.0),
                      ),
                    ],
                  );
                else if (index == 2)
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Text(
                      '${water} لیوان ',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Color(0xff5c5c5c),
                          fontSize: 20*fontvar,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                else if (index == 3)
                  return      Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                     Container(
                          margin:
                          EdgeInsets.only(right: 30,left:30,bottom: 15),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5),
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                              color: Color(0xff24AEFC),
                              onPressed: () async {
                               await _SearchByDate();
                               if(showLoading ==false) Navigator.pop(context, 'yes');
                              },
                              child: Text(
                                'ثبت',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16*fontvar),
                              )),
                        ),

                      (showLoading)?
                        SpinKitCircle(
                          color: Colors.white,
                          size: 20*(screenSize.width)/375,
                        ):Container(height: 0,width: 0,)
                    ],

                  );
                else
                  return Container(
                    height: 0,
                  );
              }));
    });
  }

  Future _updateDailyInfo(DbDailyInfo dailyInfo) async {
//     try {
//       var db = new DailyInfoProvider();
//       await db.open();
//       await db.update(dailyInfo);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
  }

  _getDailyInfo({bool refresh: false}) async {
    // var db = new DailyInfoProvider();
//     await db.open();
//     DbDailyInfo products = await db.getByDate(date);
//
// //    await db.close();
//     if (!(products == null)) {
//
//       dailyInfo = products;
//       setState(() {
//         water = int.parse(dailyInfo.water ?? '0');
//       });
//
//       print(water);
//     } else
//       () {};
  }

  _setInfoToUpdate() async {
    dailyInfo.water = water.toString();
    await _updateDailyInfo(dailyInfo);
  }

  addInfo() async {
    var map = {'date': date, 'water': water.toString()};
    DbDailyInfo dailyInfo = DbDailyInfo.fromJson(map);

    print(map);
    print(await _addDailyInfo(dailyInfo));
  }

  Future _addDailyInfo(DbDailyInfo dailyInfo) async {
    // try {
//       var db = new DailyInfoProvider();
//       await db.open();
//       DbDailyInfo AddeddailyInfo = await db.insert(dailyInfo);
// //      await db.close();
//       return AddeddailyInfo;
//     } catch (e) {
//       return false;
//     }
  }

  Future _SearchByDate() async {
//     setState(() {
//       showLoading=true;
//     });
//
//     var db = new DailyInfoProvider();
//     await db.open();
//     DbDailyInfo products = await db.getByDate(date);
// //    await db.close();
//     (products == null) ? await addInfo() :await _setInfoToUpdate();
//     setState(() {
//       showLoading=false;
//     });
  }
}
