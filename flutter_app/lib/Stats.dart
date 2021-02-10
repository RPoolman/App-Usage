import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'pullData.dart';

class StatScreen extends StatelessWidget {
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
                Column(
                  children: [
                    Text(
                      'Gerald Storm',
                      style: TextStyle(color: Colors.orangeAccent,letterSpacing: 2.0,fontSize: 22.0,),
                    ),
                    SizedBox(height: 20),
                    Icon(
                      Icons.timer_sharp,
                      color: Colors.tealAccent,
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
                        color: Colors.orangeAccent,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    Flexible(child: Text(
                      'Daily usage will consist of a dropdown box that contains a list of all(or atleast top 10) the applications that are in use, you can open the drop down to display what app you want to see.',
                      style: TextStyle(
                        color: Colors.orangeAccent,
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
                        color: Colors.orangeAccent,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    Flexible(child: Text(
                      'Weekly usage is yet to be defined as to what exactly it will display and show.',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),)
                  ],
                ),
                SizedBox(height: 40,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.grey[850]),
                  ),
                  child: Text('Overview'),
                  onPressed: () { Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => landingPage()),
                                  ); },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.grey[850]),
                  ),
                  child: Text('View Apps'),
                  onPressed: () { Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DeviceApps()),
                                    ); },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
