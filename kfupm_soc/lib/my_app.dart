import 'package:flutter/material.dart';
import 'package:kfupm_soc/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
