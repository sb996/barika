import 'dart:convert';
import 'package:barika_web/helper.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/models/userweight.dart';
import 'package:barika_web/profile/profileScreen.dart';
import 'package:barika_web/services/apiServices.dart';

import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
class weightDialog extends StatefulWidget {
  State<StatefulWidget> createState() => weightDialogState();
}

class weightDialogState extends State<weightDialog> {
  int water;
  double _weightValue=0.0;
  User _user ;
  String date;
  @override
  void initState() {
    date=dateCall.getDate()??getDateToday();

    // TODO: implement initState
    setInfo();
    super.initState();
  }

  TextEditingController _weightC=new TextEditingController();
  double fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;
    // TODO: implement build
    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
      return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: screenSize.width,
            height:  400 / 595 * screenSize.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 15),
                      width: screenSize.width,
                      height:  120 / 595 * screenSize.height,
                      decoration: BoxDecoration(
                          color: Color(0xffE040FB),
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/icons/vazn.png',
                            width:  42 / 595 * screenSize.height,
                            height:  42 / 595 * screenSize.height,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'میزان وزن  خود را به کیلوگرم وارد کنید',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15*fontvar,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
//                          Container(
//                              margin: EdgeInsets.only(top: 12),
//                              child: Text(
//                                _weightValue.toStringAsFixed(1)+  ' کیلو گرم',
//                                style: TextStyle(
//                                    color: Color(0xffffffff),
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 16),
//                                textDirection: TextDirection.rtl,
//                              )),
//                          Text(
//                            ' وزن شما در هفته پیش $_weightValue  کیلوگرم بوده است.',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 11,
//                                fontWeight: FontWeight.w400),
//                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                      Padding(
                        padding: EdgeInsets.only(right: 25, left: 25, top: 5,bottom: 20),
                        child: new TextFormField(
                          controller: _weightC,
                          onTap: (){
                            _weightC.selection = TextSelection.fromPosition(TextPosition(offset: _weightC.text.length));
                          },
                          textAlign: TextAlign.center,
                          // inputFormatters: [DecimalTextInputFormatter(decimalRange: 1)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          style:  TextStyle(
                              color: Color(0xff5c5c5c),
                              fontWeight: FontWeight.w500,
                              fontSize: 15*fontvar),
                          onChanged: (text) {
                            text= changeDigit( text);
                            print(text);
                            _weightValue=double.parse(text);
                          },
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                  new BorderSide(   color: Color(0xffE040FB), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide:
                                  new BorderSide(   color: Color(0xffE040FB), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              focusedBorder: new OutlineInputBorder(
                                  borderSide:
                                  new BorderSide( color: Color(0xffE040FB), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              hintText: 'وزن',
                              hintStyle:  TextStyle(
                                  color: Colors.black26,
                                  fontSize: 14*fontvar,
                                  fontWeight: FontWeight.w500),
                              contentPadding: const EdgeInsets.only(
                                  top: 10, right: 8, bottom: 10, left: 8)),
                        ),
                      ),
                  Container(
                    width:  120 / 375 * screenSize.height,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        color: Color(0xffE040FB),
                        onPressed: () async {


                         await update();
                         // profileScreen().createState();
                         Navigator.pop(context, 'yes');

                        },
                        child: Text(
                          'ثبت',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16*fontvar),
                        )),
                  )
                ]),
          );
    });
  }

  setInfo() async {
    var response = await getUser();
    setState(() {
      _user = response;
      print(_user.toMap().toString());
      _weightValue=double.tryParse(_user.weight);
      _weightC.text=_weightValue.toString();

      searchByDate(_user.uid);

    });
  }

  Future<void> update() async {

    if( calculateAge(_user.birthdate)>3) calculateCalory();

    _user.weight=_weightValue.toStringAsFixed(1);
  await  updateUser(_user);
    UserWeight userWeight=await searchByDate(_user.uid);

    userWeight==null
        ?addUserWeight()
        :updateUserWeight(userWeight);


  }
  static Future<User> getUser() async {
//     User user;
//     try {
//       var db = new userProvider();
//       await db.open();
//       user= await db.paginate();
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString()+"errrrrorrrrrgetUser");
//       return null;
//     }
  }
  static Future<User> updateUser(User user) async {
// print(user.id.toString());
//     try {
//       var db = new userProvider();
//       await db.open();
//       await db.update(user);
// //      await db.close();
//     } catch (e) {
//       print(e.toString()+"errrrrorrrrrupdateUser");
//       return null;
//     }
  }
   Future<UserWeight> searchByDate(String uid) async {

//     UserWeight userWeight;
//     try {
//       var db = new userWeightProvider();
//       await db.open();
//       print(uid);
//       userWeight=await db.searchbyDate(date,uid,"weight");
// //      await db.close();
//       return userWeight;
//     } catch (e) {
//       print(e.toString()+"errrrrorrrrrsearchByDate");
//       return null;
//     }
  }
  static Future<UserWeight> addUWeight(   UserWeight userWeight) async {

//     try {
//       var db = new userWeightProvider();
//       await db.open();
//       await db.insert(userWeight);
// //      await db.close();
//     } catch (e) {
//       print(e.toString()+"errrrrorrrrraddUWeight");
//       return null;
//     }
  }
  static Future updateUWeight(   UserWeight userWeight) async {
//     print(userWeight.toMap().toString()+"iu");
//     try {
//       var db = new userWeightProvider();
//       await db.open();
//       int r=await db.update(userWeight);
// //      await db.close();
//       return r;
//     } catch (e) {
//       print(e.toString()+"errrrrorrrrrupdateUWeight");
//       return null;
//     }
  }
  addUserWeight() async {

    var map2={
      'date':date,
      'weight':_user.height,
      'type':"height",
      'uid':_user.uid
    };
    UserWeight userHeight=UserWeight.fromJson(map2);


    var map={
      'date':date,
      'weight':_weightValue.toStringAsFixed(1),
      'type':"weight",
      'uid':_user.uid
    };
    UserWeight userWeight=UserWeight.fromJson(map);
    print( await addUWeight(userWeight));
    print( await addUWeight(userHeight));

  }
  Future<void> updateUserWeight(  UserWeight userWeight) async {
    userWeight.weight= _weightValue.toStringAsFixed(1);
    if(await checkConnectionInternet())
      _updateSetver();
    print(await updateUWeight(userWeight));

  }
  Future _updateSetver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    final newPost = {
      'weight': _weightValue.toStringAsFixed(1),
    };
    final response = await Provider.of<apiServices>(context)
        .updateUserInfo(newPost, 'Bearer ' + apiToken);
    if (response.statusCode == 200) {
      final post = json.decode(response.bodyString);
      final code = post['code'].toString();
      print(response.bodyString);
    }


    // We cannot really add any new posts using the placeholder API,
    // so just print the response to the console
//      print('${response.body.toString()}   aaaa  ${nameController.text}  sss ${response.statusCode.toString()}');
    }
  calculateCalory() {
    {
      int activity1 = int.parse(_user.activity);
      int appetite1 = int.parse(_user.appetite);
      String weight1 = _weightValue.toStringAsFixed(1);
      String height1 = _user.height;
      int age1 = calculateAge(_user.birthdate);
      String gender1 = _user.gender;

      double height_meter = double.parse(height1) / 100;
      double BMR =
          10 * double.parse(weight1) + 6.25 * double.parse(height1) - 5 * age1;
      if (gender1 == 'male') {
        BMR = BMR + 5;
      } else {
        BMR = BMR - 161;
      }
      double res = BMR;

      if (activity1 == 1) {
        res *= 1.1;
      } else if (activity1 == 2) {
        res *= 1.25;
      } else if (activity1 == 3) {
        res *= 1.4;
      } else if (activity1 == 4) {
        res *= 1.55;
      } else if (activity1 == 5) {
        res *= 1.7;
      }


      if (appetite1 == 1) {
        res *= 0.95;
      } else if (appetite1 == 2) {
        res *= 0.975;
      } else if (appetite1 == 3) {
        res *= 1;
      } else if (appetite1 == 4) {
        res *= 1.025;
      } else if (appetite1 == 5) {
        res *= 1.05;
      }

      double ideal_weight = 22.5 * height_meter * height_meter;
      String min_period = (20 * height_meter * height_meter).toStringAsFixed(1);
      String max_period = (25 * height_meter * height_meter).toStringAsFixed(1);
      double diff_weights = double.parse(weight1) - ideal_weight;
      if (diff_weights < 0) {
        diff_weights = diff_weights * -1;
      }
      double recommended_weight = ideal_weight + (0.2 * diff_weights);
      if(_user.gcalorie!=null) res=res+_user.gcalorie;
      if(res<600)res=600;
      _user.calorie = res.floor();
      _user.ideal_weight = ideal_weight.round();
      _user.period_weight = "$min_period - $max_period";
      _user.recommended_weight = recommended_weight.round();
      if(_user.gcalorie!=null){
        int usergc=_user.gcalorie;
        if (_user.gcalorie < 0) {
          switch (_user.gcalorie) {
            case -100:
              usergc = -100;
              break;
            case -190:
              usergc = -200;
              break;
            case -270:
              usergc = -300;
              break;
            case -340:
              usergc = -400;
              break;
            case -400:
              usergc = -500;
              break;
            case -460:
              usergc = -600;
              break;
            case -510:
              usergc = -700;
              break;
            case -560:
              usergc = -800;
              break;
            case -600:
              usergc = -900;
              break;
            case -640:
              usergc = -1000;
              break;
          }}





        double difWeight=_weightValue-double.parse(_user.gweight);
        int week=(difWeight*1000/usergc.abs()).ceil();
        if(_user.gcalorie>0) week*=-1;

        var now = new DateTime.now();
        final custom = intl.DateFormat('yyyy-MM-dd').format((new DateTime(
          now.year,
          now.month,
          now.day + week * 7,
        )));

        String date1=_user.gdate.split("*")[0];
        _user.gdate=date1+"*"+custom.toString();




      }

    }
  }
}
