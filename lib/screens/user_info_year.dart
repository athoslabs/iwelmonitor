import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoYearScreen extends StatefulWidget {
  const UserInfoYearScreen({Key? key}) : super(key: key);

  @override
  _UserInfoYearScreenState createState() => _UserInfoYearScreenState();
}

class _UserInfoYearScreenState extends State<UserInfoYearScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosed Year'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Text('Select the date you were diagnosed'),
            ),
            SizedBox(
              height: 40,
            ),
            buildDatePicker(),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          minimumYear: 1900,
          maximumYear: DateTime.now().year,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}
