import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserInfoPhoneScreen extends StatefulWidget {
  @override
  _UserInfoPhoneScreenState createState() => _UserInfoPhoneScreenState();
}

class _UserInfoPhoneScreenState extends State<UserInfoPhoneScreen> {
  final phoneNumberController = TextEditingController();
  String phoneNumber = 'Enter Mobile Phone Number';
  final maskFormatter = MaskTextInputFormatter(mask: '(###) ###-####');

  @override
  void initState() {
    phoneNumberController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Mobile Number',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            buildPhoneField(),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  print('PHONE NUMBER IS: ${phoneNumberController.text}');
                  setState(() {
                    phoneNumber = phoneNumberController.text;
                  });
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

  Widget buildPhoneField() => TextField(
        controller: phoneNumberController,
        inputFormatters: [
          maskFormatter,
        ],
        decoration: InputDecoration(
          hintText: '123-123-1234',
          labelText: 'Mobile Phone Number',
          labelStyle: TextStyle(color: Colors.teal),
          prefixIcon: Icon(
            Icons.add_ic_call_sharp,
            color: Colors.teal,
          ),
          suffixIcon: phoneNumberController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.teal,
                  ),
                  onPressed: () => phoneNumberController.clear(),
                ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.5),
              borderRadius: BorderRadius.circular(20.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.5),
              borderRadius: BorderRadius.circular(20.0)),
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
      );
}
