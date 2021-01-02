

import 'package:barika_web/regims/mainRegim.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/store/storeScreen.dart';
import 'package:barika_web/test_state_builder/diet_store.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/bottom_navigation.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'bottomMenu/btm_main.dart';

import 'home/homeScreen.dart';
import 'menu/menuScreen.dart';
import 'models/DbActivities.dart';
import 'models/DbActivityCat.dart';
import 'models/DbAllDiets.dart';
import 'models/DbFood.dart';
import 'models/DbFoodCat.dart';
import 'models/DbType.dart';
import 'models/DbUnits.dart';
import 'models/DbUnitsPviot.dart';
import 'models/bazarlogModel.dart';
import 'models/cereals.dart';
import 'models/fruits.dart';
import 'models/notices.dart';
import 'models/start.dart';
import 'package:http/http.dart' show get;
import 'dart:math';
import 'models/user.dart';
import 'models/version.dart';
import 'utils/SizeConfig.dart';
import 'package:path/path.dart' as Path;
class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}
// final _kShouldTestAsyncErrorOnInit = false;

// // Toggle this for testing Crashlytics in your app locally.
// final _kTestingCrashlytics = true;

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {



  String currentPageName = 'home';
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<
      ScaffoldState>(); // ADD THIS LINE

  void _selectTab(TabItem tabItem) {
    _currentTab = tabItem;
    if (tabItem.index == 3) {
      _scaffoldKey.currentState.openDrawer();
      // CHANGE THIS LINE
    }
  }

  TabItem _currentTab = TabItem.home;

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
    TabItem.store: GlobalKey<NavigatorState>(),
    TabItem.menu: GlobalKey<NavigatorState>(),
  };

  String returnVal;
  String apiDate;
  String _apkType = "bazaar";

  String gregorianDate = "";
  TabController _tabController;
  start _start;

//  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  var fontvar = 1.0;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    // getUser();
    getDiets();
    super.initState();
  }

  DateTime currentBackPressTime;

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

    return  WillPopScope(
      onWillPop: () async {


        if (_currentTab != TabItem.home) {
          _tabController.animateTo(0);
          _currentTab = TabItem.home;
        }
        else {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            Fluttertoast.showToast(
              msg: "برای خروج کلید بازگشت را مجددا فشار دهید.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: MyColors.vazn,
              textColor: Colors.white,
              fontSize: 15.0 * fontvar,

            );
            return Future.value(false);
          }
          return Future.value(true);
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        //
        appBar: PreferredSize(
          child: Container(
            color: Colors.green,
          ),
          preferredSize: Size.fromHeight(0),

        ),

        body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomeScreen(

                        keyButton: keyButton1

                    ),
                    mainRegim(),
                    storeScreen(),
                    menuScreen()
                  ],
                  controller: _tabController,


        ),
        drawer: menuScreen(),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 30 * (screenSize.width) / 375,),
          alignment: Alignment.bottomCenter,
          child: RawMaterialButton(
            key: keyButton1,
            onPressed: () async {
              navigate();

            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30.0 * (screenSize.width) / 375,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: MyColors.green,
            padding: EdgeInsets.all(15.0 * (screenSize.width) / 375),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


        bottomNavigationBar: BottomNavigationc(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
          tabController: _tabController,
        ),
      ),
    );
  }

  void getUser() {
    // final reactiveModel = Injector.getAsReactive<userStore>();
    // reactiveModel.setState(
    //       (store) => store.getUser(context),
    //   onError: (context, error) {
    //     if (error) {
    //       Scaffold.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text("Couldn't fetch weather. Is the device online?"),
    //         ),
    //       );
    //     } else {
    //       throw error;
    //     }
    //   },
    // );
  }
  void getDiets() {
    final reactiveModel = Injector.getAsReactive<dietStore>();
    reactiveModel.setState(
          (store) => store.getDiet(context),
      onError: (context, error) {
        if (error) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Couldn't fetch weather. Is the device online?"),
            ),
          );
        } else {
          throw error;
        }
      },
    );
  }

  navigate() async {

    returnVal = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => btmMain()));


    if (returnVal == "yes" || returnVal == null) {

      setState(() {

      });
    }
  }

  //
  // Future<bool> getallDiets() async {
  //
  //
  //   var _cerealsProvider = cerealsProvider(idbFactory: idbFactoryNative);
  //   await _cerealsProvider.open();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String apiToken = prefs.getString('user_token');
  //   String _cerealDate=prefs.getString("date_cereal")??"";
  //
  //
  //   if(! await checkConnectionInternet() || DateTime.now().difference(DateTime.parse(_cerealDate==""?"2020-05-05":_cerealDate)).inHours<1) {
  //     List<cereals> list =await _cerealsProvider.getAllcereals();
  //     setState(() {
  //       _cereals=list;
  //       if(_cereals.isEmpty){
  //         print("amoooooooooo");
  //         _isLoading = false;
  //       }
  //       else {
  //
  //         _currectCereal1 = _cereals[0];
  //         _currectCereal2 = _cereals[0];
  //         calorie1 = double.parse(_currectCereal1.calorie);
  //         calorie2 = double.parse(_currectCereal2.calorie);
  //         _isLoading = false;
  //       }
  //     });
  //
  //   }
  //
  //   else{
  //     List createdCereals=[];
  //     List updatedCereals=[];
  //     List deletedCereals=[];
  //
  //
  //     try {
  //       final response = await Provider.of<apiServices>(context, listen: false)
  //           .getCereals(_cerealDate, 'Bearer ' + apiToken);
  //
  //       print("response" + response.bodyString);
  //       final post = json.decode(response.bodyString);
  //       if (response.statusCode == 200 && post["result"]=="done") {
  //         try {
  //
  //
  //           createdCereals = post["data"]["createdCereals"];
  //           updatedCereals = post["data"]["updatedCereals"];
  //           deletedCereals = post["data"]["deletedCereals"];
  //
  //
  //           await _cerealsProvider.saveAllcereal(createdCereals);
  //           await _cerealsProvider.saveAllcereal(updatedCereals);
  //           await _cerealsProvider.deleteAllcereal(deletedCereals);
  //
  //           prefs.setString("date_cereal",DateTime.now().toString());
  //         }catch(e){
  //           print(e.toString());
  //         }
  //       } else {
  //         return null;
  //       }
  //     } catch (e) {
  //       print(e.toString() + "catttttch");
  //       return null;
  //     }
  //     List<cereals> list =await _cerealsProvider.getAllcereals();
  //     setState(() {
  //       _cereals=list;
  //       if(_cereals.isEmpty){
  //         print("amoooooooooo");
  //         _isLoading = false;
  //       }
  //       else {
  //
  //         _currectCereal1 = _cereals[0];
  //         _currectCereal2 = _cereals[0];
  //         calorie1 = double.parse(_currectCereal1.calorie);
  //         calorie2 = double.parse(_currectCereal2.calorie);
  //         _isLoading = false;
  //       }
  //     });
  //
  //
  //   }
  //
  // }

  showSnakBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2),
      backgroundColor: MyColors.vazn,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Text(
        s,
        style: TextStyle(fontWeight: FontWeight.w400,
            fontSize: 15 * fontvar,
            fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }}



