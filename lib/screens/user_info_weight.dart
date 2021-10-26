import 'package:flutter/material.dart';

class UserInfoWeightScreen extends StatelessWidget {
  const UserInfoWeightScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('Help Sharing My Data here'),
      ),
    );
  }
}
