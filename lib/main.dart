
// import 'package:flutter/material.dart';
// import 'package:barika_web/testsqlite/note_provider.dart';
// import 'package:barika_web/testsqlite/pages/note_list.dart';
// import 'package:idb_shim/idb_shim.dart';
//
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   var noteProvider = NoteProvider(idbFactory: idbFactoryNative);
//   await noteProvider.open();
//   runApp(MyApp(noteProvider: noteProvider));
// }
//
// class MyApp extends StatelessWidget {
//   final NoteProvider noteProvider;
//
//   const MyApp({Key key, this.noteProvider}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: NoteListPage(
//           noteProvider: noteProvider,
//         ));
//   }
// }






import 'package:barika_web/dada.dart';
import 'package:barika_web/generated_plugin_registrant.dart';
import 'package:barika_web/home/homeScreen.dart';
import 'package:barika_web/mainScrenn.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/splashLogin/activation.dart';
import 'package:barika_web/splashLogin/language.dart';
import 'package:barika_web/splashLogin/login.dart';
import 'package:barika_web/splashLogin/signUp.dart';
import 'package:barika_web/splashLogin/splash.dart';
import 'package:barika_web/sqfliteProvider/provider.dart';
import 'package:barika_web/test_state_builder/diet_store.dart';

import 'package:barika_web/test_state_builder/user_store.dart';

import 'package:flutter/material.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:idb_sqflite/idb_client_sqflite.dart';
import 'package:provider/provider.dart' as  pp;
import 'package:states_rebuilder/states_rebuilder.dart';

main() async{


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pp.Provider(
      create: (_) => apiServices.create(),
      // Always call dispose on the ChopperClient to release resources
      dispose: (context, apiServices service) =>
          service.client.dispose(),

      child:MaterialApp(
    title: 'Weather App',
    home: Injector(
    inject: [
    Inject<userStore>(() => userStore()),
    Inject<dietStore>(() => dietStore()),
    ],
    builder: (context) =>MaterialApp(
        // navigatorKey: Navigate.navigatorKey,
        // onGenerateRoute: (settings) {
          // switch (settings.name) {
          //   case 'payquestionnaire':
          //     final ScreenArguments args = settings.arguments;
          //     return MaterialPageRoute(builder: (context) => questionnaire(
          //       logId: args.logId,
          //       metype: args.metype
          //       ,id: args.id
          //       ,type: args.type
          //       ,name: args.name
          //       ,uid: args.uid
          //       ,type2: args.type2,dietId: args.dietId,));
          //   case 'backpay':
          //     return MaterialPageRoute(builder: (context) => BackPayment(arg: settings.arguments));
          //   default:
          //     return MaterialPageRoute(builder: (context) => MainScreen());
          // }

        // },


        routes: {
          "/": (context) =>
          new Directionality(
              textDirection: TextDirection.rtl, child:SplashScreen()),
          // "/userInfo": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child:userInfo()),
          // "/getInfo": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child:getInfo()),
          // "/dailyInfo": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child:dailyInfo()),
          // "/album": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child:foodAlbum()),
          // "/regimi": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child:regimiFoodList()),
          // "/exercise": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child:ExerciseScreen()),
          //
          "/main": (context) =>
          new Directionality(
              textDirection: TextDirection.rtl, child: MainScreen()),
          "/language": (context) =>
          new Directionality(
              textDirection: TextDirection.rtl, child: LanguageScreen()),
          "/login": (context) =>
          new Directionality(
              textDirection: TextDirection.rtl, child: LoginScreen()),
          "/activation": (context) =>
          new Directionality(
              textDirection: TextDirection.rtl, child: ActivationScreen()),
          "/signup": (context) =>
          new Directionality(
              textDirection: TextDirection.rtl, child: SignupScreen()),
          // "/home": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: MainScreen()),
          // "/question": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: questionScreen()),
          // "/regimList": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: regimList()),
          // "/foods": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: foodScreen()),
          // "/sports": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: sportscreen()),
          // "/foodAlbum": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: foodAlbum()),
          // "/foodAlbumCat": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: foodAlbumCat()),
          // "/mokamel": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: mokamel()),
          // "/mokamelCat": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: mokamelCat()),
          // "/mokamelDetail": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: mokamelDetail()),
          // "/regimiFoodList": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: regimiFoodList()),
          // "/regimiFoodCat": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: regimiFoodCat()),
          // "/regimiFoodDetail": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: regimiFoodDetail()),
          // "/ExerciseScreen": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: ExerciseScreen()),
          // "/exerciseCat": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: exerciseCat()),
          // "/exerciseDetail": (context) =>
          // new Directionality(
          //     textDirection: TextDirection.rtl, child: exerciseDetail()),

        },
        title: 'Barika',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          fontFamily: "IRANSansDN",
          accentColor: Color(0xffF15A23),
          primaryColor: Color(0xFF6DC07B),
          primaryColorDark: Color(0xffF15A23),
          cursorColor: Color(0xffF15A23),
          backgroundColor: Color(0xffF5FAF2),

        ),
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          );},


    ))));
  }
}

