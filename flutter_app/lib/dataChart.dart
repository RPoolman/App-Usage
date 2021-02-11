import 'package:flutter/material.dart';
import 'deviceVars.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PointsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  PointsLineChart(this.seriesList, {this.animate});
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      createSampleData(),
      animate: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }
  static List<charts.Series<LinearApps, int>> createSampleData() {
    final data = [
      new LinearApps(0, -1),
      new LinearApps(1, -1),
      new LinearApps(2, -1),
      new LinearApps(3, -1),
      new LinearApps(4, -1),
    ];
    for(int appPos = 0; appPos < 5; appPos++) {
      data[appPos] = new LinearApps(appPos+1, GlobalData.appsGraph[4-appPos]);
    }
    return [
      new charts.Series<LinearApps, int>(
        id: 'Usage',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        measureFn: (LinearApps time, _) => time.appDur,
        domainFn: (LinearApps number, _) => number.appNo,
        data: data,
      )
    ];
  }
}
class LinearApps {
  final int appNo;
  final int appDur;
  LinearApps(this.appNo, this.appDur);
}