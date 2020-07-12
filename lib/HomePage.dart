
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hereme/custom_dialog.dart';


class MainPage extends StatelessWidget {
  final primaryColor = const Color(0xff393e47);
  final secondaryColor = const Color(0xff64c3c4);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(

          child: Column(
            children: <Widget>[
              SizedBox(height: _height *0.10,),
              Container(
                height: 100,
                child: Image(image: AssetImage("images/here.webp"),
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ),
              SizedBox(height: _height*0.10,),
              AutoSizeText("Let's Start with Planing next",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40,color: Colors.white),),
              SizedBox(height: _height * 0.20,),
              RaisedButton(
                color: secondaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 30.0,right: 30.0),
                  child: Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w300),),
                ),
                onPressed: (){
                  showDialog(context: context,
                    builder: (BuildContext context)=>customDialog(
                      title: "Would You Like to Create free Account",
                      description: "with a account your data will be securely saved, allowed me to access the data",
                      primarybuttontext: "Create My Account",
                      primarybuttonroute: "/signUp",
                      secondarybuttontext: "May be later",
                      secondarybuttonroute: "/home",
                    ),
                  );

                },
              ),
              SizedBox(height: 15,),
              FlatButton(
                child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 25),),
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('/signIn');

                },
              )
            ],
          ),
        ),
      ),
    );

  }
}
