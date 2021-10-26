import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Dashboard2Screen extends StatefulWidget {
  Dashboard2Screen({Key? key, required this.cgmDeviceName}) : super(key: key);

  final String cgmDeviceName;

  @override
  _Dashboard2ScreenState createState() => _Dashboard2ScreenState();
}

class _Dashboard2ScreenState extends State<Dashboard2Screen> {
  // Create instance of stream controller
  StreamController _controller = StreamController();
  int _counter = 60;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void startTimer() async {
    // Timer method that runs every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      _counter--;

      // Add event/data to stream controller using sink
      _controller.sink.add(_counter);

      // Will stop count down when _counter value is 0
      if (_counter <= 0) {
        timer.cancel();
        _controller.close();
      }
    });
  }

  @override
  void dispose() {
    _controller.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.cgmDeviceName),
            StreamBuilder(
              initialData: _counter,
              stream: _controller.stream,
              builder: (context, snapshot) {
                return Text('${snapshot.data}');
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  startTimer();
                },
                child: Text('Start Count Down'))
          ],
        ),
      ),
    );
  }
}
