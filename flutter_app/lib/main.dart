import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: LandingPage(),
));

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('App Tracker',style: TextStyle(color: Colors.orangeAccent,letterSpacing: 0.8)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Tracked: ',
                  style: TextStyle(color: Colors.tealAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
                SizedBox(height: 4),
                Text(
                  'Gerald Storm',
                  style: TextStyle(color: Colors.orangeAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Tracked by: ',
                  style: TextStyle(color: Colors.tealAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
                SizedBox(height: 4),
                Text(
                  'Ben Storm',
                  style: TextStyle(color: Colors.orangeAccent,letterSpacing: 2.0,fontSize: 18.0,),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.timer_sharp,
                  color: Colors.tealAccent,
                  size: 50,
                ),
                SizedBox(width: 10,),
                Text(
                  'Todays Usage: ',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 22,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.sports_soccer,
                  color: Colors.tealAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  '34.3%',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.message,
                  color: Colors.tealAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  '65.7%',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
            SizedBox(height: 40,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.bar_chart,
                    color: Colors.tealAccent,
                    size: 200,
                  ),
                ]
            )
          ],
        ),
      ),
    );
  }
}