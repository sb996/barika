// import 'dart:convert';
// import 'dart:core';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:barika/models/user.dart';
// import 'package:barika/services/apiServices.dart';
// import 'package:barika/sqliteProvider/userProvider.dart';
// import 'package:persian_datepicker/persian_datetime.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'SizeConfig.dart';
// class BackPayment extends StatefulWidget {
//   final String arg;
//   BackPayment({this.arg});
//   bool operator=false;
//   User user;
//
//   Future getUser(BuildContext context) async {
//     print("its my args" + arg.toString());
//     user = await getUsersq();
//     print('USErrR');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{
//       final response = await Provider.of<apiServices>(context, listen: false)
//           .getUserInfo(
//           'Bearer '+apiToken);
//       if (response.statusCode == 200) {
// //      print('${response.bodyString}SSSSSSSSSSSSSSSSSSSSSSSS');
//         final post = json.decode(response.bodyString);
//         print(post);
//         List<User> users=[];
//         users.add(User.fromJson(post['success']));
//         print(users[0].toMap().toString()+"fromjson");
//         user.account=users[0].account;
//        await updateDb(user);
//
//         String result;
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         print(users[0].account);
//         print("acount");
//         if( users[0].account!="" && users[0].account!=null) {
//           var persianDateee = PersianDateTime(
//               jalaaliDateTime: users[0].account);
//           var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
//           DateTime dateEtebar = DateTime.parse(dateEtebarstr);
//           String today =await prefs.getString('serverDate');
//           DateTime dateToday = DateTime.parse(today);
//           print(dateEtebar
//               .difference(dateToday)
//               .inDays
//               .toString());
//           await prefs.setInt('etebar', dateEtebar
//               .difference(dateToday)
//               .inDays);
//         }
//         return true;
//
//       } else {
//         return false;
//       }
//     }catch(e){
//       print(e.toString());
//       return false;
//
//     }
//   }
//   static Future<User> getUsersq() async {
//     User user;
//     try {
//       var db = new userProvider();
//       await db.open();
//       user = await db.paginate();
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//   static Future<User> updateDb(User user) async {
//     try {
//       var db = new userProvider();
//       await db.open();
//       print(await db.update(user));
// //      await db.close();
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//   @override
//   State<StatefulWidget> createState()  => _BackPayment();
// }
//
// class _BackPayment extends State<BackPayment> {
//   _refresh(){
//     setState(() {
//     });
//   }
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
//     fontvar=(bh)/3.75;
//
//     return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
// //            title: Image.asset(
// ////              "assets/images/logo.png",
// //              width: 112.5,
// //              height: 45,
// //            ),
//             centerTitle: true,
//             backgroundColor: Colors.green,
//           ),
//           body: FutureBuilder(
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return Center(child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     (snapshot.data == true)
//                         ? Text(".اکانت شما با موفقیت فعال شد",style: TextStyle(
//                       fontSize: 14*fontvar,
//                       fontWeight: FontWeight.w500
//                     ),)
//                         : Text("عملیات نا موفق بود.",style: TextStyle(
//                     fontSize: 14*fontvar,
//                     fontWeight: FontWeight.w500)),
//
//                     (snapshot.data==true)
//                         ? Icon(
//                       Icons.check_circle_outline,
//                       size: 132,
//                       color: Color(0xff6DC07B),
//                     )
//                         :    Icon(
//                       Icons.error_outline,
//                       size: 132,
//                       color: Colors.red,
//                     ),
//                     Container(
//                       child: FlatButton(
//                         child: Text(
//                           (snapshot.data==true) ? "بازگشت به صفحه اصلی" : "تلاش مجدد",
//                           style: TextStyle(
//                               color: Colors.white),
//                         ), onPressed:
//                       (snapshot.data==true)
//                           ?()=>Navigator.pop(context)
//                           : () => _refresh()
//                         ,),
//                       height: 40,
//                       width: 336,
//                       decoration: BoxDecoration(
//                           color:
//                           (snapshot.data==true)
//                               ?Colors.green
//                               :Colors.red,
//                           borderRadius: BorderRadius.circular(
//                               10)),
//                     )
//                   ],
//                 ),);
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//             future: widget.getUser(context),
//           ),
//         ));
//   }
// }
