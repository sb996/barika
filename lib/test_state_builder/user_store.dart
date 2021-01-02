import 'dart:convert';

import 'package:barika_web/models/user.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userStore {
  User _user;
  String _apiToken;

  User get user => _user;

  void getUser(BuildContext context) async {
    await getUserServer(context);
  }

  Future <bool> updateUser(BuildContext context,Map<String, dynamic> newPost) async {
    bool result= await upUserServer(context,newPost);
    return result;
  }

  Future<User> getNotNull(BuildContext context) async {
    if(_user!=null){
      return _user;}
    else{
      await getUserServer(context);
      return _user;

    }

  }
  
  getUserServer(BuildContext context,) async {

    if(_apiToken==null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _apiToken = prefs.getString('user_token');

    }


    try {
      final response = await Provider.of<apiServices>(context, listen: false)
          .getUserInfo('Bearer ' + _apiToken);

      print("response" + response.bodyString.substring(0,20));
      final post = json.decode(response.bodyString);
      if (response.statusCode == 200 ) {

        _user=User.fromJson(post['success']);

      } else {
        return null;
      }
    } catch (e) {
      print(e.toString() + "catttttch");
      return null;
    }
  }

  Future<bool> upUserServer(BuildContext context,Map<String, dynamic> newPost) async {
    print("user update methode");
    bool result=false;
    
    if(_apiToken==null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _apiToken = prefs.getString('user_token');}
    try {
      final response = await Provider.of<apiServices>(context, listen: false)
          .updateUserInfo(newPost, 'Bearer ' + _apiToken);
      print("response" + response.bodyString.substring(0,20));
      final post = json.decode(response.bodyString);
      if (response.statusCode == 200 && response.bodyString.contains("success")) {
        result=true;
        _user=User.fromJson(post['success']);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString() + "catttttch");
      return null;
    }

    return result;

  }

 
}
