

import 'dart:ui';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'colors.dart';


class rulesdialog extends StatefulWidget {

  DbAllDiets allDiet;

  rulesdialog({Key key, this.allDiet}) : super(key: key);
  State<StatefulWidget> createState() => rulesdialogState();
}

class rulesdialogState extends State<rulesdialog> {

  String description=
      "کاربر گرامی، ضمن سپاس از انتخاب باریکا لازم است پیش از نصب این اپلیکیشن، قوانین ذیل را مطالعه فرمایید"+ "\n"+
      "باریکا خدمات خود را تحت شرایط و مقررات این صفحه در اختیار شما می گذارد و شما به عنوان کاربر این اپلیکیشن ملزم ‏به رعایت مفاد ذیل هستید.‏"+"\n"+
      "۱-‏ کلیه فعالیتها و محتواهای باریکا تابع قوانین و مقررات جاری کشور جمهوری اسلامی ایران است.‏"+"\n"+
      "۲- اعمال غیر قانونی و مغایر با قوانین موضوعه جمهوری اسلامی ایران به هر نحو ممکن ممنوع است‎"+"\n"+
      "۳- ثبت نام در باریکا مستلزم پذیرش و رعایت کلیه قوانین و مقررات ثبت شده در باریکا می باشد.‏"+"\n"+
      "۴.‏ ثبت نام در باریکا از طریق ورود شماره تلفن همراه معتبر انجام می شود."+"\n"+
      "۵- ثبت نام در باریکا رایگان است. در قسمت ثبت‌نام بعضی مشخصات شخصی از قبیل نام و نام خانودگی، شماره تلفن، سن و وزن و میزان فعالیت از کاربر پرسیده می‌شود. جمع‌آوری این اطلاعات به باریکا اجازه می‌دهد تا علاوه بر محاسبه دقیق کالری ، اطلاعات دقیق‌تری نسبت به کاربران خود داشته باشد تا  بتواند کاربران را به بهترین شکل ممکن به سمت سلامتی و تناسب اندام سوق دهد. تمام اطلاعات دریافت شده از کاربران کاملا محرمانه نزد ما باقی خواهد ماند."+"\n"+
      "۶-این قوانین شامل تمام محصولات و خدمات ارائه شده توسط اپلیکیشن باریکا، شامل وب‌سایت و اپلیکیشن‌ کالری‌شمار و رژیم درمانی آنلاین باریکا می‌باشد. باریکا یک اپلیکیشن همزمان کالری‌شمار و رژیم درمانی آنلاین با قابلیت ارائه رژیم‌های متنوع غذایی می‌باشد. این اپلیکیشن‌ با هدف بهبود وضعیت تغذیه‌ای، کاهش وزن ، افزایش وزن و تثبیت وزن در گروههای مختلف جامعه اعم از کودکان و نوجوانان، بزرگسالان، مادران باردار و شیرده، ورزشکاران و گیاهخواران توسط متخصصین تغذیه و رژیم درمانی و اعضا هیئت علمی دانشگاه علوم پزشکی طراحی و توسعه یافته است و به کاربران اجازه می‌دهند تا با ثبت‌نام در برنامه و وارد کردن مشخصات فردی و میزان فعالیت‌ها و اشتهای خود، علاوه بر قرار گرفتن در مسیر  حرکت به سمت وزن ایده‌آل توصیه های علمی و کاربردی مربوط به انواع بیماری های مزمن را دریافت کنند و با استفاده از روش کالری‌شماری‌ (کالری‌شمار باریکا) به همراه ارائه دستورهای غذایی متنوع (رژیم درمانی آنلاین باریکا) سبک زندگی سالم‌تری را تجربه کنند."+"\n"+
      "7- باریکا با استفاده از علمی ترین و دقیق ترین محاسبات کالری ، پروتئین ، کربوهیدرات و چربی را برای فرد محاسبه خواهد کرد بعلاوه کاربر قادر خواهد بود در طول روز میزان دریافت تمام مواد معدنی و ویتامین های دریافتی خود را محاسبه و با مقادیر نرمال مخصوص خود مقایسه کند.مسئولیت حفظ و نگهداری سخت افزار موبایل و کامپیوترها و تمام هزینه های آن بر عهده کاران بوده و باریکا مسئول صدمات ناشی از ابزار کاربر نمی‌باشد.محصول‌های مشمول هزینه در اپلیکیشن باریکا به دو بخش مجزا تقسیم می شود:"+"\n"+
      "بخش اول :    اشتراک‌های مدت‌دار (یک ماهه، سه ماهه و شش ماهه) است که با خریداری آن‌ها کاربر به قسمت «تعیین هدف»، «نمودارها»، «ویدیوهای تمرین‌های خانگی و باشگاهی»، «دستور پخت غذاهای رژیمی»  و نیز قسمت«مکمل های غذایی» دسترسی خواهد داشت."+"\n"+
      "بخش دوم :  خرید برنامه های غذایی ۱۴ روزه تخصصی جهت کاهش یا افزایش یا حفظ وزن ، برنامه های غذایی اختصاصی دوران بارداری ، شیردهی ، کودکان ۲ تا ۳ سال و ۳ تا ۱۲ سال ، انواع ورزشکارن ،  انواع رژیم های گیاهخواری ، رسم نمودار روند وزن گیری دوران بارداری و رسم نمودار های پایش رشد کودکان تا ۱۲ سال می باشد  که بعد از اتمام مدت آن غیرفعال می‌گردد."+"\n"+
      " 8- برنامه های غذایی اپلیکیشن باریکا به صورت کاملا علمی و تخصصی به شکل انفرادی برای کاربری که اطلاعات خود را وارد کرده است طراحی می شود و اپلیکیشن باریکا در مورد عواقب استفاده از برنامه توسط شخص دیگر ( بجز کاربر) هیچ مسئولیتی ندارد."+"\n"+
      " 9- اختلال در سرویس اینترنت یا هر دلیلی که باعث شود فرایند خرید به انجام نرسد باعث از بین رفتن حق کاربر نمی‌شود و در صورتی که مبلغی از حساب کاربر کسر شده باشد حداکثر تا ۷۲ ساعت بعد، از طریق بانک به وی بازپرداخته خواهد شد."+"\n"+
      "۱0- باریکا بر مبنای قوانین جرایم رایانه‌ای متعهد می‌شود با استفاده از تمامی امکانات و منابع خود در جهت حفظ و نگهداری از اطلاعات شخصی کاربران اقدام نماید. بدیهی است که استفاده‌ی مداوم از برنامه به منزله‌ی تایید شرایط سیاست‌نامه‌ی حفظ حریم خصوصی باریکا می‌باشد."+"\n"+
      " در صورت داشتن هرگونه ابهام، سوالات خود را به یکی از روش‌های زیر با باریکا در میان بگذارید:"+"\n"+
      "شماره تماس: ۳۳۳۸۶۳۹۳-۰۶۱"+"\n"+
      "ایمیل باریکا: Barika.app123@gmail.com"+"\n"+
      "آدرس: اهواز، کیانپارس، خیابان پانزده غربی، فاز یک، مجتمع ایرانپارس، واحد ۹"+"\n";
  bool dontShow = false;
  DbAllDiets _allDiet;
  @override
  void initState() {
    _allDiet=widget.allDiet;
    // TODO: implement initState
    super.initState();
  }
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar=(bh)/3.75;
    if(fontvar>2)fontvar=1.7;
    var screenSize=MediaQuery.of(context).size;
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
    return  Container(

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))

      ),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        height: 350 * (screenSize.height) / 595,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

                  Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          color: MyColors.green,
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
//                  child:  IconButton(alignment: Alignment.topRight,icon: Icon(Icons.clear,color: Colors.white,size: 30,), onPressed: (){ Navigator.of(context).pop();}),
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                          padding: EdgeInsets.all(0 * (screenSize.width) / 375),
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 25 * (screenSize.width) / 375,
                              ),
                              alignment: Alignment.centerLeft,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                        Center(
                            child: Text(
                          "قوانین",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16 * fontvar,
                              fontWeight: FontWeight.w600),
                        ))
                      ]),




            ),
      Expanded(

          child:  SingleChildScrollView(
            scrollDirection: Axis.vertical,//.horizontal
            child:  Padding(
              padding:  EdgeInsets.symmetric(vertical: 5 * (screenSize.width) / 375,horizontal: 8 * (screenSize.width) / 375),
              child: Text(description,
                style: TextStyle(

                    color: Colors.black,
                    fontSize: 14*fontvar,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            )
          )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: FlatButton(

                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: MyColors.green,
                            width: 1
                        ),
                        borderRadius: new BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),

                      onPressed: () {     Navigator.pop(context, 'no');
                      },
                      child: Text(
                        'نمی پذیرم',
                        style: TextStyle(
                            color: MyColors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 14*fontvar),
                      )),),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: FlatButton(
                      shape: RoundedRectangleBorder(

                        borderRadius: new BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      color: MyColors.green,
                      onPressed: () async {

                        Navigator.pop(context, 'yes');

                      },
                      child: Text(
                        'می پذیرم',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14*fontvar),
                      )),)

                ],


              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
            )

          ]),




    );



    }

    );


  }

    }

