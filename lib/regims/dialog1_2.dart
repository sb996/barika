
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class dialog1_2 extends StatefulWidget {
  double month;

  dialog1_2({Key key, this.month}) : super(key: key);

  State<StatefulWidget> createState() => dialog1_2State();
}

class dialog1_2State extends State<dialog1_2> {
  double month = 0;
  int _selected;

  @override
  void initState() {
    month = widget.month;
    print(month);
    // TODO: implement initState
    super.initState();
  }

  void onChanged(int value) {
    setState(() {
      _selected = value;
    });
    print('Value = $value');
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

    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: screenSize.width,
          height: screenSize.height / 1.5,
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenSize.width,
                      height: 40*(screenSize.width)/375,
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: IconButton(
                          alignment: Alignment.topRight,
                          icon: Icon(
                            Icons.clear,
                            color: Colors.green,
                            size: 30*(screenSize.width)/375,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        'یک رژیم را باتوجه به سن کودک انتخاب کنید',
                        style: TextStyle(
                            color: MyColors.green,
                            fontSize: 16*fontvar,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    (month <= 15)?
                      GestureDetector(
                        onTap: () {
                          onChanged(0);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Radio(
                                value: 0,
                                groupValue: _selected,
                                onChanged: (value) {
                                  onChanged(value);
                                }),
                            Text(
                              'ابتدای 13 ماهگی تا پایان 15 ماهگی ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12*fontvar),
                            )
                          ],
                        ),
                      ):Container(),
                     (month >= 15 && month <= 18)?
                      GestureDetector(
                        onTap: () {
                          onChanged(1);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Radio(
                                value: 1,
                                groupValue: _selected,
                                onChanged: (value) {
                                  onChanged(value);
                                }),
                            Text(
                              'ابتدای 16 ماهگی تا پایان 18 ماهگی ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12*fontvar),
                            )
                          ],
                        ),
                      ):Container(),
                     (month >= 18 && month <= 21)?
                      GestureDetector(
                        onTap: () {
                          onChanged(2);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Radio(
                                value: 2,
                                groupValue: _selected,
                                onChanged: (value) {
                                  onChanged(value);
                                }),
                            Text(
                              'ابتدای 19 ماهگی تا پایان 21 ماهگی ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12*fontvar),
                            )
                          ],
                        ),
                      ):Container(),
                     (month >= 21)?
                      GestureDetector(
                        onTap: () {
                          onChanged(3);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Radio(
                                value: 3,
                                groupValue: _selected,
                                onChanged: (value) {
                                  onChanged(value);
                                }),
                            Text(
                              'ابتدای 22 ماهگی تا پایان 24 ماهگی ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12*fontvar),
                            )
                          ],
                        ),
                      ):Container(),


                    Container(
                        padding: EdgeInsets.only(
                            right: 15, left: 15, bottom: 10, top: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: screenSize.width,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  color: MyColors.green,
                                  onPressed: () async {
                                    if (_selected != null) {
                                      String type = "";
                                      switch (_selected) {
                                        case 0:
                                          {
                                            type = "children13-15";
                                            break;
                                          }
                                        case 1:
                                          {
                                            type = "children16-18";
                                            break;
                                          }
                                        case 2:
                                          {
                                            type = "children19-21";
                                            break;
                                          }
                                        case 3:
                                          {
                                            type = "children22-24";
                                            break;
                                          }
                                      }
                                      Navigator.pop(context, type);
                                    }

                                  },
                                  child: Text(
                                    ' دریافت رژیم ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14*fontvar),
                                  )),
                            ),
                          ],
                        )),
                  ]),
            ]))
          ]));
    });
  }
}
