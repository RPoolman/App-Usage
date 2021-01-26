import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Stats.dart';

void main() => runApp(MaterialApp(
  home: LandingPage(),
));

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('App Tracker',style: TextStyle(color: Colors.grey[850],letterSpacing: 0.8, fontSize: 28,)),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                  '31.3%',
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
                  '62.3',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.devices_other,
                  color: Colors.tealAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  '-.-%',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.bar_chart,
                    color: Colors.tealAccent,
                    size: 200,
                  ),
                  Text(
                    'The Icon above will change to better represent your stats.',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Personal Stats'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatScreen()),
                      );
                    },
                  ),
                ],
            ),
          ],
        ),
      ),
    );
  }
}