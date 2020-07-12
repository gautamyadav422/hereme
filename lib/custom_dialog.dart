import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
 class customDialog extends StatelessWidget {
   final primaryColor = const Color(0xff393e47);
   final SecondaryColor = const Color(0xff64c3c4);
   final String title, description, primarybuttontext, primarybuttonroute, secondarybuttontext, secondarybuttonroute;

   customDialog({
     @required this.title,
     @required this.description,
     @required this.primarybuttonroute,
     @required this.primarybuttontext,
     this.secondarybuttonroute,
     this.secondarybuttontext,
 });

   static const double padding = 20.0;
   @override
   Widget build(BuildContext context) {
     return Dialog(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(padding),
       ),
       child: Stack(
         children: <Widget>[
           Container(
             padding: EdgeInsets.all(padding),
             decoration: BoxDecoration(
               color: primaryColor,
               shape: BoxShape.rectangle,
               borderRadius: BorderRadius.circular(padding),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black,
                   blurRadius: 10.0,
                   offset: const Offset(0.0, 10.0),
                 ),
               ]
             ),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 SizedBox(height: 24.0,),
                 AutoSizeText(
                   title,maxLines: 2,
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 25.0,
                   ),
                 ),
                 SizedBox(height: 24.0,),
                 AutoSizeText(
                   description,maxLines: 4,
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 18.0,
                   ),
                 ),
                 SizedBox(height: 24.0,),
                 RaisedButton(
                   color: SecondaryColor,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                   child: AutoSizeText(
                     primarybuttontext,
                     maxLines: 1,
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       ),
                   ),
                   onPressed: (){
                     Navigator.of(context).pop();
                     Navigator.of(context).pushReplacementNamed(primarybuttonroute);
                   },
                 ),
                 SizedBox(height: 10.0,),
                 showsecondaryButton(context)
               ],
             ),
           ),
         ],
       ),
     );
   }

   showsecondaryButton(BuildContext context) {
     if(secondarybuttonroute != null && secondarybuttontext !=null){
       return FlatButton(
         child: AutoSizeText(
           secondarybuttontext,
           maxLines: 1,
           style: TextStyle(
             fontSize: 18.0,color: Colors.white,
             fontWeight: FontWeight.bold,
           ),
         ),
         onPressed: (){
           Navigator.of(context).pop();
           Navigator.of(context).pushReplacementNamed(secondarybuttonroute);
         },
       );
     }else{
       return SizedBox(height: 10.0,);
     }

   }
 }
