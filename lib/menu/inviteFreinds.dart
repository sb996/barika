
import 'package:barika_web/models/user.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class inviteFriends extends StatefulWidget {
  String code;
  inviteFriends(this.code);
  @override
  State<StatefulWidget> createState() => inviteFriendsState();
}

class inviteFriendsState extends State<inviteFriends> {
  String code;
  void initState() {
    code=widget.code;
    super.initState();
  }


  String _description= "این اپلیکیشن شاهکاره ! "+ "\n"+
      "یه کالری شمار واقعی و دقیق."+ "\n"+
      "علاوه بر کالری، چربی، کربوهیدرات و پروتئین غذاها، همه ویتامینها و مواد معدنی روزانه تو حساب میکنه و با استاندارد خودت مقایسه میکنه. تازه می تونی انواع رژیم های چاقی، لاغری، حفظ وزن، بارداری، شیردهی، کودکان، ورزشکاری و گیاهخواری رو که توسط متخصصین تغذیه و اساتید دانشگاه طراحی شده درخواست بدی."+ "\n"+
      "همین الان از لینک زیر نصبش کن:"+ "\n"+
      "https://barikaapp.com/barika-application/"+ "\n"+
      "تو قسمت کد معرف کد من رو وارد کن"+ "\n"+
      "کد معرف : ";
String text="d";
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
        backgroundColor: Color(0xffF5FAF2),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 85,
          title: Text(
            'دعوت از دوستان',
            style: TextStyle(
                fontSize: 14*fontvar, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_right,
                size:  32*(screenSize.width)/375,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              alignment: Alignment.topLeft,
              color: Colors.white,
              splashColor: Colors.amber,
              padding: EdgeInsets.all(7),
            ),
          ],
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: MyColors.green
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child:Image.asset(
                      'assets/icons/giftbox.png',
                      alignment: Alignment.center,
                      width:  80*(screenSize.width)/375,
                      height:  80*(screenSize.width)/375,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'با دعوت از دوستان خود و اشتراک کد تخفیف خود با آن ها ده روز اشتراک رایگان از باریکا بگیرید.',
                      style: TextStyle(
                          color: Color(0xff5c5c5c),
                          fontWeight: FontWeight.w500,
                          fontSize: 14*fontvar),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:Colors.black12 ,
                          spreadRadius:5,
                          blurRadius:5,
                          offset: Offset(
                            1,
                            // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),

                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 55),
                    child: Text(

                      code??"نامشخص",

                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Color(0xff5c5c5c),
                          fontSize: 14*fontvar,
                          fontWeight: FontWeight.w500),
                    ),
                    width: 100,
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/share.png',
                                  color: Colors.blue,
                                  width: 18 * (screenSize.width) / 375,
                                  height: 18 * (screenSize.width) / 375,
                                ),
                                Padding(padding: EdgeInsets.only(right: 5,top: 5),child: Text(

                                  'لینک خود را به اشتراک بگذارید.',

                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fontvar),
                                  textAlign: TextAlign.center,
                                ),)
                              ],
                            ),


                          ],
                        ),
                        onTap: text.isEmpty
                            ? null
                            : () {
                          // A builder is used to retrieve the context immediately
                          // surrounding the RaisedButton.
                          //
                          // The context's `findRenderObject` returns the first
                          // RenderObject in its descendent tree when it's not
                          // a RenderObjectWidget. The RaisedButton's RenderObject
                          // has its position and size after it's built.
                          final RenderBox box = context.findRenderObject();
                          // Share.share(_user.referral_code ==null
                          //     ?" "+_description
                          //     :_description+"\n"+ _user.referral_code ,
                          //     subject: "کد معرف",
                          //     sharePositionOrigin:
                          //     box.localToGlobal(Offset.zero) &
                          //     box.size);
//                          Share.share(_user.referral_code ??
//                              " " + "کد معرف من در برنامه کینگ دایت:",
//                              subject: "کد معرف",
//                            sharePositionOrigin:
//                            box.localToGlobal(Offset.zero) &
//                            box.size);
                      },
                    )
                  ),
//                  Container(
//
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.all(Radius.circular(5)),
//                    ),
//                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//
//                      children: <Widget>[
//                        Padding(
//                            padding: EdgeInsets.only(bottom: 5,left: 10,right: 5),
//                            child:Radio(value: 1, groupValue: 1, onChanged: (int a){},
//                            )),
//                        Padding(padding: EdgeInsets.symmetric(horizontal: 3),
//                            child:Text('پرداخت آنلاین')   )
//                      ],
//                    ),
//                    width: 100,
//                    height: 50,
//
//                  )
                ]))
          ],
        ));
  }

}
