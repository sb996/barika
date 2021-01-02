
import 'package:barika_web/models/allExersice.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'clubExercise.dart';
import 'homeExercise.dart';

class ExerciseScreen extends StatefulWidget {
  String acountDate;
  @override
  ExerciseScreen({Key key,this.acountDate}) : super(key: key);

  State<StatefulWidget> createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> with SingleTickerProviderStateMixin {

  List<allExercise> _allExercise = [];
  List<allExercise> homeExercises =[];
  List<allExercise> clubExercises =[];
  TabController tabController;
  String acountDate;
  void initState() {
    acountDate=widget.acountDate;
    super.initState();
    tabController = new TabController(initialIndex: 1, length: 2, vsync: this);
  }
  double fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;
    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    return Scaffold(

      appBar: new PreferredSize(
        preferredSize: Size.fromHeight( 120),
        child: new Container(
          padding: EdgeInsets.only(top: 10),
          decoration: new BoxDecoration(
          color: MyColors.green
          ),
          child: new SafeArea(

            child: Column(
              children: <Widget>[
                 Stack(
                    alignment: AlignmentDirectional.centerEnd,
                  fit: StackFit.loose,
                  children: <Widget>[
                 Align(alignment: Alignment.centerLeft,
                   child:    IconButton(icon: Icon(Icons.chevron_right,
                     size:32,),
                   onPressed: (){Navigator.of(context).pop();},
                   alignment: Alignment.topLeft,
                   color: Colors.white,
                   splashColor: Colors.amber,
                   padding: EdgeInsets.all(7),
                 ),),

                      Container(padding: EdgeInsets.only(top: 12,bottom: 8),
                         alignment: Alignment.center,

                         child:   Text('تمرین های ورزشی',
                           style: TextStyle(
                             color: Colors.white,
                             fontWeight:FontWeight.w700 ,
                             fontSize: 16*fontvar,
                           ),
                           textAlign: TextAlign.center,),
                       ),


//                    IconButton(icon: Icon(Icons.search,size:28,),
//                      onPressed: (){},
//                      alignment: Alignment.topRight,
//                      color: Colors.white,
//                      splashColor: Colors.amber,
//                      padding: EdgeInsets.all(10),
//                    )


                  ],
                ),
             Expanded(
              child: TabBar(
                controller: tabController,

                tabs: <Widget>[
                  new Tab(
                    child: Text(
                      'تمرینات خانگی',  style:TextStyle(
                        color: Colors.white,
                        fontSize:15*fontvar ,
                        fontWeight:FontWeight.w400
                    ), textAlign: TextAlign.center,
                    ),
                  ),
                  new Tab(
                    child: Text(
                      'تمرینات باشگاه',  style:TextStyle(
                        color: Colors.white,
                        fontSize:15*fontvar ,
                        fontWeight:FontWeight.w400
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                ])),
              ],
            ),
          ),
        ),
      ),
      body:

  new TabBarView(
         controller: tabController, children: <Widget>[
       homeExercise(acountDate: acountDate,),
       clubExercise(acountDate: acountDate,),
     ]));}






}

