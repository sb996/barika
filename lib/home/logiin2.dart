// import 'dart:async';
// import 'package:barika_web/models/user.dart';
// import 'package:barika_web/regims/pishFactor.dart';
// import 'package:barika_web/utils/SizeConfig.dart';
// import 'package:barika_web/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// import '../helper.dart';
// class LoginScreen extends StatefulWidget {
//
//   User user;
//   int regimId;
//   String type;
//   String uid;
//   String url;
//   String metype;
//   String dietId;
//   bool edit;
//   LoginScreen({Key key,this.type,this.uid,this.url,this.user,this.metype,this.regimId,this.dietId,this.edit}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => new _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final flutterWebviewPlugin = new FlutterWebviewPlugin();
//
//   StreamSubscription _onDestroy;
//   StreamSubscription<String> _onUrlChanged;
//   StreamSubscription<WebViewStateChanged> _onStateChanged;
//   String type;
//   String uid;
//   int regimId;
//   String token;
//
//   @override
//   void dispose() {
//     // Every listener should be canceled, the same should be done with this stream.
//     _onDestroy.cancel();
//     _onUrlChanged.cancel();
//     _onStateChanged.cancel();
//     flutterWebviewPlugin.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
// //    goLuncher();
//
//     regimId=widget.regimId;
//     uid=widget.uid;
//     type=widget.type;
//     print(type);
//     super.initState();
//
//
//     // Add a listener to on destroy WebView, so you can make came actions.
//     _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
//       print("destroy");
//     });
//
//     _onStateChanged =
//         flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//           print("onStateChanged: ${state.type} ${state.url}");
//
//
//         });
//
//     // Add a listener to on url changed
//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) async {
//
//
//       if (mounted) {
//         if (url.startsWith("https://api.barikaapp.com/api/goal/res/success/200")) {
//
//
//           flutterWebviewPlugin.close();
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   Directionality(
//                       textDirection: TextDirection
//                       // .rtl, child: FirstPayment(userid: uid,diet:widget.metype ,amount:amount ,name: type,id: widget.user,)),
//                           .rtl, child: pishFactor(dietType: widget.metype,diet:widget.metype ,edit: widget.edit,dietId: regimId.toString(),)),
//             ),
//           );
//
//
//
//
//
//
//         }
//         print("URL changed: $url");
//
//       }
// //      }
//     });
//
//
//
//   }
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//     print(regimId);
//     print("regimId");
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
//     fontvar = (bh) / 3.75;
//     if(fontvar>2)fontvar=1.7;
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     String loginUrl =widget.url!=null
//         ?widget.url
//         : regimId!=null
//         ? widget.dietId==null
//         ? "https://api.barikaapp.com/api/diets/${dietName(type)}/$uid?dietId=$regimId"
//         : "https://api.barikaapp.com/api/diets/${dietName(type)}/$uid?dietId=$regimId&selfId=${widget.dietId}"
//         :widget.dietId==null
//         ? "https://api.barikaapp.com/api/diets/${dietName(type)}/$uid"
//         :  "https://api.barikaapp.com/api/diets/${dietName(type)}/$uid?selfId=${widget.dietId}";
//
//
//
//
//
//     return WebviewScaffold(
//
//       mediaPlaybackRequiresUserGesture: false,
//
//       displayZoomControls: false,
//       withZoom: false,
//       withLocalStorage: false,
//       hidden: false,
//
// //      initialChild: Container(
// //        color: Colors.redAccent,
// //        child: const Center(
// //          child: Text('Waiting.....'),
// //        ),
// //      ),
//       withJavascript: true,
//       url: loginUrl,
//
//
//
//
//
//       appBar:  PreferredSize(
//           preferredSize: Size.fromHeight(30*(screenSize.width)/375),
//           child:Container(
//             color: MyColors.green,
//             padding: EdgeInsets.only(top: 20*(screenSize.width)/375),
//             child:  IconButton(
//               icon: Icon(
//                 Icons.chevron_right,
//                 size:  32*(screenSize.width)/375,
//               ),
//               onPressed: (){ Navigator.pop(context, 'yes');},
//               alignment: Alignment.topLeft,
//               color: Colors.white,
//               splashColor: Colors.amber,
//               padding: EdgeInsets.all(7),
//             ),
//           )
//       ),
//
//     );}}