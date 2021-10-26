import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFCADCED);

List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.white.withOpacity(0.5),
    spreadRadius: -5,
    offset: Offset(-5, -5),
    blurRadius: 30,
  ),
  BoxShadow(
    color: Colors.blue[900]!.withOpacity(.2),
    spreadRadius: 2,
    offset: Offset(7, 7),
    blurRadius: 20,
  )
];

List expenses = [
  {"name": "Groceries", "amount": 500.00},
  {"name": "Online Shopping", "amount": 100.00},
  {"name": "Eating Out", "amount": 80.00},
  {"name": "Bills", "amount": 50.00},
  {"name": "Subscriptions", "amount": 100.00},
  {"name": "Fees", "amount": 30.00}
];

List pieColors = [
  Colors.indigo[400],
  Colors.blue,
  Colors.green,
  Colors.amber,
  Colors.deepOrange,
  Colors.brown
];
