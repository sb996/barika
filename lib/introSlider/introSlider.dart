
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class IntroSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IntroSliderState();

}
 class IntroSliderState extends State<IntroSlider>{
  int currentPageValue=0;
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screeenSize = MediaQuery.of(context).size;
    if(screeenSize.width>600)screeenSize=Size(600, screeenSize.height);

    PageController _pageController=PageController(initialPage: 0);

    final List<Widget> introWidgetsList = <Widget>[
      Screen('assets/images/intro1.png', 'كاملترين اپليكيشن همزمان رژيم درمانی آنلاين و كالری شمار  طراحی شده و تحت مديريت متخصصان تغذيه'),
      Screen('assets/images/intro2.jpg', 'ارائه انواع رژيم های آنلاين كاهش وزن، افزايش وزن، تثبيت وزن، بارداری، شيردهی، كودكان و نوزادان، پايش رشد كودكان،  ورزشكاری و گياهخواری با منوی غذايی متنوع'),
      Screen('assets/images/intro3.jpg', 'كالری شمار دقيق با بيش از ٢٠٠٠ ماده غذايی با قابليت همزمان شمارش كالری ، مواد معدنی و ويتامين ها  و مقايسه آن با مقادير استاندارد مورد نياز'),
      Screen('assets/images/intro4.png', 'ارائه انواع تمرينات ورزشی خانگی و باشگاهی، دستور پخت غذاهای رژيمی، توصيه های تغذيه ای و مكمل های غذايی مجاز'),
    ];
    return Scaffold(
    backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width,
            child:
            Image.asset('assets/images/bg_intro.png',
            color: MyColors.green,
            fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
              height: screeenSize.height/3,

            ),
          ),
          PageView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: introWidgetsList.length,
                onPageChanged: (int page) {
                  getChangedPageAndMoveBar(page);
                },
                controller: _pageController,
                itemBuilder: (context, index) {
                  return introWidgetsList[index];
                },
              ),
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 35),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < introWidgetsList.length; i++)
                      if (i == currentPageValue) ...[circleBar(true)] else
                        circleBar(false),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child:   Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                FlatButton(onPressed:  (){Navigator.of(context).pushReplacementNamed('/language');},
                  child:    Text(currentPageValue!=3 ?'بیخیال': '',
                    style: TextStyle(
                        fontSize: 12*fontvar,
                        color:Colors.white
                    ),),
                    splashColor: Colors.transparent

                ),

              (currentPageValue!=3)?
              FlatButton(onPressed:(){
                _pageController.animateToPage(currentPageValue+1,duration: Duration(milliseconds: 150) ,curve: Curves.linear,);},
                  child: Text('بعدی',
                    style: TextStyle(
                        fontSize: 12*fontvar,
                        color:Colors.white
                    ),),
              splashColor: Colors.transparent,)

        : FlatButton(onPressed:  (){Navigator.of(context).pushReplacementNamed('/language');},
                    child:  Text('متوجه شدم',
                      style: TextStyle(
                          fontSize: 12*fontvar,
                          color:Colors.white
                      ),
                    ),
                    splashColor: Colors.transparent
                )



              ],
            ),
            margin: EdgeInsets.only(bottom: 25,right: 10,left: 10),
          )



        ],
      ),
    );



  }
  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150,),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: isActive ? 9 : 7,
      width: isActive ? 9 : 7,
      decoration: BoxDecoration(
          color: isActive ? Color(0xff234E6A) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
  Widget Screen(image,text) {
    Size screeenSize = MediaQuery.of(context).size;
    if(screeenSize.width>600)screeenSize=Size(600, screeenSize.height);

    return Stack(

     children: <Widget>[
       Container(
         alignment: Alignment.topCenter,
         margin: EdgeInsets.only(top: screeenSize.height/4),
         child: Image.asset(image,
           fit:BoxFit.contain ,
           height: screeenSize.height/3.3,


         ),
       ),
       Container(
         margin: EdgeInsets.only(bottom: 75,right: 15,left: 15),
         padding: EdgeInsets.symmetric(horizontal: 20),
         alignment: Alignment.bottomCenter,

         child: Text(
           text,
           style: TextStyle(
           fontSize: 15*fontvar,
               color:Colors.white
         ),
         textAlign: TextAlign.center,
         ),

       )


     ],
   );



 }



}