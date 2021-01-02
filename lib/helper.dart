import 'dart:math';
import 'dart:ui';


import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';


Future<bool> checkConnectionInternet() async {
  var connectivityResult = await (new Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiToken = prefs.getString('user_token');}


String getDateToday(){

  var now = DateFormat('yyyy-MM-dd').format((DateTime.now()));
//  String date='${now.year.toString()}/${now.month.toString()}/${now.day.toString()}';
  return now.toString();
}

String getDateTodayTest(){

  var now = new DateTime.now();
  final custom = new DateTime(now.year, now.month, now.day + 15,);
  DateFormat('yyyy-MM-dd').format(custom);
//  String date='${custom.year.toString()}-${custom.month.toString()}-${custom.day.toString()}';
  return custom.toString();
}


String getDateTodayServer(){

  var now = DateFormat('yyyy-MM-dd hh:mm:ss').format((DateTime.now()));
//  String date='${now.year.toString()}/${now.month.toString()}/${now.day.toString()}';
  return now.toString();
}

String getDateToday2(){
  var now = new DateTime.now();
  String date='${now.year.toString()}/${now.month.toString()}/${now.day.toString()}';
  return date;
}

String getCustomDate(int add){
  var now = new DateTime.now();
  final custom = new DateTime(now.year, now.month, now.day + add,);
  DateFormat('yyyy-MM-dd').format(custom);
//  String date='${custom.year.toString()}-${custom.month.toString()}-${custom.day.toString()}';
  return custom.toString();
}

String getCustomDate2(int add,DateTime now){
  final custom = DateFormat('yyyy-MM-dd').format(new DateTime(now.year, now.month, now.day + add,));
//  String date='${custom.year.toString()}-${custom.month.toString()}-${custom.day.toString()}';
  return custom.toString();
}


String dietIconSelector(String type) {




  if(type.contains("weight_loss"))
    return "assets/icons/Rkahesh.png";

  else if(type.contains("weight_fix"))
    return "assets/icons/kg.png";

  else if(type.contains("weight_gain"))
    return "assets/icons/Rafzayesh.png";


  else if(type.contains("vegetarian"))
    return "assets/icons/Rgiahkhar.png";

  else if(type.contains("athletes"))
    return "assets/icons/Rvarzeshkar.png";


  else if(type.contains("lactation"))
    return "assets/icons/Rshir.png";


  else if(type.contains("pregnancy"))
    return "assets/icons/Rbardar.png";


  else if(type.contains("children"))
    return "assets/icons/Rkoodak.png";

  else return "";


}

String dietNameSelector(String type) {
  if(type.contains("weight_loss"))
    return "کاهش وزن";

  else if(type.contains("weight_fix"))
    return "حفظ وزن";

  else if(type.contains("weight_gain"))
    return "افزایش وزن";


  else if(type.contains("vegetarian"))
    return "گیاهخواری";

  else if(type.contains("athletes"))
    return "ورزشکاری";


  else if(type.contains("lactation"))
    return "شیردهی";


  else if(type.contains("pregnancy"))
    return "بارداری";


  else if(type.contains("children"))
    return "کودکان و نوزادان";

  else return "";


}

Color dietColorSelector(String type) {


  if(type.contains("weight_loss"))
    return Color(0xffFABE06);

  else if(type.contains("weight_fix"))
    return  Color(0xffE73334);

  else if(type.contains("weight_gain"))
    return   Color(0xffEA8B1D);

  else if(type.contains("vegetarian"))
    return Color(0xff6BBE4A);

  else if(type.contains("athletes"))
    return    Color(0xffA418B9);

  else if(type.contains("lactation"))
    return   Color(0xff158BCB);

  else if(type.contains("pregnancy"))
    return Color(0xff0ABAB8);

  else if(type.contains("children"))
    return    Color(0xff7054BA);

  else     return Color(0xff0ABAB8);


}



String dietName(String type) {

  if(type.contains("weight_loss"))
    return "weightLoss";

  else if(type.contains("weight_fix"))
    return "weightFix";

  else if(type.contains("weight_gain"))
    return "weightGain";


  else if(type.contains("vegetarian"))
    return "vegetarian";

  else if(type.contains("athletes"))
    return "athletes";


  else if(type.contains("lactation"))
    return "lactation";


  else if(type.contains("pregnancy"))
    return "pregnancy";


  else if(type.contains("children"))
    return "children";

  else return "";

}




calculateAge(String bdate) {
  DateTime birthDate=DateTime.parse(bdate);
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;

  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }

  if(age>=1)
    return age;
  else return 0;




}
calculateMounth(String bdate) {
  DateTime birthDate=DateTime.parse(bdate);
  DateTime currentDate = DateTime.now();
  int cmonth;

  if(birthDate.year==currentDate.year){
    cmonth=currentDate.month-birthDate.month;
    if(birthDate.day>currentDate.day)
      cmonth--;

  }
  else if(birthDate.year<currentDate.year){
    if(birthDate.month>=currentDate.month)
      cmonth=(currentDate.month-1)+(12-birthDate.month);

    if(birthDate.day<=currentDate.day)
      cmonth++;

  }

  return cmonth;
}

calculateAllMounth(String bdate) {
  DateTime birthDate=DateTime.parse(bdate);
  DateTime currentDate = DateTime.now();
  List<int> months=[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  int cmonth;
  int currentDay=currentDate.day;
  int currentMonth=currentDate.month;
  int currentYear=currentDate.year;
  int bDay=birthDate.day;
  int bMonth=birthDate.month;
  int bYear=birthDate.year;

  if (bDay> currentDay) {
    currentDay = currentDay + months[bMonth - 1];
    currentMonth= currentMonth- 1;
  }

  // if birth month exceeds current month, then do
  // not count this year and add 12 to the month so
  // that we can subtract and find out the difference
  if (bMonth >currentMonth) {
    currentYear = currentYear - 1;
    currentMonth = currentMonth + 12;
  }

  // calculate date, month, year
  int calculated_date = currentDay - bDay;
  int calculated_month = currentMonth - bMonth;
  int calculated_year = currentYear - bYear;


  return double.parse((calculated_year*12+calculated_month.toDouble()+calculated_date/30).toStringAsFixed(1));
}


Map<String,double> getRiz(int type){

  print(type);
  switch (type) {
    case 0:{
      return {
        'water': 0.7,
        'protein':9.1,
        'fiber':0,
        'sodium':0.12,
        'potassium':0.4,
        'phosphorus':100,
        'iron':0.27,
        'calcium':200,
        'magnesium':30,
        'zinc':2,
        'copper':200,
        'selenium':15,
        'vitamin_c':40,
        'biotin':5,
        'folic_acid':65,
        'pantothenic_acid':1.7,
        'b1':0.2,
        'b2':0.3,
        'b3':2,
        'b6':0.1,
        'b12':0.4,
        'vitamin_a':400,
        'vitamin_d':400,
        'vitamin_e':4,
        'vitamin_k':2,


      };
    }
    break;
    case 1:
      return {
        'water': 0.8,
        'protein':11,
        'fiber':0,
        'sodium':0.37,
        'potassium':0.7,
        'phosphorus':275,
        'iron':11,
        'calcium':260,
        'magnesium':75,
        'zinc':3,
        'copper':220,
        'selenium':20,
        'vitamin_c':50,
        'biotin':6,
        'folic_acid':80,
        'pantothenic_acid':1.8,
        'b1':0.3,
        'b2':0.4,
        'b3':4,
        'b6':0.3,
        'b12':0.5,
        'vitamin_a':500,
        'vitamin_d':400,
        'vitamin_e':5,
        'vitamin_k':2.5,


      };
      break;
    case 2:
      return {
        'water': 1.3,
        'protein':13,
        'fiber':19,
        'sodium':1,
        'potassium':3,
        'phosphorus':460,
        'iron':7,
        'calcium':700,
        'magnesium':80,
        'zinc':3,
        'copper':340,
        'selenium':20,
        'vitamin_c':15,
        'biotin':8,
        'folic_acid':150,
        'pantothenic_acid':2,
        'b1':0.5,
        'b2':0.5,
        'b3':6,
        'b6':0.5,
        'b12':0.9,
        'vitamin_a':300,
        'vitamin_d':600,
        'vitamin_e':6,
        'vitamin_k':30,


      };
      break;
    case 3:
      return {
        'water': 1.7,
        'protein':19,
        'fiber':25,
        'sodium':1.2,
        'potassium':3.8,
        'phosphorus':500,
        'iron':10,
        'calcium':1000,
        'magnesium':130,
        'zinc':5,
        'copper':440,
        'selenium':30,
        'vitamin_c':25,
        'biotin':12,
        'folic_acid':200,
        'pantothenic_acid':3,
        'b1':0.6,
        'b2':0.6,
        'b3':8,
        'b6':0.6,
        'b12':1.2,
        'vitamin_a':400,
        'vitamin_d':600,
        'vitamin_e':7,
        'vitamin_k':55,


      };
      break;
    case 4:
      return {
        'water': 1.7,
        'protein':34,
        'fiber':31,
        'sodium':1.5,
        'potassium':4.5,
        'phosphorus':1250,
        'iron':8,
        'calcium':1300,
        'magnesium':240,
        'zinc':8,
        'copper':700,
        'selenium':40,
        'vitamin_c':45,
        'biotin':20,
        'folic_acid':300,
        'pantothenic_acid':4,
        'b1':0.9,
        'b2':0.9,
        'b3':12,
        'b6':1,
        'b12':1.5,
        'vitamin_a':600,
        'vitamin_d':600,
        'vitamin_e':11,
        'vitamin_k':60,


      };
      break;
    case 5:
      return {
        'water': 3.3,
        'protein':52,
        'fiber':38,
        'sodium':1.5,
        'potassium':4.7,
        'phosphorus':1250,
        'iron':11,
        'calcium':1300,
        'magnesium':410,
        'zinc':11,
        'copper':890,
        'selenium':55,
        'vitamin_c':75,
        'biotin':25,
        'folic_acid':400,
        'pantothenic_acid':5,
        'b1':1.2,
        'b2':1.3,
        'b3':16,
        'b6':1.3,
        'b12':2.4,
        'vitamin_a':900,
        'vitamin_d':600,
        'vitamin_e':15,
        'vitamin_k':75,


      };
      break;
    case 6:
    case 7:
    case 8:
    case 9:
      return {
        'water': 3.7,
        'protein':56,
        'fiber':type==6||type==7?38:30,
        'sodium':type==6||type==7?1.5:type==8?1.3:1.2,
        'potassium':4.7,
        'phosphorus':700,
        'iron':8,
        'calcium':type==9?1200:1000,
        'magnesium':type==6?400:420,
        'zinc':11,
        'copper':900,
        'selenium':55,
        'vitamin_c':90,
        'biotin':30,
        'folic_acid':400,
        'pantothenic_acid':5,
        'b1':1.2,
        'b2':1.3,
        'b3':16,
        'b6':type==6||type==7?1.3:1.7,
        'b12':2.4,
        'vitamin_a':900,
        'vitamin_d':type==9?800:600,
        'vitamin_e':15,
        'vitamin_k':120,


      };
      break;
    case 10:
      return {
        'water': 2.1,
        'protein':34,
        'fiber':31,
        'sodium':1.5,
        'potassium':4.5,
        'phosphorus':1250,
        'iron':8,
        'calcium':1300,
        'magnesium':240,
        'zinc':8,
        'copper':700,
        'selenium':40,
        'vitamin_c':45,
        'biotin':20,
        'folic_acid':300,
        'pantothenic_acid':4,
        'b1':0.9,
        'b2':0.9,
        'b3':12,
        'b6':1,
        'b12':1.8,
        'vitamin_a':600,
        'vitamin_d':600,
        'vitamin_e':11,
        'vitamin_k':60,


      };
      break;
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
      return {
        'water': type==11?2.3:2.7,
        'protein':46,
        'fiber':type==11?38:type==12||type==13?25:21,
        'sodium':type==15?1.2:type==14?1.3:1.5,
        'potassium':4.7,
        'phosphorus':type==11?1250:700,
        'iron':type==11?15:type==12||type==13?18:8,
        'calcium':type==11?1300:type==12||type==13?1000:1200,
        'magnesium':type==11?360:type==12?310:320,
        'zinc':type==11?9:8,
        'copper':type==11?890:900,
        'selenium':55,
        'vitamin_c':type==11?65:75,
        'biotin':type==11?25:30,
        'folic_acid':400,
        'pantothenic_acid':5,
        'b1':type==11?1:1.1,
        'b2':type==11?1:1.1,
        'b3':14,
        'b6':type==11?1.2:type==12||type==13?1.3:1.5,
        'b12':2.4,
        'vitamin_a':700,
        'vitamin_d':600,
        'vitamin_e':15,
        'vitamin_k':type==11?75:90,


      };
      break;
    case 16:
    case 17:
    case 18:
      return {
        'water': 3,
        'protein':71,
        'fiber':28,
        'sodium':1.5,
        'potassium':4.7,
        'phosphorus':type==16 ?1250:700,
        'iron':27,
        'calcium':type==16 ?1300:1000,
        'magnesium':type==16 ?400:type==17?350:360,
        'zinc':type==16 ?12:11,
        'copper':1000,
        'selenium':60,
        'vitamin_c':type==16?80:85,
        'biotin':30,
        'folic_acid':600,
        'pantothenic_acid':6,
        'b1':1.4,
        'b2':1.4,
        'b3':18,
        'b6':1.9,
        'b12':2.6,
        'vitamin_a':type==16?750:770,
        'vitamin_d':600,
        'vitamin_e':15,
        'vitamin_k':type==16?75:90,


      };
      break;
    case 19:
    case 20:
    case 20:
      return {
        'water': 3,
        'protein':71,
        'fiber':29,
        'sodium':1.5,
        'potassium':5.1,
        'phosphorus':type==19 ?1250:700,
        'iron':type==19 ?10:9,
        'calcium':type==19 ?1300:1000,
        'magnesium':type==19 ?360:type==20?310:320,
        'zinc':type==19 ?13:12,
        'copper':1300,
        'selenium':70,
        'vitamin_c':type==19?115:120,
        'biotin':35,
        'folic_acid':500,
        'pantothenic_acid':7,
        'b1':1.4,
        'b2':1.6,
        'b3':17,
        'b6':2,
        'b12':2.8,
        'vitamin_a':type==19?1200:1300,
        'vitamin_d':600,
        'vitamin_e':19,
        'vitamin_k':type==19?75:90,


      };
      break;

  }






}

String riz(int age,String gender,String bdate) {

  double month =0;

  if (age==0) {

    month = calculateAllMounth(bdate);

    print(month.toString()+"month");
    if (month >= 0 && month < 6)
      return "0";
    else if (month >= 6 && month <= 12)
      return "1";
  }else if(age>=1&&age<=3)
    return "2";
  else if(age>=4&&age<=8)
    return "3";
  else if(age>=9&&age<=13&&gender=="male")
    return "4";
  else if(age>=14&&age<=18&&gender=="male")
    return "5";
  else if(age>=19&&age<=30&&gender=="male")
    return "6";
  else if(age>=31&&age<=50&&gender=="male")
    return "7";
  else if(age>=51&&age<=70&&gender=="male")
    return "8";
  else if(age>=71&&gender=="male")
    return "9";
  else if(age>=9&&age<=13&&gender=="female")
    return "10";
  else if(age>=14&&age<=18&&gender=="female")
    return "11";
  else if(age>=19&&age<=30&&gender=="female")
    return "12";
  else if(age>=31&&age<=50&&gender=="female")
    return "13";
  else if(age>=51&&age<=70&&gender=="female")
    return "14";
  else if(age>=71&&gender=="female")
    return "15";



}

///////////////////////////////////////////////////////



 String changeDigit(String number, ) {
var persianNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
var arabicNumbers = ['٠','١', '٢','٣','٤','٥','٦','٧','٨','٩' ];
var enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];


for (var i = 0; i < 10; i++) {
number = number
    .replaceAll(new RegExp(persianNumbers[i]), enNumbers[i])
    .replaceAll(new RegExp(arabicNumbers[i]), enNumbers[i]);
}

return number;
}