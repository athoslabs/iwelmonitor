import 'package:flutter/material.dart';
import 'package:iwelmonitor/models/checkbox_state.dart';

class UserInfoHabitsScreen extends StatefulWidget {
  @override
  _UserInfoHabitsScreenState createState() => _UserInfoHabitsScreenState();
}

class _UserInfoHabitsScreenState extends State<UserInfoHabitsScreen> {
  final selections = [
    CheckBoxState(title: 'Smoking'),
    CheckBoxState(title: 'Drinking'),
    CheckBoxState(title: 'Alcoholism'),
    CheckBoxState(title: 'Overeating'),
    CheckBoxState(title: 'Regular Lifestyle'),
    CheckBoxState(title: 'Have Meals Regularly'),
    CheckBoxState(title: 'Stay Up Late'),
    CheckBoxState(title: 'Sloppy Lifestyle'),
    CheckBoxState(title: 'Clean Lifestyle'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Living Habits'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: ListView(
          padding: EdgeInsets.all(40),
          children: [
            ...selections.map(buildSingleCheckbox).toList(),
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
        ));
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        activeColor: Colors.teal,
        value: checkbox.value,
        title: Text(
          checkbox.title,
          style: TextStyle(fontSize: 18),
        ),
        onChanged: (value) => setState(() => checkbox.value = value!),
      );
}
