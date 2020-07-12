import 'package:flutter/material.dart';
import 'package:hereme/Dashboard/Dashboard.dart';
import 'package:hereme/View/Sign_Up.dart';
import 'package:hereme/provider.dart';
import 'package:hereme/services/auth_service.dart';

import 'HomePage.dart';
void main() => runApp(MyApp());
final primaryColor = const Color(0xff393e47);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        child: MaterialApp(
          title: "HereWE",

          theme: ThemeData(
            primaryColor: primaryColor,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
            '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
            '/home': (BuildContext context) => MyHomePage(),
          },

        ));
  }


}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth =Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChange,
        builder: (context, AsyncSnapshot<String>snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            final bool signedIn = snapshot.hasData;
            return signedIn ? MainPage() : MyHomePage();
          }
          return CircularProgressIndicator();
        });
  }
}
