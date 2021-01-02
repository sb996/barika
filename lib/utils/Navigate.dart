import 'package:barika_web/models/ScreenArguments.dart';
import 'package:flutter/cupertino.dart';


class Navigate {
   static GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  static Future<dynamic> navigateTo<T extends Object, TO extends Object>(
      String routeName,
        ScreenArguments arguments,
      ) {
    print("arg >>"+arguments.toString());
    return navigatorKey.currentState.pushReplacementNamed(routeName,arguments: arguments);
  }  static Future<bool> navigatePop<T extends Object, TO extends Object>() {

  }
   static Future<dynamic> navigateTopay<T extends Object, TO extends Object>(
       String routeName,
         Object arguments,) {
     print("arg >>"+arguments.toString());
     return navigatorKey.currentState.pushNamed(routeName,arguments: arguments);
   }

}
