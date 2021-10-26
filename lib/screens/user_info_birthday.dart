import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoBirthdayScreen extends StatefulWidget {
  const UserInfoBirthdayScreen({Key? key}) : super(key: key);

  @override
  _UserInfoBirthdayScreenState createState() => _UserInfoBirthdayScreenState();
}

class _UserInfoBirthdayScreenState extends State<UserInfoBirthdayScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Birthday'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Text('Select Your Date of Birth'),
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
