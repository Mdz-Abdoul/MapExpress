import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class PageFooter extends StatefulWidget {
  const PageFooter({super.key});

  @override
  State<PageFooter> createState() => _PageFooterState();
}

class _PageFooterState extends State<PageFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Color(0xFF1F72A5), // Définissez la couleur de fond du Container pour le Footer
      child: Footer(
        backgroundColor:  Color(0xFF1F72A5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Le reste de votre contenu ici
            Text(' ©2022,  MapExpress. جميع الحقوق محفوظة',style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0, color: Colors.white),),
          ],
        ),
      ),
    );

    // return Container(
    //   height: 50,
    //   color: Color(0xFF1F72A5),
    //   child: Footer(
    //           child: Column(
                
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children:<Widget>[
    //               // new Center(
    //               //   child:new Row(
    //               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               //     children: <Widget>[
    //               //       new Container(
    //               //         height: 45.0,
    //               //         width: 45.0,
    //               //         child: Center(
    //               //           child:Card(
    //               //             elevation: 5.0,
    //               //             shape: RoundedRectangleBorder(
    //               //               borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
    //               //             ),
    //               //             child: IconButton(
    //               //               icon: new Icon(Icons.audiotrack,size: 20.0,),
    //               //               color: Color(0xFF162A49),
    //               //               onPressed: () {},
    //               //             ),
    //               //           ),
    //               //         )
    //               //       ),
    //               //       new Container(
    //               //         height: 45.0,
    //               //         width: 45.0,
    //               //         child: Center(
    //               //           child:Card(
    //               //             elevation: 5.0,
    //               //             shape: RoundedRectangleBorder(
    //               //               borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
    //               //             ),
    //               //             child: IconButton(
    //               //               icon: new Icon(Icons.fingerprint,size: 20.0,),
    //               //               color: Color(0xFF162A49),
    //               //               onPressed: () {},
    //               //             ),
    //               //           ),
    //               //         )
    //               //       ),
    //               //       new Container(
    //               //         height: 45.0,
    //               //         width: 45.0,
    //               //         child: Center(
    //               //           child:Card(
    //               //             elevation: 5.0,
    //               //             shape: RoundedRectangleBorder(
    //               //               borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
    //               //             ),
    //               //             child: IconButton(
    //               //               icon: new Icon(Icons.call,size: 20.0,),
    //               //               color: Color(0xFF162A49),
    //               //               onPressed: () {},
    //               //             ),
    //               //           ),
    //               //         )
    //               //       ),
    //               //     ],
    //               //   ),
    //               // ),

    //               Text(' ©2020,  MapExpress. ماب اكسبريس',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Colors.white),),
    //               // Text('Powered by Nexsport',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0,color: Color(0xFF162A49)),),
    //             ]
    //           ),
            
    //       ),);
  }
}