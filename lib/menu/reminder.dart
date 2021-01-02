// import 'package:barika/utils/SizeConfig.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../helper.dart';
//
// class reminder extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => reminderState();
// }
//
// class reminderState extends State<reminder> {
//   List<String> title = [
//     "یادآوری اضافه کردن صبحانه",
//     "یادآوری اضافه کردن نهار",
//     "یادآوری اضافه کردن شام",
//     "یادآوری اضافه کردن میان وعده"
//   ];
//   List<String> time = [
//     " 1:30   قبل از ظهر",
//     " 2:30   قبل از ظهر",
//     " 3:30   قبل از ظهر",
//     " 4:30   قبل از ظهر"
//   ];
//   List<bool> values = [false, false, false, false];
//   List<Time> timeAlarm = [new Time(10,30), new Time(14,30), new Time(21,00),new Time(23,00)];
//   bool showLoading = false;
// DateTime _time;
//   void initState() {
//     setSwitchs();
//
//     super.initState();
//   }
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
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//
//     return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               elevation: 8,
//               title: Text(
//                 'یادآور',
//                 style: TextStyle(
//                     fontSize: 14*fontvar,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white),
//               ),
//               actions: <Widget>[
//                 IconButton(
//                   icon: Icon(
//                     Icons.chevron_right,
//                     size: 32 *(screenSize.width)/375,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   alignment: Alignment.topLeft,
//                   color: Colors.white,
//                   splashColor: Colors.amber,
//                   padding: EdgeInsets.all(7),
//                 ),
//               ],
//               centerTitle: true,
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                   color:MyColors.green
//                 ),
//               ),
//             ),
//             body: ListView.builder(
//                 itemCount: title.length ,
//                 itemBuilder: (context, index) {
//                   return
// //                    index == 4
// //                      ? Container(
// //                          margin: EdgeInsets.symmetric(
// //                              horizontal: 40, vertical: 10),
// //                          child: Stack(
// //                            alignment: Alignment.center,
// //                            children: <Widget>[
// //                              SizedBox(
// //                                width: MediaQuery.of(context).size.width,
// //                                child: RaisedButton(
// //                                    shape: RoundedRectangleBorder(
// //                                      borderRadius:
// //                                          new BorderRadius.circular(10),
// //                                    ),
// //                                    padding: EdgeInsets.symmetric(
// //                                        horizontal: 5, vertical: 8),
// //                                    color: MyColors.green,
// //                                    onPressed: () async {
// //                                      await clicksave();
// //                                    },
// //                                    child: Text(
// //                                      showLoading ? '' : 'تایید اطلاعات',
// //                                      style: TextStyle(
// //                                          color: Colors.white,
// //                                          fontWeight: FontWeight.w500,
// //                                          fontSize: 14),
// //                                    )),
// //                              ),
// //                              if (showLoading)
// //                                SpinKitThreeBounce(
// //                                  color: Colors.white,
// //                                  size: 20,
// //                                )
// //                            ],
// //                          ))
//                        Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 10, right: 10, left: 10),
//                                 child: Text(
//                                   title[index],
//                                   style: TextStyle(
//                                       fontSize: 14*fontvar,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                               Card(
//                                   child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 5, vertical: 8),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//
//                                     GestureDetector(
//                                       child:  Row(
//                                         children: <Widget>[
//                                           Icon(
//                                             Icons.access_time,
//                                             color: Color(0xffF15A23),
//                                           ),
//                                           Text(
//                                             timeAlarm[index].hour.toString()+":"+minuteStr(timeAlarm[index].minute),
//                                             style: TextStyle(
//                                                 fontSize: 15*fontvar,
//                                                 fontWeight: FontWeight.w400),
//                                             textDirection: TextDirection.ltr,
//                                           ),
//                                         ],
//                                       ),
//                                       onTap: (){
// //                                        DateTime dateTime=DateTime.now();
// //                                       if(values[index]){    showDialog(
// //                                            context: context,
// //                                            builder: (BuildContext context) {
// //                                              return Padding(
// //                                                  padding: EdgeInsets.all(0),
// //                                                  child: Dialog(
// //                                                      elevation: 15,
// //                                                      shape:
// //                                                      RoundedRectangleBorder(
// //                                                        borderRadius:
// //                                                        BorderRadius
// //                                                            .circular(10),
// //                                                      ),
// //                                                      backgroundColor:
// //                                                      Colors.transparent,
// //                                                      child: Container(
// //                                                          padding: EdgeInsets.symmetric(vertical: 25),
// //                                                          alignment: Alignment.center,
// //                                                          height: MediaQuery.of(context).size.height/1.5,
// //                                                          decoration: BoxDecoration(
// //                                                              color: Colors.white,
// //                                                              borderRadius:
// //                                                              BorderRadius
// //                                                                  .all(Radius
// //                                                                  .circular(
// //                                                                  10))),
// //                                                          child:
// //                                                          Column(
// //                                                            mainAxisAlignment: MainAxisAlignment.center,
// //                                                            children: <Widget>[
// //                                                              Text("انتخاب ساعت",style: TextStyle(
// //                                                                  fontSize: 16*fontvar,fontWeight: FontWeight.w500
// //                                                              ),),
// //                                                              Expanded(child: new TimePickerSpinner(
// //                                                                  is24HourMode: true,
// //                                                                  time: index==0
// //                                                                      ?DateTime(dateTime.year,dateTime.month,dateTime.day,10,30)
// //                                                                      :index==1
// //                                                                      ?DateTime(dateTime.year,dateTime.month,dateTime.day,14,30)
// //                                                                      :index==2
// //                                                                      ?DateTime(dateTime.year,dateTime.month,dateTime.day,21,00)
// //                                                                      :DateTime(dateTime.year,dateTime.month,dateTime.day,23,00),
// //
// //                                                                  normalTextStyle: TextStyle(
// //                                                                      fontSize:
// //                                                                      20*fontvar,
// //                                                                      color: Colors
// //                                                                          .black38),
// //                                                                  highlightedTextStyle: TextStyle(
// //                                                                      fontSize:
// //                                                                      20*fontvar,
// //                                                                      color: Colors
// //                                                                          .black),
// //                                                                  spacing: 40*(screenSize.width)/375,
// //                                                                  itemHeight: 70*(screenSize.width)/375,
// //                                                                  isShowSeconds: false,
// //                                                                  isForce2Digits:false,
// //                                                                  onTimeChange:
// //                                                                      (time) {
// //                                                                    setState(() {
// //                                                                      timeAlarm[index]=( new Time(time.hour,time.minute));
// //                                                                    });
// //
// //                                                                  }),
// //                                                              ),
// //                                                              FlatButton(onPressed: (){
// //                                                                Navigator.pop(context);
// //                                                                clicksave();
// //                                                              },
// //                                                                  color: Colors.green,
// //
// //                                                                  child: Text("تایید",style: TextStyle(
// //                                                                      color: Colors.white
// //                                                                  ),))
// //
// //                                                            ],
// //                                                          )
// //                                                      )));
// //                                            });
// //                                        }
// //
//
//
//                                       },
//                                     ),
//                                     Switch(
//                                       value: values[index],
//                                       onChanged: (bool value) {
//                                         print(_time);
//                                         DateTime dateTime=DateTime.now();
//                                        if(value) showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return Padding(
//                                                   padding: EdgeInsets.all(0),
//                                                   child: Dialog(
//                                                       elevation: 15,
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                       ),
//                                                       backgroundColor:
//                                                           Colors.transparent,
//                                                       child: Container(
//                                                         padding: EdgeInsets.symmetric(vertical: 25),
//                                                         alignment: Alignment.center,
//                                                         height: screenSize.height/1.5,
//                                                         decoration: BoxDecoration(
//                                                             color: Colors.white,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             10))),
//                                                         child:
//                                                           Column(
//                                                             mainAxisAlignment: MainAxisAlignment.center,
//                                                             children: <Widget>[
//                                                               Text("انتخاب ساعت",style: TextStyle(
//                                                                 fontSize: 16*fontvar,fontWeight: FontWeight.w500
//                                                               ),),
//
//                                                               Padding(padding: EdgeInsets.only(top:25 ),child: Row(
//                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                 children: <Widget>[
//                                                                   Padding(padding: EdgeInsets.only(right:5),
//                                                                     child: Text("ساعت"),),
//                                                                   Padding(padding: EdgeInsets.only(left: 15),
//                                                                     child:  Text("دقیقه"),),
//
//
//                                                                 ],
//                                                               ),),
//                                                               Expanded(child:
//
//                                                               new TimePickerSpinner(
//                                                                   is24HourMode:
//                                                                   true,time: index==0
//                                                                   ?DateTime(dateTime.year,dateTime.month,dateTime.day,10,30)
//                                                                   :index==1
//                                                                   ?DateTime(dateTime.year,dateTime.month,dateTime.day,14,30)
//                                                                   :index==2
//                                                                   ?DateTime(dateTime.year,dateTime.month,dateTime.day,21,00)
//                                                                   :DateTime(dateTime.year,dateTime.month,dateTime.day,23,00),
//
//
//                                                                   itemWidth: 30*(screenSize.width)/375,
//                                                                   normalTextStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                       18*fontvar,
//                                                                       color: Colors
//                                                                           .black38),
//                                                                   highlightedTextStyle:
//                                                                   TextStyle(
//                                                                       fontSize:
//                                                                       18*fontvar,
//                                                                       color: Colors
//                                                                           .black),
//                                                                   spacing: 30,
//                                                                   itemHeight: 70,
//                                                                   isShowSeconds: false,
//
//                                                                   isForce2Digits:true,
//                                                                   onTimeChange:
//                                                                       (time) {
//                                                                     setState(() {
//                                                                       timeAlarm[index]=( new Time(time.hour,time.minute));
//                                                                     });
//
//                                                                   }),
//                                                               ),
//                                                               FlatButton(onPressed: (){
//                                                                 Navigator.pop(context);
//                                                                 clicksave();
//                                                               },
//                                                                   color: Colors.green,
//
//                                                                   child: Text("تایید",style: TextStyle(
//                                                                     color: Colors.white
//                                                                   ),))
//
//                                                             ],
//                                                           )
//                                                       )));
//                                             });
//                                          else clicksave();
//
//
//                                         setState(() {
//                                           values[index] = value;
//                                         });
//
//
//                                       },
//                                       activeColor: Color(0xffF15A23),
//                                       inactiveThumbColor: Color(0xffE5E5E5),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                             ],
//                           ));
//                 })));
//   }
//
// //  void setSwitchs() {}
//
//   setSwitchs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String stringTimes = await prefs.getString('alarm');
//     String stringTimesalarm = await prefs.getString('alarmtime');
//     print(stringTimes);
//     print(stringTimesalarm);
//     if (stringTimes != null) {
//       List time = stringTimes.split(",");
//       print(time.length);
//       time.forEach((s) {
//         switch (s) {
//           case "calorie":
//             setState(() {
//               values[0]= true;
//             });
//
//             break;
//           case "water":
//             setState(() {
//               values[1]= true;
//             });
//             break;
//           case "weight":
//             setState(() {
//               values[2]= true;
//             });
//             break;
//           case "food":
//             setState(() {
//               values[3]= true;
//             });
//             break;
//         }
//       });
//     }
//     if (stringTimesalarm != null && stringTimesalarm != "") {
//       List time = stringTimesalarm.split("#");
//       print(time.length.toString()+"##lenght##");
//       for(int i=0;i<time.length;i++){
//         List<String> timesSplit2=time[i].split(",");
//         print(timesSplit2[0]+"######");
//         setState(() {
//           timeAlarm[i]=(new Time(int.parse(timesSplit2[0]),int.parse(timesSplit2[1])));
//         });
//
//       }
//
//     }
//   }
//
//   Future<void> clicksave() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//   print(await prefs.remove('alarmtime'));
//     setState(() {
//       showLoading = true;
//     });
//     List<String> times = [];
//     List<Time> alarmtimes = [];
//     alarmtimes=timeAlarm;
//     print(timeAlarm.length.toString()+"tl1");
//
//     if (values[0]){ times.add("calorie");}
//     if (values[1]) {times.add("water");}
//     if (values[2]) {times.add("weight");}
//     if (values[3]) {times.add("food");}
//
//
//     print(times);
//     print(timeAlarm);
//     await setAlarm(times: times,timealarm: timeAlarm,timesTamdid: null,timealarmTamdid: null,reminder:"yes");
//
//     setState(() {
//       showLoading = false;
//     });
//   }
//   String minuteStr(int min) {
//     return (min < 10) ? ("0" + min.toString()) : min.toString();
//   }
// }
