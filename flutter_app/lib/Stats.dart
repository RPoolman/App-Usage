import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'pullData.dart';

class StatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('App Tracker',style: TextStyle(color: Colors.white,letterSpacing: 0.8, fontSize: 28,)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.person), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatScreen()),
              );},
            ),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.list_alt), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceApps()),
              );},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Gerald Storm',
                      style: TextStyle(color: Colors.indigo,letterSpacing: 2.0,fontSize: 22.0,),
                    ),
                    SizedBox(height: 20),
                    Icon(
                      Icons.timer_sharp,
                      color: Colors.redAccent,
                      size: 50,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Daily Usage: ',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    Flexible(child: Text(
                      'Daily usage will consist of a dropdown box that contains a list of all(or atleast top 10) the applications that are in use, you can open the drop down to display what app you want to see.',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),)
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text(
                      'Weekly Usage: ',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    Flexible(child: Text(
                      'Weekly usage is yet to be defined as to what exactly it will display and show.',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
