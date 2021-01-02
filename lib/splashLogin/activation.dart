import 'dart:async';
import 'dart:convert';

import 'package:barika_web/mainScrenn.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import '../helper.dart';
import 'components/Form.dart';
import 'components/InputFields.dart';
import 'getInfo.dart';

class ActivationScreen extends StatefulWidget {
//final String code;
final String phone;
final String country;
  // In the constructor, require a Todo.
  ActivationScreen({Key key, @required this.phone,this.country}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new ActivationScreenState();
}

class ActivationScreenState extends State<ActivationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var loginColor = Color(0xffF15A23);
  var signupColor = Color(0xFF6DC07B);
  var textColor = Color(0xff51565F);
  bool showLoading=false;
  TextEditingController codeController = new TextEditingController();
  @override
  void initState() {

    print(widget.country);
    // TODO: implement initState
    super.initState();
    showLoading=false;
//    Future.delayed(Duration(seconds: 1)).then(
//            (_) => showSnakBar(widget.code)
//    );
  }
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return  Scaffold(
        key: _scaffoldKey,
        body:
        Builder(
        builder: (context) =>
         CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                  height: screenSize.height / 2.8,
                  child: Stack(
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: 6,
                        child: Image.asset(
                          'assets/images/bg_intro.png',
                          alignment: Alignment.topCenter,
                          color: MyColors.green,
                          fit: BoxFit. fill,
                          width:  MediaQuery.of(context).size.width,
                          height: screenSize.height / 2.8,
                        ),
                      ),
                      new Center(
                          child: Image.asset('assets/images/logo.png',

                        fit: BoxFit.contain,
                            width: 110*(screenSize.width)/375,
                            height: 90*(screenSize.width)/375,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 10),
                  child: Text(
                    'کد تایید',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: signupColor,
                      fontSize: 20*fontvar,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    'لطفا کد فعال سازی را وارد کنید',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: signupColor,
                      fontSize: 14*fontvar,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:  Form(
                    key: _formKey,
                    child: new InputFieldArea(
                    controller: codeController,
                    keyboardtype: TextInputType.phone,
                    hint: '',
                    validator: (String value) {
                      if(value.length<2) {
                        return 'کد را وارد کنید.';
                      }
                    },

                  ),)
                ),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),

                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                              color: signupColor,
                              disabledColor:signupColor.withOpacity(0.3) ,
                              onPressed: showLoading
                                  ?null
                                  : () async {

                                if (_formKey.currentState.validate())
                                 if (await checkConnectionInternet()) {
                                     activationCode(context);
                                }
                                else {

                                   showSnakBar("خطا در برقراری ارتباط");

                                setState(() {
                                  showLoading = false;
                                });
                                }


                              },
                              child: Text(
                              showLoading? ''
                              :'تایید',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14*fontvar),
                              )),
                        ),
                        if(showLoading)
                          SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20,
                          )
                      ],

                    )
                ),
              ]),
            )
          ],
        )));

  }


  showSnakBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2),
      backgroundColor: MyColors.vazn,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),

      content: Text(
        s,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15*fontvar,fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }



  activationCode(BuildContext context) async{
    print(showLoading);
   setState(() {
     showLoading=true;
   });
    print(showLoading);
    final newPost = {
      'code': codeController.text,
      'phone': widget.phone,
      'country': widget.country
    };
    try{
    final response = await Provider.of<apiServices>(context,listen: false)
        .getToken2(widget.phone,codeController.text,widget.country);
    if(response.statusCode==200) {
      final post = json.decode(response.bodyString);
      final token =post['success']['token'].toString();
      print('${token}');
      storeUserData(token);

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Directionality(textDirection: TextDirection.rtl, child:MainScreen()),
        ),
      );
      //token agfgf19796
      //09161228520

      //token agfgf23706
      //09166229021
    }

    else {
      print(response.error.toString());
      String error = "خطا در دریافت اطلاعات";
      if (response.error.toString().contains("Unauthorised"))
        error = "کد وارد شده صحیح نمی باشد";
      print(response.error.toString().contains("duplic").toString());
      showSnakBar(error);


      setState(() {
        showLoading = false;
      });
    }

      print(response.statusCode.toString());

    }catch(e){
      showSnakBar("خطا در دریافت اطلاعات");

      setState(() {
        showLoading = false;
      });
    }
    // We cannot really add any new posts using the placeholder API,
    // so just print the response to the console
//      print('${response.body.toString()}   aaaa  ${nameController.text}  sss ${response.statusCode.toString()}');

  }

  storeUserData(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   if (await prefs.getString("user_token")!=null ) prefs.remove("user_token");
    await prefs.setString('user_token', token);
    await prefs.setString('country', widget.country);
    print('saved!');
  }
}
