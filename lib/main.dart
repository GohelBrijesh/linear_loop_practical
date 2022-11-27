import 'package:flutter/material.dart';
import 'package:linear_loop_practical/screenUI/number_enter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Linear Loop Demo',
      home: NumberEnterScreen(),
    );
  }
}