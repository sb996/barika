import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uni_links/uni_links.dart';

import 'Navigate.dart';


class DeepLinksUtil{

  DeepLinksUtil();


  Future<Null> initUniLinks(BuildContext context) async {
    StreamSubscription _sub;
    print("Deeplink init");
    _sub = getLinksStream().listen((String link) {
      print(link);
      List<String> linkpart=link.split('?');
      List<String> linkpart1=linkpart[1].split('&');
      List<String> linkpart2=linkpart1[0].split('=');
      print(linkpart2[1]);

        if (linkpart2[1]!="failed") {
          _sub.cancel();

      }
      else{
          _sub.cancel();
        print("else");
      }


    }, onError: (err) {
      print("link"+err);
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }
  Future<Null> initUniLinkdiet(uid,type,user, metype) async {
    StreamSubscription _sub;
    print("Deeplink init");
    int a=0;
    _sub = getLinksStream().listen((String link) {
      print(link+(a++).toString());
      List<String> linkpart=link.split('?');
      List<String> linkpart1=linkpart[1].split('&');
      List<String> linkpart2=linkpart1[0].split('=');
      List<String> dietidList=linkpart1[3].split('=');
      String dietid=dietidList[1];
      print(linkpart2[1]);

//      if (link.contains('returnApp')) {
      if (linkpart2[1]!="failed") {
        print(uid.toString() + type.toString() + user.toString() +
            metype.toString());
        _sub.cancel();
        Navigate.navigatePop();
        // Navigate.navigateTo("payquestionnaire",ScreenArguments( uid: uid,name: type,id: user,metype: metype,dietId:dietid));
      } else{
        _sub.cancel();
//        Navigate.navigatePop();
        print("else");
      }


    }, onError: (err) {
      print("link"+err);

      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }
  Future<Null> initUniLinkdietChild() async {
    print("Deeplink initUniLinkdietChild");
    StreamSubscription _sub;
    _sub = getLinksStream().listen((String link) {
      print(link);
      List<String> linkpart=link.split('?');
      List<String> linkpart1=linkpart[1].split('&');
      List<String> linkpart2=linkpart1[0].split('=');
      print(linkpart2[1]);

//      if (link.contains('returnApp')) {
      if (linkpart2[1]!="failed") {

        _sub.cancel();

      }
      else{
        _sub.cancel();
//        Navigate.navigatePop();
        print("else");
      }


    }, onError: (err) {
      print("link"+err);
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }




  }


