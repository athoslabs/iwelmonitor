import 'package:flutter/material.dart';

class UserInfoGenderScreen extends StatefulWidget {
  const UserInfoGenderScreen({Key? key}) : super(key: key);

  @override
  _UserInfoGenderScreenState createState() => _UserInfoGenderScreenState();
}

class _UserInfoGenderScreenState extends State<UserInfoGenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gender'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Text('Gender Information'),
        ));
  }
}
