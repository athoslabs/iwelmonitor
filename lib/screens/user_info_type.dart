import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoTypeScreen extends StatefulWidget {
  const UserInfoTypeScreen({Key? key}) : super(key: key);

  @override
  _UserInfoTypeScreenState createState() => _UserInfoTypeScreenState();
}

class _UserInfoTypeScreenState extends State<UserInfoTypeScreen> {
  int index = 0;

  static List<String> types = [
    '22',
    'Healthy People',
    'IGT',
    'Type 1',
    'Type 2'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes Type'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            child: Text('Select Your Diabetes Type'),
          ),
          buildCustomPicker(),
          SizedBox(
            height: 24,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'SAVE',
                style: TextStyle(fontSize: 18),
              ))
        ],
      )),
    );
  }

  Widget buildCustomPicker() => SizedBox(
        height: 180,
        child: CupertinoPicker(
          itemExtent: 64,
          onSelectedItemChanged: (index) => setState(() => this.index = index),
          children: modelBuilder<String>(types, (index, type) {
            return Center(
              child: Text(
                type,
              ),
            );
          }),
        ),
      );

  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
