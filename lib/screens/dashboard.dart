import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:iwelmonitor/models/DeviceReading.dart';

import 'package:iwelmonitor/widgets/login.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:iwelmonitor/widgets/navigation_drawer_widget.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/bluetoothLE.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen(
      {Key? key, required this.cgmDeviceName, required this.device})
      : super(key: key);

  final String cgmDeviceName;
  final BluetoothDevice device;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthUser? _user;

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  late double gaugeValue = 0;
  late String gaugeReading = '';
  late bool isReady;
  late int cgmReading = 0;
  late int fastingNumber = 0;
  late double constantNumber = 1.1;
  late int glucoseNumber = 0;
  late double intervalAverageNumber = 1;
  late Icon trendingIcon = Icon(Icons.arrow_forward_outlined);
  bool isFirstTime = true;
  bool isCalibrating = true;

  late StreamSubscription _subscription;

  late BluetoothDeviceState deviceState;

  Future<void> _getUser() async {
    await Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future createAlertFastingNumber(BuildContext context) {
    TextEditingController dialogController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Fasting Number'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: dialogController,
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(dialogController.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _getUser();

    chartData = getChartData();
    Timer.periodic(const Duration(minutes: 3), updateDataSource);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      createAlertFastingNumber(context).then((onValue) {
        fastingNumber = int.parse(onValue);
        print('FASTING VALUE IS: $fastingNumber');
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Device: ${widget.cgmDeviceName}',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.teal,
        actions: [
          MaterialButton(
            onPressed: () {
              widget.device.disconnect();
              Amplify.DataStore.clear();
              Amplify.Auth.signOut().then((_) {
                // Navigator.pushReplacementNamed(context, '/login');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              });
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_user == null)
                Text('Loading...')
              else ...[
                // Text('Hello'),

                // Text('Connected Device: ${widget.cgmDeviceName}'),
                // SizedBox(
                //   height: 5,
                // ),
                //Text(_user!.userId),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/iwel_logo_sm.png',
                          width: 60,
                          height: 60,
                        )),
                    Text('CONTINUOUS GLUCOSE MONITORING',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400)),
                    // Text(_user!.username),

                    Container(
                      height: 275,
                      width: 165,
                      child: SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                            showLabels: false,
                            minimum: 40,
                            maximum: 400,
                            showTicks: false,
                            // interval: 10,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 40,
                                  endValue: 80,
                                  color: Colors.blue),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 80,
                                  endValue: 115,
                                  color: Colors.greenAccent),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 115,
                                  endValue: 150,
                                  color: Colors.green),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 150,
                                  endValue: 180,
                                  color: Colors.deepOrange),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 180,
                                  endValue: 215,
                                  color: Colors.pink),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 215,
                                  endValue: 250,
                                  color: Colors.red),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 215,
                                  endValue: 250,
                                  color: Colors.red),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 250,
                                  endValue: 280,
                                  color: Colors.purple),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 280,
                                  endValue: 315,
                                  color: Colors.deepPurpleAccent),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 315,
                                  endValue: 350,
                                  color: Colors.deepPurple),
                              GaugeRange(
                                  startWidth: 30,
                                  endWidth: 30,
                                  startValue: 350,
                                  endValue: 400,
                                  color: Colors.deepPurple),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                // knobStyle: KnobStyle(color: Colors.teal),
                                needleLength: .80,
                                needleEndWidth: 6.0,
                                // needleColor: Colors.teal,
                                enableAnimation: true,
                                value: gaugeValue,
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Column(
                                    children: [
                                      SizedBox(
                                        height: 170,
                                      ),
                                      Text(
                                        'Now',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (isCalibrating
                                              ? Text(
                                                  'Activating',
                                                  style: TextStyle(
                                                      height: .95,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  gaugeReading,
                                                  style: TextStyle(
                                                      height: .95,
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          if (gaugeValue > 0)
                                            trendingIcon
                                          else
                                            Text(' '),
                                        ],
                                      ),
                                      Text(
                                        'mg/dl',
                                        style: TextStyle(
                                            height: .75,
                                            fontSize: 12,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  angle: 90,
                                  positionFactor: 0.5)
                            ]),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 20, top: 60),
                      child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          height: 225,
                          child: SfCartesianChart(
                              series: <LineSeries<LiveData, int>>[
                                LineSeries<LiveData, int>(
                                  enableTooltip: true,
                                  onRendererCreated:
                                      (ChartSeriesController controller) {
                                    _chartSeriesController = controller;
                                  },
                                  dataSource: chartData,
                                  color: const Color.fromRGBO(192, 108, 132, 1),
                                  xValueMapper: (LiveData currentTime, _) =>
                                      currentTime.time,
                                  yValueMapper: (LiveData current, _) =>
                                      current.reading,
                                )
                              ],
                              enableAxisAnimation: true,
                              primaryXAxis: NumericAxis(
                                  autoScrollingMode: AutoScrollingMode.end,
                                  majorGridLines:
                                      const MajorGridLines(width: 1),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 3,
                                  title: AxisTitle(text: 'Time Interval')),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  title: AxisTitle(text: 'Reading')))),
                    )
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _scanForServices() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      print('${service.characteristics.toString()}');
      _readCharacteristics(service);
    });
  }

  void _readCharacteristics(BluetoothService service) async {
    // Reads all characteristics
    var characteristics = service.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      if (c.uuid.toString() == '0000ffb1-0000-1000-8000-00805f9b34fb') {
        List<int> value = await c.read();
        print('The VALUE IS: ${value.first}');
        cgmReading = value.first;
        String timeTaken = DateTime.now().toString();
        var user = _user!.userId;
        String cgmDeviceName = widget.cgmDeviceName;

        DeviceReading newDeviceReading = DeviceReading(
          glucoseNumber: cgmReading,
          userId: user,
          timeTaken: DateTime.now().toString(),
        );
        print(widget.cgmDeviceName);
        //cgmDeviceName: cgmDeviceName);

        try {
          await Amplify.DataStore.save(newDeviceReading);
        } catch (e) {
          print('An error occurred while saving Device Reading: $e');
        }

        setState(() {
          if (glucoseNumber == gaugeValue) {
            trendingIcon = Icon(
              Icons.arrow_forward_outlined,
              size: 50,
            );
          } else if (glucoseNumber < gaugeValue) {
            trendingIcon = Icon(
              Icons.trending_down_outlined,
              size: 50,
            );
          } else if (glucoseNumber > gaugeValue) {
            trendingIcon = Icon(
              Icons.trending_up_outlined,
              size: 50,
            );
          }
        });
      }
    }
  }

  // double num = 0;
  // void _gatherReadings(Timer timer) async {
  //   for (int i = 0; i < 16; i++) {
  //     await new Future.delayed(const Duration(milliseconds: 11250));
  //     _scanForServices();
  //     num += cgmReading;
  //   }
  //   num = num / 16;
  //   print('THE AVERAGE IS: $num');
  //   updateDataSource();
  // }

  int time = 19;
  double num = 0;
  void updateDataSource(Timer timer) async {
    // _scanForServices();
    // chartData.add(LiveData(time++, cgmReading));
    await widget.device.disconnect().then((_) async => {
          await widget.device
              .connect(autoConnect: true, timeout: Duration(seconds: 30))
              .then((_) => {
                    num = 0,
                    for (int i = 0; i < 16; i++)
                      {
                        Future.delayed(const Duration(milliseconds: 11250)),
                        _scanForServices(),
                        print('THE CGM READING NUMBER IS: $cgmReading'),
                        num += cgmReading
                      },
                    intervalAverageNumber = num / 16,
                    if (isFirstTime)
                      {
                        if (intervalAverageNumber > 0)
                          {
                            constantNumber =
                                (fastingNumber / intervalAverageNumber),
                            isFirstTime = false
                          }
                        else
                          {constantNumber = 1.1},
                      },
                    print('FIRST CONSTANT NUMBER IS: $constantNumber'),
                    glucoseNumber =
                        (intervalAverageNumber * constantNumber).round(),
                    isCalibrating = false,
                    print('INTERVAL AVERAGE NUMBER IS: $intervalAverageNumber'),
                    print('CONSTANT NUMBER IS: $constantNumber'),
                    print('GLUCOSE NUMBER IS: $glucoseNumber')
                  }),
          // chartData.add(LiveData(time++, cgmReading))
          chartData.add(LiveData(time++, glucoseNumber))
        });
    // await widget.device.connect(autoConnect: true).then((_) => {
    // _scanForServices();
    // chartData.add(LiveData(time++, (math.Random().nextInt(60) + 80)));
    // chartData.add(LiveData(time++, cgmReading));

    //_chartSeriesController.updateDataSource(addedDataIndex: chartData.length - 1);

    setState(() {
      if (glucoseNumber == gaugeValue) {
        trendingIcon = Icon(
          Icons.arrow_forward_outlined,
          size: 60,
        );
      } else if (glucoseNumber < gaugeValue) {
        trendingIcon = Icon(
          Icons.arrow_downward_outlined,
          size: 60,
        );
      } else if (glucoseNumber > gaugeValue) {
        trendingIcon = Icon(
          Icons.arrow_upward_outlined,
          size: 60,
        );
      }
      gaugeValue = chartData.last.reading.toDouble();
      gaugeReading = chartData.last.reading.toString();
    });
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 0),
      // LiveData(1, 0),
      // LiveData(2, 0),
      // LiveData(3, 0),
      // LiveData(4, 0),
      // LiveData(5, 0),
      // LiveData(6, 0),
      // LiveData(7, 0),
      // LiveData(8, 0),
      // LiveData(9, 0),
      // LiveData(10, 0),
      // LiveData(11, 0),
      // LiveData(12, 0),
      // LiveData(13, 0),
      // LiveData(14, 0),
      // LiveData(15, 0),
      // LiveData(16, 0),
      // LiveData(17, 0),
      // LiveData(18, 0)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.reading);
  final int time;
  final num reading;
}
