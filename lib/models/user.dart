import 'package:equatable/equatable.dart';

class User extends Equatable {
  int id;
  String uid;
  String name;
  String gender;
  String email;
  String phone;
  String birthdate;
  String height;
  String weight;
  String appetite;
  String activity;
  String account;
  String prev_weight;
  String week;
  int calorie;
  int ideal_weight;
  String period_weight;
  int recommended_weight;
  int gcalorie;
  String gdate;
  String gweight;
  String referral_code;
  String country;
  String dietType;
//  String avatar;
//  String dateChnge;

  User.fromJson(Map<String , dynamic> parsedJson) {

    id = parsedJson['iddd'];
    uid = parsedJson['id'];
    name = parsedJson['name']??"";
    gender = parsedJson['gender']??"0";
    email = parsedJson['email']??"";
    phone = parsedJson['phone']??"0";
    birthdate = parsedJson['birthdate']??"0";
    height = parsedJson['height']??"10";
    weight = parsedJson['weight']??"10";
    appetite = parsedJson['appetite']??"0";
    activity = parsedJson['activity'??"0"];
    account = parsedJson['account_expired_at']??"";
    calorie = int.parse(parsedJson['calorie']??"0");
    ideal_weight =  int.parse(parsedJson['ideal_weight']??"0");
    period_weight = parsedJson['period_weight']??"";
    recommended_weight =  int.parse(parsedJson['recommended_weight']??"0");
    prev_weight=parsedJson['prev_weight']??"0";
    week=parsedJson['week']??"";
    gcalorie = parsedJson['gcalorie'];
    gdate=parsedJson['gdate'];
    gweight=parsedJson['gweight'];
    referral_code=parsedJson['referral_code'];
    country=parsedJson["country"];
//    avatar = parsedJson['avatar'];
  }
  User.fromJson2(Map<String , dynamic> parsedJson) {

    id = parsedJson['id'];
    uid = parsedJson['uid'];
    name = parsedJson['name']??"";
    gender = parsedJson['gender']??"0";
    email = parsedJson['email']??"";
    phone = parsedJson['phone']??"0";
    birthdate = parsedJson['birthdate']??"2020-01-01";
    height = parsedJson['height']??"10";
    weight = parsedJson['weight']??"10";
    appetite = parsedJson['appetite']??"0";
    activity = parsedJson['activity'??"0"];
    account = parsedJson['account']??"";
    calorie =  int.parse(parsedJson['calorie']??"0");
    ideal_weight = int.parse(parsedJson['ideal_weight']??"0");
    period_weight = parsedJson['period_weight'];
    recommended_weight =  int.parse(parsedJson['recommended_weight']??"0");
    prev_weight=parsedJson['prev_weight'];
    week=parsedJson['week'];
    gcalorie=  parsedJson['gcalorie'];
    gdate=parsedJson['gdate'];
    gweight=parsedJson['gweight'];
    referral_code=parsedJson['referral_code'];
    country=parsedJson["country"];
//    avatar = parsedJson['avatar'];
  }
  User.fromJson3(Map<String , dynamic> parsedJson) {
    uid = parsedJson['uid'];
    name = parsedJson['name']??"";
    gender = parsedJson['gender']??"0";
    email = parsedJson['email']??"";
    phone = parsedJson['phone']??"0";
    birthdate = parsedJson['birthdate']??"0";
    height = parsedJson['height']??"10";
    weight = parsedJson['weight']??"10";
    appetite = parsedJson['appetite']??"0";
    activity = parsedJson['activity'??"0"];
    account = parsedJson['account_expired_at']??"";
    calorie =  int.parse(parsedJson['calorie']??"0");
    ideal_weight = int.parse(parsedJson['ideal_weight']??"0");
    period_weight = parsedJson['period_weight'];
    recommended_weight = int.parse(parsedJson['recommended_weight']??"0");
    prev_weight=parsedJson['prev_weight'];
    week=parsedJson['week'];
    gcalorie=  parsedJson['gcalorie'];
    gdate=parsedJson['gdate'];
    gweight=parsedJson['gweight'];
    referral_code=parsedJson['referral_code'];
    country=parsedJson["country"];
//    avatar = parsedJson['avatar'];
  }
  User.fromJson4(Map<String , dynamic> parsedJson) {
    uid = parsedJson['uid'];
    name = parsedJson['name']??"";
    birthdate = parsedJson['birthdate']??"0";
    height = parsedJson['height']??"";
    weight = parsedJson['weight']??"0";
    appetite = parsedJson['appetite']??"0";
    activity = parsedJson['activity']??"";
    dietType = parsedJson['dietType']??"";
    gender = parsedJson['sex']??"male";
  }
  User.fromJsonDiet(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    gender = parsedJson['sex']??"male";
    birthdate = parsedJson['birthdate']??"0";
    height = parsedJson['height']??"";
    weight = parsedJson['weight']??"0";
    appetite = parsedJson['appetite']??"0";
    activity = parsedJson['activity']??"";
    prev_weight = parsedJson['prev_weight']??"";
    week = parsedJson['week']??"";


  }
  User.fromJsonNewDiet(Map<String , dynamic> parsedJson) {

    name = parsedJson['name']??"";
    gender = parsedJson['gender']??"male";
    birthdate = parsedJson['birthdate']??"0";
    height = parsedJson['height']??"";
    weight = parsedJson['weight']??"0";
    appetite = parsedJson['appetite']??"0";
    activity = parsedJson['activity']??"";
    // prev_weight = parsedJson['prev_weight']??"";
    // week = parsedJson['week']??"";


  }


  Map<String, dynamic> toMap() {

    return <String , dynamic>{






      'id':id,
      'uid' : uid,
      'name' : name??"",
      'gender'  : gender??"0",
      'email' : email??"",
      'phone' : phone??"0",
      'birthdate' : birthdate??"2020-01-01",
      'height' : height??"10",
      'weight' : weight??"10",
      'appetite' : appetite??"0",
      'activity' : activity??"0",
      'account' : account??"",
      'calorie' : calorie,
      'ideal_weight' : ideal_weight,
      'period_weight' : period_weight,
      'recommended_weight' : recommended_weight,
      "prev_weight":prev_weight,
      "week":week,
      "gcalorie":gcalorie,
      "gdate":gdate,
      "gweight":gweight,
      "referral_code":referral_code,
      "country":country,

//      'avatar' : avatar,
//      'dateChnge' : dateChnge,
    };

  }

  Map<String, dynamic> toMap2() {

    return <String , dynamic>{



      'uid' : uid,
      'name' : name??"",
      'gender'  : gender??"0",
      'email' : email??"",
      'phone' : phone??"0",
      'birthdate' : birthdate??"2020-01-01",
      'height' : height??"10",
      'weight' : weight??"10",
      'appetite' : appetite??"0",
      'activity' : activity??"0",
      'account' : account??"",
      'calorie' : calorie,
      'ideal_weight' : ideal_weight,
      'period_weight' : period_weight,
      'recommended_weight' : recommended_weight,
      "prev_weight":prev_weight,
      "week":week,
      "gcalorie":gcalorie,
      "gdate":gdate,
      "gweight":gweight,
      "referral_code":referral_code,
      "country":country,
//      'avatar' : avatar,
//      'dateChnge' : dateChnge,
    };

  }
  Map<String, dynamic> toMap5() {

    return <String , dynamic>{

      'name' : name??"",
      'gender'  : gender??"male",
      'birthdate' : birthdate??"2020-01-01",
      'height' : height??"10",
      'weight' : weight??"10",
      'appetite' : appetite??"0",
      'activity' : activity??"0",
      "gcalorie":gcalorie,
      "calorie":calorie,
      "gdate":gdate,
      "gweight":gweight,
    };

  }
  Map<String, dynamic> toMap3() {

    return <String , dynamic>{

      'uid' : uid,
      'account' : account??"",
      'birthdate' : birthdate??"2020-01-01",
      "referral_code":referral_code,
      "country":country,
    };

  }
  Map<String, dynamic> toMap4() {

    return <String , dynamic>{

      'uid' : uid,
      'name' : name??"",
      'birthdate' : birthdate??"2020-01-01",
      "height":height,
      "weight":weight,
      "appetite":appetite,
      "activity":activity,
      "dietType":dietType,
      "gender":gender,
    };

  }
  Map<String, dynamic> toMap6() {

    return <String , dynamic>{

      'gcalorie': gcalorie,
      'gdate': gdate,
      'gweight': gweight,
      'calorie':calorie,
    };

  }


  @override
  List get props => [
    id,
    uid,
    name,
    gender,
    email,
    phone,
    birthdate,
    height,
    weight,
    appetite,
    activity,
    calorie,
    ideal_weight,
    period_weight,
    recommended_weight,
    account,
    prev_weight,
    week,
    gcalorie,
    gdate,
    gweight,
    referral_code,
    country,
    dietType,
  ];

}