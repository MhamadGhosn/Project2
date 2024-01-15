import 'package:flutter/material.dart';
import 'addCustomer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cafe Ali',
        home: AddCustomer());
  }
}