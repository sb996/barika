
import 'package:barika_web/models/unitSubAlbums.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class unitAlbumDialog extends StatefulWidget {

  unitSubAlbums unitsubAlbums;
  unitAlbumDialog(this.unitsubAlbums);

  State<StatefulWidget> createState() => unitAlbumDialogState();
}

class unitAlbumDialogState extends State<unitAlbumDialog> {
  int water;

  @override
  void initState() {

    super.initState();
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

    // TODO: implement build
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState
        /*You can rename this!*/) {
      return  Container(
            height: 350*(screenSize.width)/375,

      decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: screenSize.width,

       child:CustomScrollView(slivers: <Widget>[

         SliverList(

           delegate: SliverChildListDelegate(<Widget>[

           Column(
         mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           Card(
             margin: EdgeInsets.only(top: 5),
           elevation: 10,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(
           15.0),
         ),
         child:
        Padding(padding: EdgeInsets.all(10),child:  FadeInImage(
          placeholder: AssetImage(
              'assets/images/placeholder.png'),
          image: NetworkImage(widget.unitsubAlbums.cover),
          fit: BoxFit.fill,
          height: 150*(screenSize.width)/375,

        ),),),


            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                widget.unitsubAlbums.name,
                style: TextStyle(
                    color: Color(0xff334856),
                    fontSize: 15*fontvar,
                    fontWeight: FontWeight.w500),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15,right: 8,left: 8),
              child: Text(
                ' ${widget.unitsubAlbums.description}',
                style: TextStyle(
                    color: Color(0xff334856),
                    fontSize: 15*fontvar,
                    fontWeight: FontWeight.w400),
                textDirection: TextDirection.rtl,

              ),
            ),
          ],
        ),
        ])
      )
      ]  )  );
    });
  }
}
