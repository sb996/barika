import 'dart:convert';
import 'package:barika_web/models/fruits.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/sqfliteProvider/fruit_provider.dart';
import 'package:barika_web/sqfliteProvider/provider.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' show get;
import 'package:idb_shim/idb_shim.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class fruitUnit extends StatefulWidget {
  State<StatefulWidget> createState() => fruitUnitState();

  fruitUnit({Key key}) : super(key: key);
}

class fruitUnitState extends State<fruitUnit> {
  List<fruits> _allFruit = [];
  List<fruits> _saveAllFruit = [];
  @override
  void initState() {
    getFruits();
    super.initState();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading=true;
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: MyColors.green,
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(padding: EdgeInsets.all(5),child:     IconButton(
              icon: Icon(
                Icons.chevron_right,
                size:  32,
                textDirection: TextDirection.rtl,
              ),
              onPressed: () {
                Navigator.pop(context);
              },

              color: Colors.white,
              splashColor: Colors.amber,
              padding: EdgeInsets.all(7),
            )),
          ],
          title: Text("اندازه واحد هر کدام از میوه ها ",style: TextStyle(
              color: Colors.white,
              fontSize:14*fontvar ,
              fontWeight:FontWeight.w700
          ),),
        ),

        body:

        _isLoading
            ? LoadingW()
            :   new ListView.builder(
            itemCount:_allFruit.length+1,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            itemBuilder: (context, index) {
              if(index==0)
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Color(0xff5c5c5c),
                            fontSize: 14 * fontvar,
                            fontWeight: FontWeight.w500),
                        decoration:  InputDecoration(
                            focusColor: Colors.white,
                            fillColor: Colors.white,

                            suffixIcon: Padding(
                              padding: EdgeInsets.all(0), child: Icon(
                              Icons.search,
                              color: Color(0xffA2A2A2),
                            ),),

                            border:  OutlineInputBorder(
                                borderSide:  BorderSide(
                                    color: MyColors.border, width: 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            enabledBorder:  OutlineInputBorder(
                                borderSide:  BorderSide(
                                    color: MyColors.border, width: 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            focusedBorder:  OutlineInputBorder(
                                borderSide:  BorderSide(
                                    color: MyColors.green, width: 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            hintText: 'جستجو',
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 14 * fontvar,
                                fontWeight: FontWeight.w400),
                            contentPadding: const EdgeInsets.only(
                                top: 5, right: 5, bottom: 0, left: 5)),
                        onChanged: (String value) async {
                          if (value.contains(
                              String.fromCharCode(1610))) {
                            int index = value.indexOf(String
                                .fromCharCode(1610));
                            print(index.toString());
                            value = value.replaceRange(
                                index, index + 1, String.fromCharCode(
                                1740));
                          }

                          if (value.contains(
                              String.fromCharCode(1603))) {
                            int index = value.indexOf(String
                                .fromCharCode(1603));
                            print(index.toString() + "سسب");
                            value = value.replaceRange(
                                index, index + 1, String.fromCharCode(
                                1705));
                          }

                          searchFruit(value);
                        },


                      ),
                    ),

                  ],
                );
              else
                return listItem(index-1);}));
  }




  Future<bool> getFruits() async {


    var _fruitProvider = fruitProvider(idbFactory: idbFactoryNative);
    await _fruitProvider.open();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    String fruitDate=prefs.getString("date_fruit")??"";
    print(fruitDate);

    if(! await checkConnectionInternet() || DateTime.now().difference(DateTime.parse(fruitDate==""?"2020-05-05":fruitDate)).inHours<1) {
      List<fruits> list =await _fruitProvider.getAllFruits();
      setState(() {
        _allFruit = list;
        _saveAllFruit=list;
        _isLoading = false;
      });
    }

    else{
      List createdFruits=[];
      List updatedFruits=[];
      List deletedFruits=[];


      try {
        final response = await Provider.of<apiServices>(context, listen: false)
            .getFruits(fruitDate, 'Bearer ' + apiToken);

        print("response" + response.bodyString);
        final post = json.decode(response.bodyString);
        if (response.statusCode == 200 && post["result"]=="done") {
          try {
            print(post["createdFruits"]);

            createdFruits = post["data"]["createdFruits"];
            updatedFruits = post["data"]["updatedFruits"];
            deletedFruits = post["data"]["deletedFruits"];

            // print("_ff.toMap()" + createdFruits[0].toString());

            await _fruitProvider.saveAllFruit(createdFruits);
            await _fruitProvider.saveAllFruit(updatedFruits);
            await _fruitProvider.deleteAllFruit(deletedFruits);

            prefs.setString("date_fruit",getDateToday());
          }catch(e){
            print(e.toString());
          }
        } else {
          return null;
        }
      } catch (e) {
        print(e.toString() + "catttttch");
        return null;
      }
      List<fruits> list =await _fruitProvider.getAllFruits();

      setState(() {
        _allFruit = list;
        _saveAllFruit = list;
        _isLoading = false;
      });

    }

  }







  searchFruit(String searchText){
    List<fruits> searchList=[];
    _allFruit=_saveAllFruit;
      // if(searchText.isEmpty){
      //   setState(() {
      //     _allFruit =_saveAllFruit;
      //   });
      // }
      // else{
        _allFruit.forEach((element) {
          if(element.name.contains(searchText))
            searchList.add(element);
        });

        setState(() {
          _allFruit =searchList;
        });
      // }
}

//
// List<fruits> products = [];
//     try {
//       var db = new fruitsProvider();
//       await db.open();
//       products = await db.paginate();
// //      await db.close();
//     } catch (e) {
//       print(e.toString());
//     }
//
//
//     print("elseeeeinjaa");
//     if (mounted) setState(() {
//       _allFruit = products;
//       _isLoading = false;
//     });
//   }



  Widget listItem(int i) {



    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return Card(
        elevation: 8,
        margin:EdgeInsets.only(top:16) ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 8),
              child:  FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: _allFruit[i].cover,
                fit: BoxFit.contain,
                width:85*(screenSize.width-20)/355,
                height:(95)*(screenSize.width-20)/355 ,
              ),





              //
              // _allFruit[i].cover.contains("https://api.barikaapp.com")
              //     ?ClipRRect(
              //     borderRadius: BorderRadius.circular(10.0),
              //     child:Image.asset('assets/images/placeholder.png',
              //       fit: BoxFit.cover,
              //      width:85*(screenSize.width-20)/355,
              //      height:(95)*(screenSize.width-20)/355 ,))
              //     :    Image.memory(
              //   base64Decode(_allFruit[i].cover),
              //   fit: BoxFit.contain,
              //   width:85*(screenSize.width-20)/355,
              //   height:(95)*(screenSize.width-20)/355 ,
              // ),
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_allFruit[i].name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19*fontvar,
                      fontWeight: FontWeight.w500
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(child:  Text("اندازه یک واحد:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16*fontvar,
                          fontWeight: FontWeight.w400
                      ),)),
                    Flexible(child: Text(_allFruit[i].size,
                        style: TextStyle(
                            color: MyColors.green,
                            fontSize: 16*fontvar,
                            fontWeight: FontWeight.w400
                        )),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(child:     Text("وزن یک واحد:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16*fontvar,
                          fontWeight: FontWeight.w400
                      ),)),
                    Flexible(child:  Text(_allFruit[i].weight +" گرم",
                      style: TextStyle(
                          color: MyColors.green,
                          fontSize: 16*fontvar,
                          fontWeight: FontWeight.w400
                      ),)),
                  ],
                ),
              ],
            ))
          ],
        ),)
    );


  }

  LoadingW() {

    return  Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));

  }

  showSnakBar(String name)  {

    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          duration: new Duration(seconds: 5),
          backgroundColor: MyColors.vazn,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          content: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15*fontvar,fontFamily: "iransansDN"),textDirection: TextDirection.rtl,),
        ));

  }

}