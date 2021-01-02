import 'dart:convert';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:intl/intl.dart'as intl;
import 'package:barika_web/models/diets.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dietStore {

  List<DbAllDiets> _DbAllDietsList=[];
  String _apiToken;

  List<DbAllDiets> get DbAllDietsList => _DbAllDietsList;

  Future<List<DbAllDiets>> getDiet(BuildContext context) async {
    print("getDiet In getDietsotr");
    await getDietServer(context);
    return _DbAllDietsList;
  }


  
  getDietServer(BuildContext context,) async {
    List<diets> allDiets=[];
    List<DbAllDiets> _DbAllDietsList2=[];

    if(_apiToken==null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _apiToken = prefs.getString('user_token');

    }

    try{
      final response = await Provider.of<apiServices>(context, listen: false)
          .getUserInfoDiet(
          "1",
          'Bearer ' + _apiToken);



      if (response.statusCode == 200) {
        print(response.bodyString.substring(0,50));
        final post = json.decode(response.bodyString);

        List ListPost = post['diets'];

        if (ListPost != null && !ListPost.isEmpty) {
          ListPost.forEach((item) {
            allDiets.add(diets.fromJson(item));
          });


//        _GrowableList<dynamic>
          for (int index = 0; index < allDiets.length; index++) {

            bool _condi = true;
            if (allDiets[index].detail.runtimeType.toString() == "List<dynamic>") {
              List<dynamic> _ll = allDiets[index].detail;
              if (_ll.isEmpty)
                _condi = false;}
            if (allDiets[index].detail.toString() == "") _condi = false;
            if (allDiets[index].detail.toString() == null) _condi = false;


            if (_condi) {


              if (allDiets[index].regimName.contains("children") && allDiets[index].regimName != "children2-3" && allDiets[index].regimName != "children3-12") {

                var diet = {
                  'id': allDiets[index].id,
                  'user_id':allDiets[index].user_id ,
                  'day': allDiets[index].days ,
                  'detail':allDiets[index].detail["children_details"],
                  'userInfo':allDiets[index].userInfo,
                  'type': allDiets[index].regimName,
                  'created_at': intl.DateFormat('yyyy-MM-dd').format(
                      (DateTime.parse(allDiets[index].created_at))),
                  // 'finished_at': intl.DateFormat('yyyy-MM-dd').format(
                  //     (DateTime.parse(allDiets[index].finished_at))),
                  'name':allDiets[index].userInfo["name"] ,
                  'advertice': "",
                  'ghol': "0",
                  'extended_id': allDiets[index].extended_id,
                };

                _DbAllDietsList2.add( DbAllDiets.fromJson(diet));

              }
              else {

               var diet = {
                  'id': allDiets[index].id,
                  'user_id':allDiets[index].user_id ,
                  'day': allDiets[index].days ,
                  'detail':allDiets[index].detail,
                  'userInfo':allDiets[index].userInfo,
                  'type': allDiets[index].regimName,
                  'created_at': intl.DateFormat('yyyy-MM-dd').format(
                      (DateTime.parse(allDiets[index].created_at))),
                  // 'finished_at': intl.DateFormat('yyyy-MM-dd').format(
                  //     (DateTime.parse(allDiets[index].finished_at))),
                  'name':allDiets[index].userInfo["name"] ,
                  'advertice':allDiets[index].advertises,
                  'ghol': allDiets[index].ghol,
                  'extended_id': allDiets[index].extended_id,

                };


                _DbAllDietsList2.add( DbAllDiets.fromJson(diet));

              }

            }
            else {
              print(response.statusCode.toString() + "ddd");

            }
          }

         _DbAllDietsList= _DbAllDietsList2;
          _DbAllDietsList.forEach((element) {

          });
        }
      }} catch(e){
print(e.toString());

    }
  }
  Future<List<DbAllDiets>> getNotNull(BuildContext context) async {
    if(_DbAllDietsList!=null){
      return _DbAllDietsList;}
    else{
      await getDiet(context);
      return _DbAllDietsList;

    }

  }




}
