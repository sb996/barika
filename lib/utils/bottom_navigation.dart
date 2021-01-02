
import 'package:flutter/material.dart';


import 'SizeConfig.dart';
import 'colors.dart';

enum TabItem { home, profile, store , menu}

Map<TabItem, String> tabName = {
  TabItem.home: 'خانه',
  TabItem.profile: 'برنامه غذایی',
  TabItem.store: 'فروشگاه',
  TabItem.menu: 'منو',
};
class BottomNavigationc extends StatefulWidget {
  BottomNavigationc({this.currentTab, this.onSelectTab,this.tabController});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final TabController tabController;
  @override
  State<StatefulWidget> createState() => BottomNavigation();

}



class BottomNavigation extends State<BottomNavigationc>  {
   TabItem currentTab;
   ValueChanged<TabItem> onSelectTab;
   TabController tabController;

  @override
  void initState() {

    currentTab=widget.currentTab;
    onSelectTab=widget.onSelectTab;
    tabController=widget.tabController;
    tabController.addListener(_handleTabSelection);
    // TODO: implement initState
    super.initState();
  }
   void _handleTabSelection() {
     setState(() {

     });
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

     return Container(
      color: Colors.white,
      height: 60*(screenSize.width)/375,
      child: Stack(
        children: <Widget>[
      Container(
        height: 5*(screenSize.width)/375,
      decoration: BoxDecoration(
        color:  Colors.white,
          boxShadow: [new BoxShadow(
            color: Colors.black,
            blurRadius: 25.0,
            spreadRadius: .5
          ),])),
          Container(
           height: 55*(screenSize.width)/375,
           color: Colors.white,
           alignment: Alignment.center,

           child: TabBar(

            labelColor: Colors.green,
             labelPadding: EdgeInsets.all(0),

             unselectedLabelColor: Colors.grey,
             controller:tabController ,
             isScrollable: false,
             indicator: BoxDecoration(borderRadius: BorderRadius.circular(0)
             ),
             indicatorColor: Colors.transparent,
             indicatorPadding: EdgeInsets.all(0),
             onTap: (int index){

               if(index==0)   {
                 onSelectTab( TabItem.home);
               }
               if(index==1)   {
                 onSelectTab( TabItem.profile);
               }
               if(index==2)   {
                 onSelectTab( TabItem.store);
               }
               if(index==3)   {
                 onSelectTab( TabItem.values[3]);
                 tabController.animateTo(0);
               }


             },
             tabs: <Widget>[
           Container(
                   width: 40*(screenSize.width)/375,

                   height: 55*(screenSize.width)/375,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     mainAxisSize: MainAxisSize.max,

                     children: <Widget>[
                       Image.asset('assets/icons/btm_home.png',
                         width: 24*(screenSize.width)/375,
                         height: 21*(screenSize.width)/375,
                         color: tabController.index ==0  ? MyColors.green : MyColors.btmGray,
                       ),
                       Text(
                         'خانه',
                         style: TextStyle(
                           color:  tabController.index ==0  ? MyColors.green : MyColors.btmGray,
                           fontWeight:FontWeight.w400 ,    fontFamily:
                         "iransansDN",
                           fontSize: 10*fontvar,
                         ),
                       ),

                     ],
                   ),
                 ),


                  Container(
                     padding: EdgeInsets.only(left: 20),
                     width: 79*(screenSize.width)/375,
                     height: 55*(screenSize.width)/375,
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: <Widget>[

                         Image.asset('assets/icons/check.png',
                           width: 22*(screenSize.width)/375,
                           height: 21*(screenSize.width)/375,
                           color:  tabController.index ==1  ? MyColors.green : MyColors.btmGray,
                         ),
                         Text(
                           'برنامه غذایی',
                           style: TextStyle(
                             color:  tabController.index ==1  ? MyColors.green : MyColors.btmGray,
                             fontWeight:FontWeight.w400 ,    fontFamily:
                           "iransansDN",
                             fontSize: 9*fontvar,
                           ),
                         ),
                       ],

                   )),


//    Container(
//    width: 60,
//    height: 60,
//    ),
               // Right Tab Conbar icons

//    Row(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
               Container(
                     padding: EdgeInsets.only(right:20),
                     width: 65*(screenSize.width)/375,
                     height: 55*(screenSize.width)/375,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: <Widget>[
                         Image.network(
                           'assets/icons/btm_store.png',
                           width: 26*(screenSize.width)/375,
                           height: 20*(screenSize.width)/375,
                           color: tabController.index ==2  ? MyColors.green : MyColors.btmGray,
                         ),

                         Text(
                           'فروشگاه',
                           style: TextStyle(
                             color:  tabController.index ==2 ? MyColors.green : MyColors.btmGray,
                             fontWeight:FontWeight.w400 ,    fontFamily:
                           "iransansDN",
                             fontSize: 10*fontvar,
                           ),
                         ),
                       ],
                     ),
                   ),
              Container(
                     width: 40*(screenSize.width)/375,
                     height: 55*(screenSize.width)/375,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: <Widget>[

                         Padding(  padding: EdgeInsets.only(top: 15,),child:

                         Image.asset('assets/icons/btm_menu.png',
                           height: 5*(screenSize.width)/375,

                           color: tabController.index ==3 ? MyColors.green : MyColors.btmGray,
                         ),),
                         Text(
                           'منو',
                           style: TextStyle(
                             color:  tabController.index ==3  ? MyColors.green : MyColors.btmGray,
                             fontWeight:FontWeight.w400 ,    fontFamily:
                           "iransansDN",
                             fontSize: 10*fontvar,
                           ),
                         )
                       ],
                     ),
                   ),
             ],
           ),
         )
        ],
      )
    );




  }


}