import 'package:flutter/material.dart';

class UserInfoHistoryScreen extends StatefulWidget {
  const UserInfoHistoryScreen({Key? key}) : super(key: key);

  @override
  _UserInfoHistoryScreenState createState() => _UserInfoHistoryScreenState();
}

class _UserInfoHistoryScreenState extends State<UserInfoHistoryScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Family History'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                    'Enter your family history of diabetes in the field below.'),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Enter Family Diabetes History Here',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
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
        ));
  }
}
