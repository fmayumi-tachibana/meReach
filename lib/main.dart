import 'package:flutter/material.dart';
import 'package:mereach/services/service_locator.dart';
import 'package:mereach/ui/views/servers_screen.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meReach',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.green,
      ),
      home: ServersScreen(),
    );
  }
}
