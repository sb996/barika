
import 'dart:convert';
import 'dart:ui';

import 'package:barika_web/helper.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'activation.dart';
import 'components/Form.dart';
import 'components/InputFields.dart';
import 'package:barika_web/utils/custom_expansion_tile4.dart' as custom;
class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showLoading = false;
//  String _emailValue;
  String _phonValue;
  String _nameValue;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
//  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController inviteController = new TextEditingController();
  final GlobalKey<custom.ExpansionTileState4> expansionTileKeyCar = new GlobalKey();// NE
  String countryCode="";
  List<String> _MyExpandedList = [];
  String _apkType="bazaar";
  startTime() {
    // var _duration = new Duration(seconds: 5);
    //  return new Timer(_duration , navigationPage );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareData();
    showLoading = false;
  }

  bool sufix=true;
  var loginColor = Color(0xffF15A23);
  var signupColor = Color(0xFF6DC07B);
  var textColor = Color(0xff51565F);


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

    return new Scaffold(

        key: _scaffoldKey,
        body: Builder(
            builder: (context) => new CustomScrollView(
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
                              fit: BoxFit. fill,
                              color: MyColors.green,
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
                      padding: EdgeInsets.only(top: 25, bottom: 15),
                      child: Text(
                        'ثبت نام',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: signupColor,
                          fontSize: 20*fontvar,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

           Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:  Column(
              children: <Widget>[
                 Form(
                  key : _formKey,
                  child:  Column(
                    children: <Widget>[
                       InputFieldArea(
                          keyboardtype: TextInputType.text,
                          hint: "نام و نام خانوادگی",
                          validator: (String value) {
                            if(value.length==0) {
                              return
                                'نام خود را وارد کنید!';
                            }
                          },
                          controller : nameController
                      ),

                      Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child:
                                Container(
                                  // height: 50*(screenSize.width)/375,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child:
                                  TextFormField(

                                    onChanged: (String text){
                                      if (text.length>0)
                                        setState(() {
                                          sufix=false;
                                        });
                                      else
                                        setState(() {
                                          sufix=true;
                                        });
                                    },

                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validator: (String value) {
                                      if(value.length<5) {
                                        return 'شماره موبایل صحیح نمی باشد!';
                                      }},
                                    style:   TextStyle(color: Color(0xff51565F) , fontSize: 14*fontvar,fontWeight: FontWeight.w400),

                                    decoration:  InputDecoration(
                                        suffixIcon:!sufix?Container(height: 0,width: 0,):  Container(
                                          height: 50*(screenSize.width)/375,
                                          alignment: Alignment.centerLeft ,

                                          width:100*(screenSize.width)/375 ,
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text("9123456789",style: TextStyle(color: Colors.grey , fontSize: 14*fontvar,fontWeight: FontWeight.w400),),),
                                        // suffix: Text("9123456789",style: TextStyle(color: Colors.grey , fontSize: 14*fontvar,fontWeight: FontWeight.w400),),
                                        // suffixStyle: TextStyle(color: Colors.grey , fontSize: 14*fontvar,fontWeight: FontWeight.w400),
                                        enabledBorder:  OutlineInputBorder(
                                            borderSide:  BorderSide(
                                                color: Color(0xffD5D5D5),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xff6DC07B),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xffED0A0A),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffED0A0A),
                                                width: 1
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        hintText:  "شماره موبایل",
                                        hintStyle:  TextStyle(color: Colors.grey , fontSize: 14*fontvar,fontWeight: FontWeight.w400),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10 , right: 5 , bottom: 10 , left: 5
                                        )
                                    ),
                                  ),

                                ),
                              ),
                              _apkType=="bazaar"
                                  ?Container(height: 0,width: 0,)
                                  :   Expanded(
                                flex: 1,
                                child:      custom.ExpansionTile4(
                                  key: expansionTileKeyCar,
                                  onExpansionChanged: (bool expanded) {
                                    print(expanded);
                                  },

                                  borderColor: Color(0xff6DC07B),
                                  size: screenSize,
                                  iconColor: Color(0xffA2A2A2),
                                  headerBackgroundColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    countryCode,
                                    style:   TextStyle(
                                        fontSize: 15.0 * fontvar,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5c5c5c)),textAlign: TextAlign.center,textDirection: TextDirection.ltr,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: _buildExpandableContent(),
                                    )
                                  ],
                                ),
                              )
                            ],

                          ) ),



                       InputFieldArea(
                          keyboardtype: TextInputType.text,
                          hint: "در صورت داشتن کد معرف آن را وارد کنید.",
                          validator: (String value) {
//                    if(value.length<11) {
//                      return 'کد معرف صحیح نمی باشد!';
//                    }
                          },
                          controller : inviteController
                      ),
//                new InputFieldArea(
//                  keyboardtype: TextInputType.emailAddress,
//                  hint: "ایمیل",
//                  validator: (String value) {
//                    if(!isEmail(value)) {
//                      return 'ایمیل صحیح نمیباشد!';
//                    }
//                  },
//                    controller : emailController
//                ),
                    ],
                  ),

                )
              ],
            ),
          ),
//                      FormContainer(
//                       formKey: _formKey,
// //                            emailController: emailController,
//                       nameController: nameController,
//                       phonController: phoneController,
//                       inviteController: inviteController,
//
//
//                     ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              width:  MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  color: signupColor,
                                  disabledColor:signupColor.withOpacity(0.3) ,
                                  onPressed: showLoading
                                      ?null
                                      : () async {
                                    if (await checkConnectionInternet()) {
                                      if (_formKey.currentState
                                          .validate()) {
                                        register(context);
                                      }
                                    } else {
                                      showSnakBar("خطا در برقراری ارتباط");
                                      setState(() {
                                        showLoading = false;
                                      });
                                    }

//                                register(context);
                                  },
                                  child: Text(
                                    showLoading ? '' : 'ثبت نام',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14*fontvar),
                                  )),
                            ),
                             (showLoading)?
                              SpinKitThreeBounce(
                                color: Colors.white,
                                size: 20,
                              ):Container(width:0,height:0),
                          ],
                        )),
                  ]),
                )
              ],
            )));
  }

  register(BuildContext context) async {
    print(inviteController.text);
    setState(() {
      showLoading = true;
    });
    String code=countryCode.substring(1);
    final newPost = {
      'name': nameController.text,
      'phone': phoneController.text,
      'presenter_referral': inviteController.text,
//      'email': emailController.text,
      'lang': 'fa',

    };
    try {
      final response =
      await Provider.of<apiServices>(context,listen: false).registerCode(
        nameController.text,
         phoneController.text,
        inviteController.text??"",
         'fa',
          code

      );
      print(response.error.toString());
      print(response.bodyString.toString());
      if (response.statusCode == 200) {
        final post = json.decode(response.bodyString);
        if(post['status'].toString()=="failed"){
          setState(() {
            showLoading = false;
          });
          showSnakBar(post['msg']);
        }
        else {


        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ActivationScreen(phone: phoneController.text,country:code ,),
          ),
        );
      }} else {
        showSnakBar("خطا در برقراری اطلاعات لطفا مجددا تلاش کنید.");


        setState(() {
          showLoading = false;
        });
      } // We cannot really add any new posts using the placeholder API,
      // so just print the response to the console
//      print('${response.body.toString()}   aaaa  ${nameController.text}  sss ${response.statusCode.toString()}');

    } catch (e) {


      setState(() {
        showLoading = false;
      });
      showSnakBar("خطا در برقراری اطلاعات لطفا مجددا تلاش کنید.");

    }
  }
  _buildExpandableContent() {
    List<Widget> columnContent = [];

    for (int i = 0; i < _MyExpandedList.length; i++)
      columnContent.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child:Padding(
              padding:EdgeInsets.symmetric(horizontal: 5,vertical: 8) ,
              child: Text(
                _MyExpandedList[i],
                style:  TextStyle(
                  fontSize: 15.0 * fontvar,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5c5c5c),),textAlign: TextAlign.center,textDirection: TextDirection.ltr,
              ),
            ),
            onTap: () async {
              setState(()  {
                expansionTileKeyCar.currentState.handleTap();
                countryCode= _MyExpandedList[i];

              });

            },
          ),

          Divider(
            color: Color(0xffA2A2A2),
            endIndent: 15,
            height: 1,
            indent: 15,
          )
        ],
      ));

    return columnContent;
  }
  prepareData() async {

    setState(() {
      _MyExpandedList=[

        "+1",
        "+7",
        "+12",
        "+20",
        "+27",
        "+30",
        "+31",
        "+32",
        "+33",
        "+34",
        "+36",
        "+39",
        "+40",
        "+41",
        "+42",
        "+43",
        "+44",
        "+45",
        "+46",
        "+47",
        "+48",
        "+49",
        "+51",
        "+52",
        "+54",
        "+55",
        "+60",
        "+61",
        "+62",
        "+63",
        "+64",
        "+65",
        "+66",
        "+81",
        "+82",
        "+86",
        "+90",
        "+91",
        "+92",
        "+93",
        "+98",
        "+213",
        "+218",
        "+234",
        "+351",
        "+353",
        "+354",
        "+357",
        "+358",
        "+359",
        "+374",
        "+375",
        "+380",
        "+381",
        "+386",
        "+752",
        "+850",
        "+880",
        "+886",
        "+961",
        "+962",
        "+963",
        "+964",
        "+965",
        "+966",
        "+967",
        "+968",
        "+970",
        "+971",
        "+973",
        "+974",
        "+976",
        "+992",
        "+993",
        "+994",
        "+998",

      ];



      countryCode=_MyExpandedList[40];


    });


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
}
