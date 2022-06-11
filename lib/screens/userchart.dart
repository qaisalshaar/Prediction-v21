import 'package:dagnosis_and_prediction/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(UserChart());
}

class UserChart extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@override
late TooltipBehavior _tooltipBehavior;

// @override
// void initState() {
//   _tooltipBehavior = TooltipBehavior(enable: true);
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<PatientData> chartData;
  // late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.red),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AdminScreen()));
                },
              ),
            ),
            body: Container(
                child: SfCartesianChart(
                    title: ChartTitle(text: 'Glucose Rate Reading analysis'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    // Initialize category axis
                    // primaryXAxis: CategoryAxis(),
                    primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 2),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Day')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 2),
                        associatedAxisName: 'jjjj',
                        majorTickLines: const MajorTickLines(size: 20),
                        title: AxisTitle(text: 'Glucose Rate')),
                    series: <ChartSeries>[
                  // Initialize line series
                  LineSeries<PatientData, String>(
                      dataSource: [
                        // Bind data source
                        PatientData('10/10/2020', 222),
                        PatientData('15/10/2020', 232),
                        PatientData('20/10/2020', 210),
                        PatientData('30/10/2020', 207),
                        PatientData('05/11/2020', 257),
                        PatientData('10/11/2020', 217),
                        PatientData('15/11/2020', 251),
                        PatientData('20/11/2020', 280),
                        PatientData('30/11/2020', 260),
                        PatientData('07/12/2020', 255),
                        PatientData('13/12/2020', 240),
                        PatientData('23/12/2020', 253),
                        PatientData('29/12/2020', 251),
                        PatientData('08/01/2021', 225),
                        PatientData('17/01/2021', 230),
                      ],
                      xValueMapper: (PatientData data, _) => data.day,
                      yValueMapper: (PatientData data, _) => data.glucose,

                      // Render the data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]))));
  }

  List<PatientData> getChartData() {
    return <PatientData>[
      PatientData('10/10/2020', 222),
      PatientData('15/10/2020', 232),
      PatientData('20/10/2020', 210),
      PatientData('30/10/2020', 207),
      PatientData('05/11/2020', 257),
      PatientData('10/11/2020', 217),
      PatientData('15/11/2020', 251),
      PatientData('20/11/2020', 280),
      PatientData('30/11/2020', 260),
      PatientData('07/12/2020', 255),
      PatientData('13/12/2020', 240),
      PatientData('23/12/2020', 253),
      PatientData('29/12/2020', 251),
      PatientData('08/01/2021', 225),
      PatientData('17/01/2021', 230),

      // PatientData(0, 42),
      // PatientData(1, 47),
      // PatientData(2, 43),
      // PatientData(3, 49),
      // PatientData(4, 54),
      // PatientData(5, 41),
      // PatientData(6, 58),
      // PatientData(7, 51),
      // PatientData(8, 98),
      // PatientData(9, 41),
      // PatientData(10, 53),
      // PatientData(11, 72),
      // PatientData(12, 86),
      // PatientData(13, 52),
      // PatientData(14, 94),
      // PatientData(15, 92),
      // PatientData(16, 86),
      // PatientData(17, 72),
      // PatientData(18, 94)
    ];
  }
}

class PatientData {
  PatientData(this.day, this.glucose);
  final String day;
  final int glucose;
}
