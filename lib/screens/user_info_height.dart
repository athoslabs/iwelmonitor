import 'package:flutter/material.dart';

class UserInfoHeightScreen extends StatelessWidget {
  const UserInfoHeightScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Height'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('Help Sharing My Data here'),
      ),
    );
  }
}
