import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hereme/Dashboard/profile.dart';
import 'package:hereme/pages/Bottomhome.dart';
import 'package:hereme/pages/bottonbar.dart';
import 'package:hereme/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext context;
  int _currentIndex = 0;
  final List<Widget> _children = [
    botomhome(),
    ExplorePage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Here'),
        centerTitle: true,
        actions: <Widget>[
          /* IconButton(icon: Icon(Icons.favorite,color: Colors.white,),
              onPressed: (){
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) {
                  return gfavorates();
                }));
              }),
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              IconButton(icon: Icon(Icons.chat,color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) {
                      return gmessages();
                    }));
                  }),
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: Text("0",style: TextStyle(color: Colors.white,fontSize: 12.0),),
              )
            ],
          )*/
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("${snapshot.data.displayName}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            UserAccountsDrawerHeader(
              accountName: Text("Gautam_Yadav"),
              accountEmail: Text("Gautamyadav422@gmail.com"),
              currentAccountPicture: Image(
                image: AssetImage("images/here.webp"),

                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(
                "Order Notification",
              ),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  // return gcart();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(
                "Order History",
              ),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  // return ghistory();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(
                "Profile Setting",
              ),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  // return gprofile();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(
                "Delivery Address",
              ),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  // return gdelivery();
                }));
              },
            ),
            Divider(),
            ListTile(
              trailing: CircleAvatar(
                child: Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(
                "About Us",
              ),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  // return gabout();
                }));
              },
            ),
            ListTile(
              trailing: CircleAvatar(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(
                "Login",
              ),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  //  return glogin();
                }));
              },
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.explore),
              title: new Text("Explore"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
          ]
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


