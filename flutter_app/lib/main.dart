import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Stats.dart';
import 'deviceVars.dart';
import 'dataChart.dart';

void main() { runApp(MaterialApp(home: LandingPage()));}
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
class _LandingPageState extends State<LandingPage> {
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('App Tracker',style: TextStyle(color: Colors.grey[850],letterSpacing: 0.8, fontSize: 28,)), //this line TextStyle
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body:
      Padding(
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
                  Icons.app_blocking,
                  color: Colors.tealAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  GlobalData.app1Time,
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.app_blocking,
                  color: Colors.tealAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  GlobalData.app2Time,
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.app_blocking,
                  color: Colors.tealAccent,
                  size: 30,
                ),
                SizedBox(width: 10,),
                Text(
                  GlobalData.app3Time,
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
                SizedBox(height:250, child: PointsLineChart(PointsLineChart.createSampleData(), animate: false)),
                Text(
                  'Graph will update once you refresh data.',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.grey[850]),
                  ),
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
