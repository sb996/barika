import 'dart:async';

import 'package:barika_web/introSlider/introSlider.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {


  startTime() {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, checkLogin);
  }

  navigationLogin() {
    Navigator.of(context).pushReplacementNamed('/language');
  }

  navigationHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Navigator.of(context).pushReplacementNamed('/main');
  }


  String _version = "1.1.18 نسخه ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getVesion();
    startTime();

    //s startTime();
  }

  var loginColor = Color(0xffF15A23);
  var signupColor = Color(0xFF6DC07B);
  var textColor = Color(0xff51565F);
  var fontvar = 1.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);

    return new Scaffold(

        backgroundColor: signupColor,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset('assets/images/bg_intro.png',
              color: Colors.white,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              height: screenSize.height / 3,
            ),

            Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Image.asset('assets/images/logoorange.png',
                      fit: BoxFit.contain,
                      width: 109 * (screenSize.width) / 375,
                      height: 120 * (screenSize.width) / 375,),
                    Padding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("دکتر مجید محمدشاهی",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15 * fontvar,
                                  fontWeight: FontWeight.w500
                              ),),
                            Text("دکتر فاطمه حیدری",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15 * fontvar,
                                  fontWeight: FontWeight.w500
                              ),),
                            Text("متخصصین تغذیه و رژیم درمانی",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15 * fontvar,
                                  fontWeight: FontWeight.w400
                              ),),
                            Text("اساتید دانشگاه علوم پزشکی",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15 * fontvar,
                                  fontWeight: FontWeight.w400
                              ),),

                          ],
                        ),
                        padding: EdgeInsets.only(
                            bottom: 20, right: 15, left: 15, top: 35)
                    ),


                  ],
                )),
            Align(
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 25),
                child: Text(_version,
                  style: TextStyle(
                      color: Color(0xFF6DC07B),
                      fontSize: 15 * fontvar,
                      fontWeight: FontWeight.w600
                  ),
                  textDirection: TextDirection.ltr
                  ,),
              ),
              alignment: Alignment.bottomCenter,
            )

          ],
        ));
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    // prefs.setString('user_token',"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjIyN2EyNjYyYTY2Y2NjOThmYWQ5NjY3MTZmYmE4NjExYTRhOGY3MGJiNzIyZmRhNjg3NjQ0ODIyOTJhNGJmMzA1YjRjNGE5NjcyNGE4MDA0In0.eyJhdWQiOiIxIiwianRpIjoiMjI3YTI2NjJhNjZjY2M5OGZhZDk2NjcxNmZiYTg2MTFhNGE4ZjcwYmI3MjJmZGE2ODc2NDQ4MjI5MmE0YmYzMDViNGM0YTk2NzI0YTgwMDQiLCJpYXQiOjE2MDkzNjIwNjQsIm5iZiI6MTYwOTM2MjA2NCwiZXhwIjoxNjQwODk4MDY0LCJzdWIiOiI5NjkwIiwic2NvcGVzIjpbXX0.FV7_Pl3G8lmLeQOTopPJIcNTD0DnLm95QVl2aMefwmEw0Dyb8yHJIwS4EY8AAxTHrp-OH61Q1b9RaBF8k5K0a6k0LvvEyN1rw_5kGsXaYO3TUqNgX1fzCUtAh0U4xSbevlRCbQfXLINWplVuGYwuLAZ8szWqamQK_3sIYoYKn7T2avILXZGeYnd_91bR7uURE-RZktc8xZW5S4wzOmHxaqeOdgbwzQHIA0hzmfSG6yI8sOSOIAG7RzZDQ-pw6_zBLlkmnjuOnGj66wWrcnOqgOcxOII6gcy04OAPurMowsduCWMEriWrI9eaKcuqBKbLyEb2nNFYYHHwKLhdRC5qrMM2XnD7fg3ZCCDZO0NtGKIZiN9LOD1Eny3yxZTCxcmpGP3yk_pQq1R1Wkp0RmOtpIVGz4k158Hg7QuUMMcIREpdpEaXTIOgAb6A91v1Jadq4_RNNO2oDGuFjeL7JOF6wBzX-IVc58rSHn4ICIa-4OZ85rUNQbLK3g5jwR9hg3EHT8_imvUAKc0ZURnsfmR8AbSTlqRY2PaEIJNkMvb1N8rK8Ut-l-jRTkYzVarLpO_rEzyk7KVGpWgZN0Vu9-TtD3cxj0LW3A4QElpznQ4sXhIjRz0c5GzVQVggTSGoD7CzmNuX_JGCJ-aSAp-tCfmS5IBAxPHboJOCoNmqKiuAPIo");
//
//    prefs.setString('user_token',"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjBlY2RhNGQ4NWUyMTMzMzE5YmM0NGNlMDMyMTI0NWMxNjZkYzM0Yzk5MDMwN2I5OTU3MDQ5ODZiODhhZjEyNGIxYjNiZmQyZGQ4NTU5YWYzIn0.eyJhdWQiOiIxIiwianRpIjoiMGVjZGE0ZDg1ZTIxMzMzMTliYzQ0Y2UwMzIxMjQ1YzE2NmRjMzRjOTkwMzA3Yjk5NTcwNDk4NmI4OGFmMTI0YjFiM2JmZDJkZDg1NTlhZjMiLCJpYXQiOjE1OTY3OTQ0NDQsIm5iZiI6MTU5Njc5NDQ0NCwiZXhwIjoxNjI4MzMwNDQ0LCJzdWIiOiIyMTk1Iiwic2NvcGVzIjpbXX0.m31jcE9Nj_EA1Wa7GKFElU7EYgYA0C36DER6btX6QN1_8JAGP_ynncDQ_3dXlqHGGyu9LC552-HNv80bVQ1SzYz00vIjFSguOrgx_Xe324wIfehHohyXX3rU2PT7kuc7w7dYuwibI_LpvvMfsunHyLT1Xib_6HCJa_DR7AFkPHG0cx-U4IM5mVtvv8d_iXOJozqhBKepd4avAcFt4A_fM2LSvxLOaoLRyVtAVyz4t9qoYAqiQgepVx75VYVOFVJ82UPEm_Ie28b117S1OiLDJQdHNZZvXmpjZz7Gg-y6trho78SFvSUVs-Gs0aTmaYWArkz6yXcEw4RKAgHClF3YEg2GXC700LCY0wcpzbDD-bIEbcV0izdTGn0mMckzPqvbyG5vOpgoqc7sVbNPeaCi6EqO12a9W7yWgfrL9pG7b3tikMv72_C8bleMgxRQ5MjJ7jFdkEXaniqRbaehyToTcgDZrHl6TXMRVOw7Ybj_SqwrvFSf6SuvyLtHcVggKtXmdmh2CcpcvShnQsarxVJb8Inzz2h-O8uMYi1Bx0PdBH2M2rGtYAR9Qts1Upxhm5nFXZod3-yrBVr-ka4xcrRtSc-axBG1TaOtwUUVBRGh2iCGiJxFKg2dSWqDdzo3SHCWHB6VB9GNvIWhJt1-_ULNDiv8i29AWAt1jPsGKWJ6IYc");
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) => Directionality(textDirection: TextDirection.rtl, child:getInfo()),
//      ),
//    );
    if (_seen) {
      String apiToken = prefs.getString('user_token');
      print('shared read ${apiToken}');
      if (apiToken == null) {
        navigationLogin();
      }

//      else if (await checkConnectionInternet()) {
//        checkTokenFromServer(apiToken);
//      }
      else {
        navigationHome();
      }
    }
    else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroSlider()));
    }
  }

}




// import 'dart:async';
// import 'package:barika_web/models/user.dart';
//
// import 'package:barika_web/utils/SizeConfig.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new SplashScreenState();
// }
//
// class SplashScreenState extends State<SplashScreen> {
//
//
//   User _user;
//   startTime() {
//     var _duration = new Duration(seconds: 3);
//     return new Timer(_duration, checkLogin);
//   }
//
//   navigationLogin() {
//     Navigator.of(context).pushReplacementNamed('/language');
//   }
//
//   navigationHome() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String get_info = prefs.getString('get_info');
//     print('shared read ${get_info}');
//     if (get_info == null)
//       Navigator.of(context).pushReplacementNamed('/getInfo');
//     else{
//       _user=  await _getUser();
//       (_user==null||_user.birthdate=="0")
//           ? Navigator.of(context).pushReplacementNamed('/userInfo')
//           : Navigator.of(context).pushReplacementNamed('/main');}
//   }
//
//   String _version="1.1.18 نسخه ";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
// //    getVesion();
//     startTime();
//
//     //s startTime();
//   }
//   Future<void> getVesion() async {
//
//   }
//   var loginColor = Color(0xffF15A23);
//   var signupColor = Color(0xFF6DC07B);
//   var textColor = Color(0xff51565F);
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
//     // if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     return  Scaffold(
//
//         backgroundColor: signupColor,
//         body:  Stack(
//           alignment: AlignmentDirectional.center,
//
//           children: <Widget>[
//
//
//             Center(
//                 child:Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Expanded(
//                       child:         Image.asset('assets/images/bg_intro.png',
//                         color: Colors.transparent,
//                         fit: BoxFit.contain,
//                         alignment: Alignment.bottomCenter,
//                         // height: screenSize.height / 3,
//                       ),
//                     ),
//                     Image.asset('assets/images/logoorange.png',
//                       fit: BoxFit.contain,
//                       width: 109*(screenSize.width)/375,
//                       height: 120*(screenSize.width)/375,),
//                     Padding(
//                         child:  Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text("دکتر مجید محمدشاهی",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w500
//                               ),),
//                             Text("دکتر فاطمه حیدری",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w500
//                               ),),
//                             Text("متخصصین تغذیه و رژیم درمانی",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w400
//                               ),),
//                             Text("اساتید دانشگاه علوم پزشکی",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w400
//                               ),),
//
//                           ],
//                         ),
//                         padding: EdgeInsets.only(bottom: 20,right: 15,left: 15,top:35)
//                     ),
//                     Expanded(
//                       child:         Image.asset('assets/images/bg_intro.png',
//                         color: Colors.white,
//                         fit: BoxFit.fill,
//                         alignment: Alignment.bottomCenter,
//                         width: screenSize.width,
//                       ),
//                     )
//
//
//                   ],
//                 )),
//             // Align(
//             //   child:      Padding(
//             //     padding: EdgeInsets.only(top:15,bottom: 25),
//             //     child:Text(_version,
//             //       style: TextStyle(
//             //           color:  Color(0xFF6DC07B),
//             //           fontSize:15*fontvar,
//             //           fontWeight: FontWeight.w600
//             //       ),
//             //       textDirection: TextDirection.ltr
//             //       ,) ,
//             //   ),
//             //   alignment: Alignment.bottomCenter,
//             // )
//
//           ],
//         ));
//   }
//
//   checkLogin() async {
//
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // bool _seen = (prefs.getBool('seen') ?? false);
//    // prefs.setString('user_token',"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjhiM2I5NjE3ODJlNDlhMTMyMmM5YzA2M2ZiM2RkMzAwNTYwZDE4ZDk2M2Y4MTg4YzMxOTBhYTk5YTA3OTFlNjdjZGYzZWFiMTdiNmFmMmU3In0.eyJhdWQiOiIxIiwianRpIjoiOGIzYjk2MTc4MmU0OWExMzIyYzljMDYzZmIzZGQzMDA1NjBkMThkOTYzZjgxODhjMzE5MGFhOTlhMDc5MWU2N2NkZjNlYWIxN2I2YWYyZTciLCJpYXQiOjE2MDUwMDI1MzIsIm5iZiI6MTYwNTAwMjUzMiwiZXhwIjoxNjM2NTM4NTMyLCJzdWIiOiI5NjQ5Iiwic2NvcGVzIjpbXX0.AElo3pgdUh_jShl_i6E48VXXMOG3mQQngoV6Fa6fL1TCCM-IspahEGXCfM0AQp34cTbW6WqMxz7PUK8Ari4hs-_7Dl2xU59zG1VNNGCU2QDgVR57BNzE_gjNkYlc9SWCzMP1OCwuz6mvE1n_S_kPv4AUPRuZgRSBqemWg2nWqcliQsMGJAbEWltMWmMXwxZAgp82vQvu4ZAHweuZJmerCBii_QqWtTpkwFRltasmqlEdhsWf92MSN0AYPZHLMUNeC2FP-Xjk1JM-obZgL5KpCgI_KJDsyH660wgd8KtJomqvrF3EtdWBlftElKzWdfzphCWaDjwljCm6XxKUfsH_kzpS_QBl7XKxojBZ-kuwNz2amZkpTY5Pxady8-GMkCOnAmp2-pcui3IpsUTc42jwHmJt8rfk7GMN3QFsy9nK81VBYBrc4226hMk8LTdz8CppKbPk35WNXpEZgw4JgskZcUDaofsji7Lu1iqR2Xqg2XgUzuTKXEy2yL92hvwed21lR9X7zKiibBdXdj0KGc-3YWKkbUt8-FbFRRcIuFzk3vXjncvXE_hobRZm7SLf0iAdmGE5wh16oCSO5PHlh1B07Qx57YOBwtIL9yexOVeTB3mKCoV6fHgGvcZK9UsTfezNE4Z7m8awd2oUWqjVu5R0WDiKIqHbCiMvBEiXOdIExFs");
//
//    // prefs.setString('user_token',"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjczMzFlZWQ5NDZkMWJmNDc5Y2ZmNTgyMTIzZDUzOGY2NzdhNThhNzA0ODI4NzhiMWYzNWRmZjI0ZWU3ZTNiMTY1NDlkNGIzMmIzMDU1MDQzIn0.eyJhdWQiOiIxIiwianRpIjoiNzMzMWVlZDk0NmQxYmY0NzljZmY1ODIxMjNkNTM4ZjY3N2E1OGE3MDQ4Mjg3OGIxZjM1ZGZmMjRlZTdlM2IxNjU0OWQ0YjMyYjMwNTUwNDMiLCJpYXQiOjE2MDA5Mjg3NjksIm5iZiI6MTYwMDkyODc2OSwiZXhwIjoxNjMyNDY0NzY5LCJzdWIiOiI5Njg5Iiwic2NvcGVzIjpbXX0.BSUunjz55baAVHCssILZzlLPS6sarxFxxHXY8riZ0RRTBWGCEK_iRmV-Jb9XJwfqvLCZIWCDZBrSaFr8TSNAUVYAUjicBz_nIsFKZhWPTxeuRr2mLnBOnOvBLQDU1lC7wZ-7QxlQbHXx540vf1ERkhpVuMI7Z3CKIXo4hMJj2kqW-LtEQAux_DEodYgP3W8xAmVddFS3aGdMY68Skn2exYQfp_6gZhXmqjX7fjVkEkEU3F68oE1bxp0G9kAivzUZHaWNxzOAGedCAPoA4y7XVBoyE1Nyy1owofbzapt9g6Od3XNLlJ8YnSikoM43DcBsz5qBcUfbH1ZY5vZAFJfCkmdCbxtxZoClQd5Htf83y6mQD5HGDGuUZ5IRFM3hqtfTpRkIhM_QR2MqxKpHOyqVh9m-FnX_VNZ2vJ8xP8kuwj6ZEpsNxp9MtoewsXDV-wFKQ5Gsakn4YYD8Ltt0HaeTPgSV7jvN0o_qLhRJHNr6A_nNxy3_4AyP8Bq869ubegLoEhmCB-xMBbtt57gy_NE01YGKeIRSYHpovv3IPx1CZ7XxgD2dlPOCmnAotPl9bR3PjK2gZ0fXDPs1YvmsqqpB1jNRLws5QKUSMc-vW0N3U_2yulc_9pDgysmQlTYtio2Zu7OkjWd8IUyhd7jEBlfF-VhZ1zghaV0Gb37MR-tBn80");
//    prefs.setString('user_token',"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjIyN2EyNjYyYTY2Y2NjOThmYWQ5NjY3MTZmYmE4NjExYTRhOGY3MGJiNzIyZmRhNjg3NjQ0ODIyOTJhNGJmMzA1YjRjNGE5NjcyNGE4MDA0In0.eyJhdWQiOiIxIiwianRpIjoiMjI3YTI2NjJhNjZjY2M5OGZhZDk2NjcxNmZiYTg2MTFhNGE4ZjcwYmI3MjJmZGE2ODc2NDQ4MjI5MmE0YmYzMDViNGM0YTk2NzI0YTgwMDQiLCJpYXQiOjE2MDkzNjIwNjQsIm5iZiI6MTYwOTM2MjA2NCwiZXhwIjoxNjQwODk4MDY0LCJzdWIiOiI5NjkwIiwic2NvcGVzIjpbXX0.FV7_Pl3G8lmLeQOTopPJIcNTD0DnLm95QVl2aMefwmEw0Dyb8yHJIwS4EY8AAxTHrp-OH61Q1b9RaBF8k5K0a6k0LvvEyN1rw_5kGsXaYO3TUqNgX1fzCUtAh0U4xSbevlRCbQfXLINWplVuGYwuLAZ8szWqamQK_3sIYoYKn7T2avILXZGeYnd_91bR7uURE-RZktc8xZW5S4wzOmHxaqeOdgbwzQHIA0hzmfSG6yI8sOSOIAG7RzZDQ-pw6_zBLlkmnjuOnGj66wWrcnOqgOcxOII6gcy04OAPurMowsduCWMEriWrI9eaKcuqBKbLyEb2nNFYYHHwKLhdRC5qrMM2XnD7fg3ZCCDZO0NtGKIZiN9LOD1Eny3yxZTCxcmpGP3yk_pQq1R1Wkp0RmOtpIVGz4k158Hg7QuUMMcIREpdpEaXTIOgAb6A91v1Jadq4_RNNO2oDGuFjeL7JOF6wBzX-IVc58rSHn4ICIa-4OZ85rUNQbLK3g5jwR9hg3EHT8_imvUAKc0ZURnsfmR8AbSTlqRY2PaEIJNkMvb1N8rK8Ut-l-jRTkYzVarLpO_rEzyk7KVGpWgZN0Vu9-TtD3cxj0LW3A4QElpznQ4sXhIjRz0c5GzVQVggTSGoD7CzmNuX_JGCJ-aSAp-tCfmS5IBAxPHboJOCoNmqKiuAPIo");
//    // Navigator.pushReplacement(
//    //   context,
//    //   MaterialPageRoute(
//    //     builder: (context) => Directionality(textDirection: TextDirection.rtl, child:getInfo()),
//    //   ),
//    // );
//     Navigator.of(context).pushReplacementNamed('/main');
//
// //     if (_seen) {
// //       String apiToken = prefs.getString('user_token');
// //       print('shared read ${apiToken}');
// //       if (apiToken == null) {
// //         navigationLogin();
// //       }
// //
// // //      else if (await checkConnectionInternet()) {
// // //        checkTokenFromServer(apiToken);
// // //      }
// //       else {
// //         navigationHome();
// //       }
// //     }
// //     else {
// //       await prefs.setBool('seen', true);
// //       Navigator.of(context).pushReplacement(
// //           new MaterialPageRoute(builder: (context) => new IntroSlider()));
// //     }
//   }
//
// //  Future<void> checkTokenFromServer(String apiToken) async {
// //    try {
// //      final response = await Provider.of<apiServices>(context, listen: false)
// //          .getTokenActvation(
// //          'Bearer ' + apiToken);
// //      if (response.statusCode == 200) {
// //        final post = json.decode(response.bodyString);
// //        print(post.toString() + "post");
// //        print(post["message"]);
// //        if (post["message"] == "success")
// //          navigationHome();
// //        else
// //          navigationLogin();
// //      }
// //      else
// //        navigationHome();
// //    }
// //    catch (e) {
// //      print (e.toString());
// //      navigationHome();
// //    }
// //  }
//
//   _getUser() async {
//     var response = await getUser();
//
//     if (this.mounted) {
//       _user = response;
//
// //      print(_user.toMap());
//
//     }
//     return _user;
//   }
//
//    Future<User> getUser()  {
//
//     }
//   }
//
// // eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjIyN2EyNjYyYTY2Y2NjOThmYWQ5NjY3MTZmYmE4NjExYTRhOGY3MGJiNzIyZmRhNjg3NjQ0ODIyOTJhNGJmMzA1YjRjNGE5NjcyNGE4MDA0In0.eyJhdWQiOiIxIiwianRpIjoiMjI3YTI2NjJhNjZjY2M5OGZhZDk2NjcxNmZiYTg2MTFhNGE4ZjcwYmI3MjJmZGE2ODc2NDQ4MjI5MmE0YmYzMDViNGM0YTk2NzI0YTgwMDQiLCJpYXQiOjE2MDkzNjIwNjQsIm5iZiI6MTYwOTM2MjA2NCwiZXhwIjoxNjQwODk4MDY0LCJzdWIiOiI5NjkwIiwic2NvcGVzIjpbXX0.FV7_Pl3G8lmLeQOTopPJIcNTD0DnLm95QVl2aMefwmEw0Dyb8yHJIwS4EY8AAxTHrp-OH61Q1b9RaBF8k5K0a6k0LvvEyN1rw_5kGsXaYO3TUqNgX1fzCUtAh0U4xSbevlRCbQfXLINWplVuGYwuLAZ8szWqamQK_3sIYoYKn7T2avILXZGeYnd_91bR7uURE-RZktc8xZW5S4wzOmHxaqeOdgbwzQHIA0hzmfSG6yI8sOSOIAG7RzZDQ-pw6_zBLlkmnjuOnGj66wWrcnOqgOcxOII6gcy04OAPurMowsduCWMEriWrI9eaKcuqBKbLyEb2nNFYYHHwKLhdRC5qrMM2XnD7fg3ZCCDZO0NtGKIZiN9LOD1Eny3yxZTCxcmpGP3yk_pQq1R1Wkp0RmOtpIVGz4k158Hg7QuUMMcIREpdpEaXTIOgAb6A91v1Jadq4_RNNO2oDGuFjeL7JOF6wBzX-IVc58rSHn4ICIa-4OZ85rUNQbLK3g5jwR9hg3EHT8_imvUAKc0ZURnsfmR8AbSTlqRY2PaEIJNkMvb1N8rK8Ut-l-jRTkYzVarLpO_rEzyk7KVGpWgZN0Vu9-TtD3cxj0LW3A4QElpznQ4sXhIjRz0c5GzVQVggTSGoD7CzmNuX_JGCJ-aSAp-tCfmS5IBAxPHboJOCoNmqKiuAPIo